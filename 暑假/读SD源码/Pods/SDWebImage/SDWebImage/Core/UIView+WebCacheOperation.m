/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIView+WebCacheOperation.h"
#import "objc/runtime.h"

static char loadOperationKey;

// key is strong, value is weak because operation instance is retained by SDWebImageManager's runningOperations property
// we should use lock to keep thread-safe because these method may not be accessed from main queue
typedef NSMapTable<NSString *, id<SDWebImageOperation>> SDOperationsDictionary;

@implementation UIView (WebCacheOperation)

// 获取关联对象：operations（用来存放操作的字典）
- (SDOperationsDictionary *)sd_operationDictionary {
    @synchronized(self) { // 使用 @synchronized 确保在多线程环境下操作的线程安全性
        SDOperationsDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey); // 尝试从当前对象中获取关联的操作字典
        if (operations) { // 如果已存在操作字典
            return operations; // 直接返回操作字典
        }
        operations = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0]; // 如果操作字典不存在，创建一个新的 NSMapTable 实例，键使用强引用，值使用弱引用
        objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC); // 将新创建的操作字典与当前对象关联，并设置为非原子性的强引用
        return operations;  // 返回新创建的操作字典
    }
}

- (nullable id<SDWebImageOperation>)sd_imageLoadOperationForKey:(nullable NSString *)key  {
    id<SDWebImageOperation> operation;
    if (key) {
        SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
        @synchronized (self) {
            operation = [operationDictionary objectForKey:key];
        }
    }
    return operation;
}

//重点方法
//设置图像加载操作，使用一个字典存储key和对应的操作
- (void)sd_setImageLoadOperation:(nullable id<SDWebImageOperation>)operation forKey:(nullable NSString *)key {
    if (key) {  // 检查传入的 key 是否为空，只有 key 不为空时才继续执行
        [self sd_cancelImageLoadOperationWithKey:key]; // 先取消之前可能存在的相同 key 的图片加载操作，防止重复操作
        if (operation) { // 检查传入的 operation 是否为空，只有 operation 不为空时才继续执行
            SDOperationsDictionary *operationDictionary = [self sd_operationDictionary]; // （这里方法点进去看）获取当前对象关联的操作字典，用于保存操作对象 //typedef NSMapTable<NSString *, id<SDWebImageOperation>> SDOperationsDictionary;
            @synchronized (self) { //确保在多线程环境下操作字典的线程安全性
                [operationDictionary setObject:operation forKey:key]; // 将新的 operation 添加到操作字典中，并与传入的 key 相关联
            }
        }
    }
}

- (void)sd_cancelImageLoadOperationWithKey:(nullable NSString *)key {
    // 如果 key 不为空，才进行取消操作
    if (key) {
        // 获取保存所有加载操作的字典
        SDOperationsDictionary *operationDictionary = [self sd_operationDictionary]; //SDOperationsDictionary 是一种专门用于管理图片加载操作的字典类型，键为 NSString，通常是某个操作的唯一标识符，值是一个符合 SDWebImageOperation 协议的对象，代表具体的图片加载操作。
           //SDOperationsDictionary是NSMapTable类型，不同于 NSDictionary，NSMapTable 允许更灵活的内存管理选项，如弱引用（weak）键或值，避免强引用导致的内存泄漏。
        id<SDWebImageOperation> operation;
        
        // 使用 @synchronized 来确保在多线程环境下操作字典的安全性
        @synchronized (self) {
            // 从字典中根据 key 查找对应的操作
            operation = [operationDictionary objectForKey:key];
        }
        // 如果找到了对应的操作
        if (operation) {
            // 检查操作是否遵循 SDWebImageOperation 协议
            if ([operation conformsToProtocol:@protocol(SDWebImageOperation)]) {
                // 调用操作的 cancel 方法，取消这个操作
                [operation cancel];
            }
            // 再次使用 @synchronized 来确保字典操作的线程安全
            @synchronized (self) {
                // 从字典中移除这个 key，对应的操作也就不再被追踪了
                [operationDictionary removeObjectForKey:key];
            }
        }
    }
}

- (void)sd_removeImageLoadOperationWithKey:(nullable NSString *)key {
    if (key) {
        SDOperationsDictionary *operationDictionary = [self sd_operationDictionary];
        @synchronized (self) {
            [operationDictionary removeObjectForKey:key];
        }
    }
}

@end
