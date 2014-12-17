//
//  ViewController.m
//  FLMAVAssetExportService
//
//  Created by kaiinui on 2014/12/17.
//  Copyright (c) 2014年 PicApp inc. All rights reserved.
//

#import "ViewController.h"

#import "FLMAVAssetExportService.h"
#import "FLMAVAssetExportConfiguration.h"
#import <Photos/Photos.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) MPMoviePlayerViewController *player;

@property (nonatomic, strong) PHAsset *targetAsset;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.targetAsset = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:nil].firstObject;
    NSLog(@"%@", self.targetAsset);
    [[PHImageManager defaultManager] requestImageForAsset:self.targetAsset targetSize:CGSizeMake(300, 300) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
        [self.imageView setImage:result];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - IBAction

- (IBAction)didPressStartButton:(id)sender {
    [[PHImageManager defaultManager] requestAVAssetForVideo:self.targetAsset options:nil resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
        [self startExporting:asset];
    }];
}

# pragma mark - Helpers

- (void)startExporting:(AVAsset *)asset {
    NSLog(@"Start Exporting asset: %@", asset);
    NSLog(@"Duration: %lld sec", asset.duration.value / asset.duration.timescale);
    NSDate *start = [NSDate date];
    
    [[FLMAVAssetExportService service] exportAsset:asset configuration:[FLMAVAssetExportConfiguration configurationForMobile] completion:^(NSURL *temporaryURL, NSError *error) {
        NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
        NSUInteger byteCount = [NSData dataWithContentsOfURL:temporaryURL].length;
        
        NSLog(@"%@", temporaryURL);
        NSLog(@"Read data: %@", [formatter stringFromByteCount:(long long)byteCount]);
        NSLog(@"Finished in: %lf sec", [[NSDate date] timeIntervalSinceDate:start]);
        
        [self presentMoviePlayerWithURL:temporaryURL];
    }];
}

- (void)presentMoviePlayerWithURL:(NSURL *)url {
    _player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [_player.moviePlayer prepareToPlay];
    _player.moviePlayer.shouldAutoplay = YES;
    _player.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    
    [self presentMoviePlayerViewControllerAnimated:_player];
}

@end
