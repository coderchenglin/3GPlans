/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"

/// Image Cache Expire Type
typedef NS_ENUM(NSUInteger, SDImageCacheConfigExpireType) {
    /**
     * When the image cache is accessed it will update this value
     */
    SDImageCacheConfigExpireTypeAccessDate,
    /**
     * When the image cache is created or modified it will update this value (Default)
     */
    SDImageCacheConfigExpireTypeModificationDate,
    /**
     * When the image cache is created it will update this value
     */
    SDImageCacheConfigExpireTypeCreationDate,
    /**
     * When the image cache is created, modified, renamed, file attribute updated (like permission, xattr)  it will update this value
     */
    SDImageCacheConfigExpireTypeChangeDate,
};

/**
 The class contains all the config for image cache
 @note This class conform to NSCopying, make sure to add the property in `copyWithZone:` as well.
 */
@interface SDImageCacheConfig : NSObject <NSCopying>

// 获取默认的缓存配置，用于共享实例或初始化时未提供任何缓存配置的情况。例如 `SDImageCache.sharedImageCache`。
// 您可以修改默认缓存配置中的属性，之后创建的缓存实例会使用这些修改后的配置。已经创建的缓存实例不会受到影响。
@property (nonatomic, class, readonly, nonnull) SDImageCacheConfig *defaultCacheConfig;

/**
 获取默认的缓存配置，用于共享实例或初始化时未提供任何缓存配置的情况。例如 `SDImageCache.sharedImageCache`。
 @note 您可以修改默认缓存配置中的属性，之后创建的缓存实例会使用这些修改后的配置。已经创建的缓存实例不会受到影响。
 */
@property (assign, nonatomic) BOOL shouldDisableiCloud;

/**
 * 是否使用内存缓存
 * @note 当禁用内存缓存时，弱内存缓存也将被禁用。
 * 默认为 YES。
 */
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;

/*
 * 控制图像的弱内存缓存选项。启用时，`SDImageCache` 的内存缓存将在将图像存储到内存的同时使用一个弱映射表（`NSMapTable`）存储图像，并同时将其移除。
 * 但是当触发内存警告时，由于弱映射表不持有图像实例的强引用，即使内存缓存本身被清除，一些被 UIImageView 或其他活动实例强引用的图像仍然可以恢复，以避免后续从磁盘缓存或网络重新查询。这在某些情况下可能会有所帮助，例如，当应用进入后台并且内存被清除后，重新进入前台会导致单元格闪烁。
 * 默认为 YES。您可以动态更改此选项。
 */
@property (assign, nonatomic) BOOL shouldUseWeakMemoryCache;

/**
 * 当应用进入后台时，是否移除过期的磁盘数据。（不适用于 macOS）
 * 默认为 YES。
 */
@property (assign, nonatomic) BOOL shouldRemoveExpiredDataWhenEnterBackground;

/**
 * 从磁盘读取缓存时的读取选项。
 * 默认为 0。您可以将此设置为 `NSDataReadingMappedIfSafe` 以提高性能。
 */
@property (assign, nonatomic) NSDataReadingOptions diskCacheReadingOptions;

/**
 * 将缓存写入磁盘时的写入选项。
 * 默认为 `NSDataWritingAtomic`。您可以将此设置为 `NSDataWritingWithoutOverwriting` 以防止覆盖现有文件。
 */
@property (assign, nonatomic) NSDataWritingOptions diskCacheWritingOptions;

/**
 * 磁盘缓存中保留图像的最长时间（以秒为单位）。
 * 将此值设置为 负数 表示没有过期时间。
 * 将此值设置为 零 表示在进行过期检查时会删除所有缓存文件。
 * 默认为 1 周。
 */
@property (assign, nonatomic) NSTimeInterval maxDiskAge;

/**
 * 磁盘缓存的最大大小（以字节为单位）。
 * 默认为 0，表示没有缓存大小限制。
 */
@property (assign, nonatomic) NSUInteger maxDiskSize;

/**
 * 内存图像缓存的最大“总成本”。成本函数是内存中占用的字节大小。
 * @note 内存成本是内存中的字节大小，而不是简单的像素计数。对于常见的 ARGB8888 图像，一个像素为 4 字节（32 位）。
 * 默认为 0，表示没有内存成本限制。
 */
@property (assign, nonatomic) NSUInteger maxMemoryCost;

/**
 * 内存图像缓存应持有的最大对象数。
 * 默认为 0，表示没有内存计数限制。
 */
@property (assign, nonatomic) NSUInteger maxMemoryCount;

/*
 * 清除磁盘缓存时用于检查的属性。
 * 默认为修改日期。
 */
@property (assign, nonatomic) SDImageCacheConfigExpireType diskCacheExpireType;

/**
 * 磁盘缓存的自定义文件管理器。传递 nil 以让磁盘缓存选择合适的文件管理器。
 * 默认为 nil。
 * @note 此值不支持动态更改。这意味着在缓存初始化后对该值的进一步修改无效。
 * @note 由于 `NSFileManager` 不支持 `NSCopying`，因此在复制时我们只按引用传递此值。因此，不建议在 `defaultCacheConfig` 上设置此值。
 */
@property (strong, nonatomic, nullable) NSFileManager *fileManager;

/**
 * 自定义内存缓存类。提供的类实例必须符合 `SDMemoryCache` 协议才能使用。
 * 默认为内置的 `SDMemoryCache` 类。
 * @note 此值不支持动态更改。这意味着在缓存初始化后对该值的进一步修改无效。
 */
@property (assign, nonatomic, nonnull) Class memoryCacheClass;

/**
 * 自定义磁盘缓存类。提供的类实例必须符合 `SDDiskCache` 协议才能使用。
 * 默认为内置的 `SDDiskCache` 类。
 * @note 此值不支持动态更改。这意味着在缓存初始化后对该值的进一步修改无效。
 */
@property (assign ,nonatomic, nonnull) Class diskCacheClass;

@end
