//
//  DownloadOperation.h
//  NSOperation
//
//  Created by chenglin on 2024/7/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadOperation : NSOperation

@property (nonatomic, copy) NSURL* url;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger length;
@property (nonatomic, assign) NSInteger fragmentIndex;
@property (nonatomic, copy) NSString* destinationPath;

- (instancetype)initWithUrl:(NSURL *)url start:(NSInteger)start length:(NSInteger)length fragmentIndex:(NSInteger)fragmentIndex destinationPath:(NSString *)destinationPath;

@end

NS_ASSUME_NONNULL_END
