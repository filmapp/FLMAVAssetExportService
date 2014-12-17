//
//  FLMAVAssetExportOperation.h
//  film-model
//
//  Created by kaiinui on 2014/12/16.
//  Copyright (c) 2014年 PicApp Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLMAVAssetExportConfiguration;
@class AVAsset;

/**
 *  動画のエクスポートを実際に行なう NSOperation です。
 */
@interface FLMAVAssetExportOperation : NSOperation

# pragma mark - Instantiation

+ (instancetype)operationWithAsset:(AVAsset *)asset configuration:(FLMAVAssetExportConfiguration *)configuration;

# pragma mark - Properties

@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, copy) FLMAVAssetExportConfiguration *configuration;

# pragma mark - NSOperation

@property (nonatomic, assign) BOOL isFinished;

@end
