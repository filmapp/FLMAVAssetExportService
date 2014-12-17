//
//  FLMAVAssetExportConfiguration.h
//  film-model
//
//  Created by kaiinui on 2014/12/16.
//  Copyright (c) 2014年 PicApp Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  動画エクスポートの設定を表現するクラスです。
 */
@interface FLMAVAssetExportConfiguration : NSObject

# pragma mark - Instantiation

+ (instancetype)configuration;

# pragma mark - Presets

+ (instancetype)configurationForLowQuality;
+ (instancetype)configurationForMobile;
+ (instancetype)configurationForTablet;

# pragma mark - Properties

@property (nonatomic, strong) NSURL *outputURL;
@property (nonatomic, copy) NSString /* AVMediaType */ *outputFileType;
@property (nonatomic, copy) NSString /* AVExportSessionPresetName */ *presetName;
@property (nonatomic, assign) BOOL shouldOptimizeForNetwork;

@end
