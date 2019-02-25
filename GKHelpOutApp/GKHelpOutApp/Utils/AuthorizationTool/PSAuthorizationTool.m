//
//  STAuthorizationTool.m
//  Start
//
//  Created by calvin on 17/2/17.
//  Copyright © 2017年 DingSNS. All rights reserved.
//

#import "PSAuthorizationTool.h"
#import <AVFoundation/AVFoundation.h>
#import "PSTipsView.h"
#import "UIAlertView+BlocksKit.h"
#import <Photos/Photos.h>

@implementation PSAuthorizationTool

+ (void)checkAndRedirectAVAuthorizationWithBlock:(CheckAuthorizationBlock)block {
    __block BOOL videoResult = NO;
    __block BOOL audioResult = NO;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        switch (videoAuthStatus) {
            case AVAuthorizationStatusNotDetermined:
                break;
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusDenied:
                break;
            case AVAuthorizationStatusAuthorized:
            {
                videoResult = YES;
            }
                break;
            default:
                break;
        }
        switch (audioAuthStatus) {
            case AVAuthorizationStatusNotDetermined:
                break;
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusDenied:
                break;
            case AVAuthorizationStatusAuthorized:
            {
                audioResult = YES;
            }
                break;
            default:
                break;
        }
        
        if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {
            //没有询问相机开启权限
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                videoResult = granted;
                if (audioAuthStatus == AVAuthorizationStatusNotDetermined) {
                    //没有询问麦克风开启权限
                    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (granted) {
                                if (videoResult) {
                                    if (block) {
                                        block(granted && videoResult);
                                    }
                                }else {
                                    [self checkAndRedirectAVAuthorizationWithBlock:block];
                                }
                            }else {
                                [self checkAndRedirectAVAuthorizationWithBlock:block];
                            }
                        });
                    }];
                    return;
                }
            }];
            return;
        }else {
            if (audioAuthStatus == AVAuthorizationStatusNotDetermined) {
                //没有询问麦克风开启权限
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (granted) {
                            if (videoResult) {
                                if (block) {
                                    block(granted && videoResult);
                                }
                            }else {
                                [self checkAndRedirectAVAuthorizationWithBlock:block];
                            }
                        }else {
                            [self checkAndRedirectAVAuthorizationWithBlock:block];
                        }
                    });
                }];
                return;
            }
        }
        
        NSString *title;
        NSString *message;
        if (!videoResult) {
            title = @"相机未授权";
            message = @"开启相机才能正常进行视频通话！";
        }
        if (!audioResult) {
            title = @"麦克风未授权";
            message = @"开启麦克风才能正常进行视频通话！";
        }
        if (!videoResult && !audioResult) {
            title = @"相机和麦克风未授权";
            message = @"开启相机和麦克风才能正常进行视频通话！";
        }
        if (!videoResult || !audioResult) {
            NSString *content = [NSString stringWithFormat:@"在“设置-%@”中%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"],message];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *videoAuthURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:videoAuthURL]) {
                    [[UIApplication sharedApplication] openURL:videoAuthURL];
                }
            }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }else {
        [PSTipsView showTips:@"当前设备无相机功能"];
    }
    if (block) {
        block(videoResult && audioResult);
    }
}

+ (void)checkAndRedirectCameraAuthorizationWithBlock:(CheckAuthorizationBlock)block {
    BOOL videoResult = NO;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (videoAuthStatus) {
            case AVAuthorizationStatusNotDetermined:
                break;
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusDenied:
                break;
            case AVAuthorizationStatusAuthorized:
            {
                videoResult = YES;
            }
                break;
            default:
                break;
        }
        
        if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {
            //没有询问相机开启权限
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self checkAndRedirectCameraAuthorizationWithBlock:block];
                });
            }];
            return;
        }
        
        NSString *title;
        NSString *message;
        if (!videoResult) {
            title = @"相机未授权";
            message = @"开启相机才能正常拍照哦！";
            NSString *content = [NSString stringWithFormat:@"在“设置-%@”中%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"],message];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *videoAuthURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:videoAuthURL]) {
                    [[UIApplication sharedApplication] openURL:videoAuthURL];
                }
            }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }else {
        [PSTipsView showTips:@"当前设备无相机功能"];
    }
    if (block) {
        block(videoResult);
    }
}

+ (void)checkAndRedirectPhotoAuthorizationWithBlock:(CheckAuthorizationBlock)block {
    BOOL photoResult = NO;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthStatus) {
            case PHAuthorizationStatusNotDetermined:
                break;
            case PHAuthorizationStatusRestricted:
                break;
            case PHAuthorizationStatusDenied:
                break;
            case PHAuthorizationStatusAuthorized:
            {
                photoResult = YES;
            }
                break;
            default:
                break;
        }
        
        if (photoAuthStatus == AVAuthorizationStatusNotDetermined) {
            //没有询问相册开启权限
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self checkAndRedirectPhotoAuthorizationWithBlock:block];
                });
            }];
            return;
        }
        
        NSString *title;
        NSString *message;
        if (!photoResult) {
            title = @"相册未授权";
            message = @"开启相册访问才能正常使用照片哦！";
            NSString *content = [NSString stringWithFormat:@"在“设置-%@”中%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"],message];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *videoAuthURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:videoAuthURL]) {
                    [[UIApplication sharedApplication] openURL:videoAuthURL];
                }
            }]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }else {
        [PSTipsView showTips:@"当前设备无相册功能"];
    }
    if (block) {
        block(photoResult);
    }
}

+ (void)checkAndRedirectAudioAuthorizationWithBlock:(CheckAuthorizationBlock)block {
    BOOL videoResult = NO;
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (audioAuthStatus) {
        case AVAuthorizationStatusNotDetermined:
            break;
        case AVAuthorizationStatusRestricted:
            break;
        case AVAuthorizationStatusDenied:
            break;
        case AVAuthorizationStatusAuthorized:
        {
            videoResult = YES;
        }
            break;
        default:
            break;
    }
    
    if (audioAuthStatus == AVAuthorizationStatusNotDetermined) {
        //没有询问麦克风开启权限
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self checkAndRedirectAudioAuthorizationWithBlock:block];
            });
        }];
        return;
    }
    
    NSString *title;
    NSString *message;
    if (!videoResult) {
        title = @"麦克风未授权";
        message = @"开启麦克风才能正常使用该功能哦！";
        NSString *content = [NSString stringWithFormat:@"在“设置-%@”中%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"],message];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *videoAuthURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:videoAuthURL]) {
                [[UIApplication sharedApplication] openURL:videoAuthURL];
            }
        }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    if (block) {
        block(videoResult);
    }
}

+ (BOOL)isAudioAvailable {
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    return audioAuthStatus == AVAuthorizationStatusAuthorized;
}

@end
