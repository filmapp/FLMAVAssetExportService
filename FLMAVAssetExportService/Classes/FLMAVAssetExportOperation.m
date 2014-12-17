//
//  FLMAVAssetExportOperation.m
//  film-model
//
//  Created by kaiinui on 2014/12/16.
//  Copyright (c) 2014年 PicApp Inc. All rights reserved.
//

#import "FLMAVAssetExportOperation.h"

#import "FLMAVAssetExportConfiguration.h"
#import <AVFoundation/AVFoundation.h>

@implementation FLMAVAssetExportOperation

- (instancetype)initWithAsset:(AVAsset *)asset configuration:(FLMAVAssetExportConfiguration *)configuration {
    self = [super init];
    if (self) {
        _asset = asset;
        _configuration = configuration;
    }
    return self;
}

+ (instancetype)operationWithAsset:(AVAsset *)asset configuration:(FLMAVAssetExportConfiguration *)configuration {
    return [[self alloc] initWithAsset:asset configuration:configuration];
}

# pragma mark - NSOperation

- (BOOL)isConcurrent {
    return YES;
}

- (void)finishOperation {
    [self willChangeValueForKey:@"isFinished"];
    self.isFinished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

# pragma mark - 

- (void)start {
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:self.asset presetName:self.configuration.presetName];
    [session setOutputURL:self.configuration.outputURL];
    [session setOutputFileType:self.configuration.outputFileType];
    [session setShouldOptimizeForNetworkUse:self.configuration.shouldOptimizeForNetwork];
    
    __weak typeof(self) wSelf = self;
    [session exportAsynchronouslyWithCompletionHandler:^{
        __strong typeof(self) sSelf = wSelf;
        
        [sSelf finishOperation];
    }];
}

@end
