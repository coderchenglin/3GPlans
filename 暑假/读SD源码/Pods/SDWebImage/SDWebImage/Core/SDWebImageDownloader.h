/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "SDWebImageCompat.h"
#import "SDWebImageDefine.h"
#import "SDWebImageOperation.h"
#import "SDWebImageDownloaderConfig.h"
#import "SDWebImageDownloaderRequestModifier.h"
#import "SDWebImageDownloaderResponseModifier.h"
#import "SDWebImageDownloaderDecryptor.h"
#import "SDImageLoader.h"

//这个类需要学习一下
/// Downloader options
typedef NS_OPTIONS(NSUInteger, SDWebImageDownloaderOptions) {

    SDWebImageDownloaderLowPriority = 1 << 0, //将下载操作放置在低队列优先级和任务优先级中。

    SDWebImageDownloaderProgressiveLoad = 1 << 1, //启用渐进式下载，图像在下载过程中逐步显示，类似于浏览器的行为。

    SDWebImageDownloaderUseNSURLCache = 1 << 2, //默认情况下，请求会阻止使用 NSURLCache。启用此标志后，NSURLCache 将按默认策略使用。

    SDWebImageDownloaderIgnoreCachedResponse = 1 << 3, //如果图像是从 NSURLCache 中读取的，并且错误代码为 `SDWebImageErrorCacheNotModified`，则调用完成回调并传递 nil 图像/图像数据。//此标志应与 `SDWebImageDownloaderUseNSURLCache` 结合使用。
    /**
     * 在 iOS 4+ 中，如果应用程序进入后台，则继续下载图像。通过请求系统在后台提供额外的时间以完成请求来实现。
     * 如果后台任务超时，操作将被取消。
     */
    SDWebImageDownloaderContinueInBackground = 1 << 4,

    /**
     * 通过设置 `NSMutableURLRequest.HTTPShouldHandleCookies = YES` 来处理存储在 NSHTTPCookieStore 中的 cookie。
     */
    SDWebImageDownloaderHandleCookies = 1 << 5,

    /**
     * 启用后允许不受信任的 SSL 证书。
     * 适用于测试目的。在生产环境中使用时要谨慎。
     */
    SDWebImageDownloaderAllowInvalidSSLCertificates = 1 << 6,

    /**
     * 将下载操作放置在高队列优先级和任务优先级中。
     */
    SDWebImageDownloaderHighPriority = 1 << 7,
    
    /**
     * 默认情况下，图像解码时会尊重其原始大小。在 iOS 中，此标志将图像缩小到与设备受限内存兼容的大小。
     * 如果设置了 `SDWebImageDownloaderAvoidDecodeImage`，此标志无效。如果设置了 `SDWebImageDownloaderProgressiveLoad`，此标志也将被忽略。
     */
    SDWebImageDownloaderScaleDownLargeImages = 1 << 8,
    
    /**
     * 默认情况下，我们会在缓存查询和从网络下载期间在后台解码图像。这有助于提高性能，因为在屏幕上渲染图像时，首先需要解码图像。但这在 Core Animation 中发生在主队列上。
     * 然而，这个过程也可能增加内存使用量。如果由于过多的内存消耗而遇到问题，此标志可以防止解码图像。
     */
    SDWebImageDownloaderAvoidDecodeImage = 1 << 9,
    
    /**
     * 默认情况下，我们会解码动画图像。此标志可以强制仅解码第一帧并生成静态图像。
     */
    SDWebImageDownloaderDecodeFirstFrameOnly = 1 << 10,
    
    /**
     * 默认情况下，对于 `SDAnimatedImage`，我们在渲染时解码动画图像帧以减少内存使用。此标志实际触发 `preloadAllAnimatedImageFrames = YES`，在从网络加载图像后预加载所有动画帧。
     */
    SDWebImageDownloaderPreloadAllFrames = 1 << 11,
    
    /**
     * 默认情况下，当您使用 `SDWebImageContextAnimatedImageClass` 上下文选项（例如使用 `SDAnimatedImageView` 设计用于 `SDAnimatedImage`）时，即使内存缓存命中，或者图像解码器不可用，我们仍可能使用 `UIImage` 作为回退解决方案。
     * 使用此选项可以确保始终使用提供的类生成图像。如果失败，将使用代码 `SDWebImageErrorBadImageData` 的错误。
     * 请注意，此选项与 `SDWebImageDownloaderDecodeFirstFrameOnly` 不兼容，后者始终生成 `UIImage/NSImage`。
     */
    SDWebImageDownloaderMatchAnimatedImageClass = 1 << 12,
};

FOUNDATION_EXPORT NSNotificationName _Nonnull const SDWebImageDownloadStartNotification;
FOUNDATION_EXPORT NSNotificationName _Nonnull const SDWebImageDownloadReceiveResponseNotification;
FOUNDATION_EXPORT NSNotificationName _Nonnull const SDWebImageDownloadStopNotification;
FOUNDATION_EXPORT NSNotificationName _Nonnull const SDWebImageDownloadFinishNotification;

typedef SDImageLoaderProgressBlock SDWebImageDownloaderProgressBlock;
typedef SDImageLoaderCompletedBlock SDWebImageDownloaderCompletedBlock;

/**
 *  A token associated with each download. Can be used to cancel a download
 */


//这个类也需要学一下
//通过 SDWebImageDownloadToken，调用者可以取消下载、查看下载的 URL 和请求信息，甚至可以获取下载的性能指标（如果支持）。
@interface SDWebImageDownloadToken : NSObject <SDWebImageOperation>

- (void)cancel; // 取消当前的下载操作。

@property (nonatomic, strong, nullable, readonly) NSURL *url; // 下载操作的 URL。

@property (nonatomic, strong, nullable, readonly) NSURLRequest *request; // 下载操作的请求对象。

@property (nonatomic, strong, nullable, readonly) NSURLResponse *response; //下载操作的响应对象。

@property (nonatomic, strong, nullable, readonly) NSURLSessionTaskMetrics *metrics API_AVAILABLE(macosx(10.12), ios(10.0), watchos(3.0), tvos(10.0)); // 下载操作的指标（metrics）。如果下载操作不支持指标，则此属性为 nil。

@end


/**
 * Asynchronous downloader dedicated and optimized for image loading.
 */
@interface SDWebImageDownloader : NSObject

/**
 * Downloader Config object - storing all kind of settings.
 * Most config properties support dynamic changes during download, except something like `sessionConfiguration`, see `SDWebImageDownloaderConfig` for more detail.
 */
@property (nonatomic, copy, readonly, nonnull) SDWebImageDownloaderConfig *config;

/**
 * Set the request modifier to modify the original download request before image load.
 * This request modifier method will be called for each downloading image request. Return the original request means no modification. Return nil will cancel the download request.
 * Defaults to nil, means does not modify the original download request.
 * @note If you want to modify single request, consider using `SDWebImageContextDownloadRequestModifier` context option.
 */
@property (nonatomic, strong, nullable) id<SDWebImageDownloaderRequestModifier> requestModifier;

/**
 * Set the response modifier to modify the original download response during image load.
 * This request modifier method will be called for each downloading image response. Return the original response means no modification. Return nil will mark current download as cancelled.
 * Defaults to nil, means does not modify the original download response.
 * @note If you want to modify single response, consider using `SDWebImageContextDownloadResponseModifier` context option.
 */
@property (nonatomic, strong, nullable) id<SDWebImageDownloaderResponseModifier> responseModifier;

/**
 * Set the decryptor to decrypt the original download data before image decoding. This can be used for encrypted image data, like Base64.
 * This decryptor method will be called for each downloading image data. Return the original data means no modification. Return nil will mark this download failed.
 * Defaults to nil, means does not modify the original download data.
 * @note When using decryptor, progressive decoding will be disabled, to avoid data corrupt issue.
 * @note If you want to decrypt single download data, consider using `SDWebImageContextDownloadDecryptor` context option.
 */
@property (nonatomic, strong, nullable) id<SDWebImageDownloaderDecryptor> decryptor;

/**
 * The configuration in use by the internal NSURLSession. If you want to provide a custom sessionConfiguration, use `SDWebImageDownloaderConfig.sessionConfiguration` and create a new downloader instance.
 @note This is immutable according to NSURLSession's documentation. Mutating this object directly has no effect.
 */
@property (nonatomic, readonly, nonnull) NSURLSessionConfiguration *sessionConfiguration;

/**
 * Gets/Sets the download queue suspension state.
 */
@property (nonatomic, assign, getter=isSuspended) BOOL suspended;

/**
 * Shows the current amount of downloads that still need to be downloaded
 */
@property (nonatomic, assign, readonly) NSUInteger currentDownloadCount;

/**
 *  Returns the global shared downloader instance. Which use the `SDWebImageDownloaderConfig.defaultDownloaderConfig` config.
 */
@property (nonatomic, class, readonly, nonnull) SDWebImageDownloader *sharedDownloader;

/**
 Creates an instance of a downloader with specified downloader config.
 You can specify session configuration, timeout or operation class through downloader config.

 @param config The downloader config. If you specify nil, the `defaultDownloaderConfig` will be used.
 @return new instance of downloader class
 */
- (nonnull instancetype)initWithConfig:(nullable SDWebImageDownloaderConfig *)config NS_DESIGNATED_INITIALIZER;

/**
 * Set a value for a HTTP header to be appended to each download HTTP request.
 *
 * @param value The value for the header field. Use `nil` value to remove the header field.
 * @param field The name of the header field to set.
 */
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(nullable NSString *)field;

/**
 * Returns the value of the specified HTTP header field.
 *
 * @return The value associated with the header field field, or `nil` if there is no corresponding header field.
 */
- (nullable NSString *)valueForHTTPHeaderField:(nullable NSString *)field;

/**
 * Creates a SDWebImageDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see SDWebImageDownloaderDelegate
 *
 * @param url            The URL to the image to download
 * @param completedBlock A block called once the download is completed.
 *                       If the download succeeded, the image parameter is set, in case of error,
 *                       error parameter is set with the error. The last parameter is always YES
 *                       if SDWebImageDownloaderProgressiveDownload isn't use. With the
 *                       SDWebImageDownloaderProgressiveDownload option, this block is called
 *                       repeatedly with the partial image object and the finished argument set to NO
 *                       before to be called a last time with the full image and finished argument
 *                       set to YES. In case of error, the finished argument is always YES.
 *
 * @return A token (SDWebImageDownloadToken) that can be used to cancel this operation
 */
- (nullable SDWebImageDownloadToken *)downloadImageWithURL:(nullable NSURL *)url
                                                 completed:(nullable SDWebImageDownloaderCompletedBlock)completedBlock;

/**
 * Creates a SDWebImageDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see SDWebImageDownloaderDelegate
 *
 * @param url            The URL to the image to download
 * @param options        The options to be used for this download
 * @param progressBlock  A block called repeatedly while the image is downloading
 *                       @note the progress block is executed on a background queue
 * @param completedBlock A block called once the download is completed.
 *                       If the download succeeded, the image parameter is set, in case of error,
 *                       error parameter is set with the error. The last parameter is always YES
 *                       if SDWebImageDownloaderProgressiveLoad isn't use. With the
 *                       SDWebImageDownloaderProgressiveLoad option, this block is called
 *                       repeatedly with the partial image object and the finished argument set to NO
 *                       before to be called a last time with the full image and finished argument
 *                       set to YES. In case of error, the finished argument is always YES.
 *
 * @return A token (SDWebImageDownloadToken) that can be used to cancel this operation
 */
- (nullable SDWebImageDownloadToken *)downloadImageWithURL:(nullable NSURL *)url
                                                   options:(SDWebImageDownloaderOptions)options
                                                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                                                 completed:(nullable SDWebImageDownloaderCompletedBlock)completedBlock;

/**
 * Creates a SDWebImageDownloader async downloader instance with a given URL
 *
 * The delegate will be informed when the image is finish downloaded or an error has happen.
 *
 * @see SDWebImageDownloaderDelegate
 *
 * @param url            The URL to the image to download
 * @param options        The options to be used for this download
 * @param context        A context contains different options to perform specify changes or processes, see `SDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
 * @param progressBlock  A block called repeatedly while the image is downloading
 *                       @note the progress block is executed on a background queue
 * @param completedBlock A block called once the download is completed.
 *
 * @return A token (SDWebImageDownloadToken) that can be used to cancel this operation
 */
- (nullable SDWebImageDownloadToken *)downloadImageWithURL:(nullable NSURL *)url
                                                   options:(SDWebImageDownloaderOptions)options
                                                   context:(nullable SDWebImageContext *)context
                                                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                                                 completed:(nullable SDWebImageDownloaderCompletedBlock)completedBlock;

/**
 * Cancels all download operations in the queue
 */
- (void)cancelAllDownloads;

/**
 * Invalidates the managed session, optionally canceling pending operations.
 * @note If you use custom downloader instead of the shared downloader, you need call this method when you do not use it to avoid memory leak
 * @param cancelPendingOperations Whether or not to cancel pending operations.
 * @note Calling this method on the shared downloader has no effect.
 */
- (void)invalidateSessionAndCancel:(BOOL)cancelPendingOperations;

@end


/**
 SDWebImageDownloader is the built-in image loader conform to `SDImageLoader`. Which provide the HTTP/HTTPS/FTP download, or local file URL using NSURLSession.
 However, this downloader class itself also support customization for advanced users. You can specify `operationClass` in download config to custom download operation, See `SDWebImageDownloaderOperation`.
 If you want to provide some image loader which beyond network or local file, consider to create your own custom class conform to `SDImageLoader`.
 */
@interface SDWebImageDownloader (SDImageLoader) <SDImageLoader>

@end
