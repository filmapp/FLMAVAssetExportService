//
//  FLMAVAssetExportService.m
//  film-model
//
//  Created by kaiinui on 2014/12/17.
//  Copyright (c) 2014年 PicApp Inc. All rights reserved.
//

#import "FLMAVAssetExportService.h"

#import "FLMAVAssetExportOperation.h"
#import "FLMAVAssetExportConfiguration.h"

@interface FLMAVAssetExportService ()

@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

@end

@implementation FLMAVAssetExportService

+ (instancetype)service {
    return [[self alloc] initWithOperationQueue:[[NSOperationQueue alloc] init]];
}

# pragma mark - Initialization

- (instancetype)initWithOperationQueue:(NSOperationQueue *)queue {
    self = [self init];
    if (self) {
        _operationQueue = queue;
    }
    return self;
}

# pragma mark - Service

- (FLMAVAssetExportOperation *)exportAsset:(AVAsset *)asset
                             configuration:(FLMAVAssetExportConfiguration *)configuration
                                completion:(void (^)(NSURL *, NSError *))completion {
    FLMAVAssetExportOperation *operation = [FLMAVAssetExportOperation operationWithAsset:asset configuration:configuration];
    
    operation.completionBlock = ^{
        completion(configuration.outputURL, nil);
    };
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
