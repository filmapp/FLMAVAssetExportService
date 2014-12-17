//
//  FLMAVAssetExportConfiguration.m
//  film-model
//
//  Created by kaiinui on 2014/12/16.
//  Copyright (c) 2014年 PicApp Inc. All rights reserved.
//

#import "FLMAVAssetExportConfiguration.h"

#import <AVFoundation/AVFoundation.h>

@implementation FLMAVAssetExportConfiguration

# pragma mark - Instantiation

+ (instancetype)configuration {
    FLMAVAssetExportConfiguration *configuration = [[self alloc] init];
    configuration.outputURL = [self tempFileURL];
    configuration.outputFileType = AVFileTypeMPEG4;
    configuration.presetName = AVAssetExportPresetLowQuality;
    configuration.shouldOptimizeForNetwork = YES;
    
    return configuration;
}

+ (instancetype)configurationForLowQuality {
    FLMAVAssetExportConfiguration *configuration = [self configuration];
    configuration.presetName = AVAssetExportPresetLowQuality;
    return configuration;
}

+ (instancetype)configurationForMobile {
    FLMAVAssetExportConfiguration *configuration = [self configuration];
    configuration.presetName = AVAssetExportPresetMediumQuality;
    return configuration;
}

+ (instancetype)configurationForTablet {
    FLMAVAssetExportConfiguration *configuration = [self configuration];
    configuration.presetName = AVAssetExportPreset1280x720;
    return configuration;
}

# pragma mark - Helpers (Property)

+ (NSURL *)tempFileURL {
    NSString *fileName = [NSString stringWithFormat:@"%@_%@", [[NSProcessInfo processInfo] globallyUniqueString], @"out.mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:fileName]];
    
    return fileURL;
}

@end
