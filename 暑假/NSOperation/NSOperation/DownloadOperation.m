//
//  DownloadOperation.m
//  NSOperation
//
//  Created by chenglin on 2024/7/25.
//

#import "DownloadOperation.h"

@implementation DownloadOperation

- (instancetype)initWithUrl:(NSURL *)url start:(NSInteger)start length:(NSInteger)length fragmentIndex:(NSInteger)fragmentIndex destinationPath:(NSString *)destinationPath {
    
    self = [super init];
    if (self) {
        _url = url;
        _start = start;
        _length = length;
        _fragmentIndex = fragmentIndex;
        _destinationPath = destinationPath;
    }
    return self;
}

- (void)main {
    if (self.isCancelled) return;

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.url];
    NSString *range = [NSString stringWithFormat:@"bytes=%ld-%ld", self.start, self.start + self.length - 1];
    [request setValue:range forHTTPHeaderField:@"Range"];

    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *fragmentPath = [self.destinationPath stringByAppendingPathComponent:[NSString stringWithFormat:@"fragment_%ld", self.fragmentIndex]];
            [data writeToFile:fragmentPath atomically:YES];
            NSLog(@"Downloaded fragment %ld", (long)self.fragmentIndex);
        } else {
            NSLog(@"Failed to download fragment %ld", (long)self.fragmentIndex);
        }
        dispatch_semaphore_signal(semaphore);
    }];
    [dataTask resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

@end
