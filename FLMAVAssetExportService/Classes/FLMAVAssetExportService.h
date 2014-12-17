//
//  FLMAVAssetExportService.h
//  film-model
//
//  Created by kaiinui on 2014/12/17.
//  Copyright (c) 2014年 PicApp Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLMAVAssetExportOperation;
@class FLMAVAssetExportConfiguration;
@class AVAsset;

/**
 *  AVAsset を指定の Configuration でエクスポートするサービスです。
 *
 *  サービスに Asset の Export を依頼し、Completion Block でコールバックを受けることが出来ます。
 *  temporary file の File Path (NSURL) が返ってくるので、これのデータを読んだり、Movie Player にて URL を指定することでエクスポート結果を利用することが出来ます。
 *
 *  ```
 *  [[ServiceLocator locator].avAssetExportService exportAsset:asset configuration:[FLMAVAssetExportConfiguration configurationForMobile] completion:^(NSURL *temporaryURL, NSError *error) {
 *      if (error != nil) {
 *          NSLog(@"There are some error!");
 *      }
 *
 *      NSData *data = [NSData dataWithContentsOfURL:temporaryURL];
 *
 *      NSLog(@"Exported Video Volume: %ld", data.length);
 *  }];
 *  ```
 *
 *  @warning このサービスクラスは Service Locator パターンで保持して使ってください。
 */
@interface FLMAVAssetExportService : NSObject

# pragma mark - Instantiation

/**
 *  @return インスタンス
 */
+ (instancetype)service;

# pragma mark - Service

/**
 *  AVAsset を指定した設定でエクスポートします。エクスポートが完了したら、エクスポートされたファイルのある URL と共に、completion ブロックが呼ばれます。
 *  Export を中止したい場合は、返却された Operation を - cancel してください。
 *
 *  @param asset         エクスポートしたい AVAsset
 *  @param configuration エクスポートの設定
 *  @param completion    完了時に呼ばれるブロック
 *
 *  @return エクスポートの Operation
 */
- (FLMAVAssetExportOperation *)exportAsset:(AVAsset *)asset
                             configuration:(FLMAVAssetExportConfiguration *)configuration
                                completion:(void(^)(NSURL *temporaryURL, NSError *error))completion;

@end
