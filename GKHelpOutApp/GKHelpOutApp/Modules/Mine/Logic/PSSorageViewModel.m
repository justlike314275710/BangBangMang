//
//  PSSorageViewModel.m
//  PrisonService
//
//  Created by kky on 2018/12/18.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import "PSSorageViewModel.h"

@implementation PSSorageViewModel

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (float)fileSizeWithIntergeWithM {
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    return size/(1024 * 1024);
}

-(NSString *)allStorage {
    return [NSString stringWithFormat:@"%.1fM",[self fileSizeWithIntergeWithM]+58.2];
}

-(NSString *)usedStorage {
    float totalDiskspace = [self getTotalSpaceDiskspace];
    float userDiskspace = ([self fileSizeWithIntergeWithM]+58.2)/1024;
    float AppDiskspace = userDiskspace/totalDiskspace*100;
    if (AppDiskspace<0.1) {
        AppDiskspace = 0.1;
    }
    NSString *msg = @"占据手机内存%.1f%@存储空间";
    return [NSString stringWithFormat:msg,AppDiskspace,@"%"];
}

//计算缓存大小
- (NSString *)fileSizeWithInterge{
    
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

-(float)getTotalSpaceDiskspace {
    
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        NSLog(@"Memory Capacity of %llu GB with %llu GB Free memory available.", ((totalSpace/1024ll)/1024ll/1024ll), ((totalFreeSpace/1024ll)/1024ll/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %d", [error domain], [error code]);
    }
    
    return totalSpace/1024.0/1024.0/1024.0;
}

-(float)getTotalFreeSpaceDiskspace {
    
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        NSLog(@"Memory Capacity of %llu GB with %llu GB Free memory available.", ((totalSpace/1024ll)/1024ll/1024ll), ((totalFreeSpace/1024ll)/1024ll/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %d", [error domain], [error code]);
    }
    
    return totalFreeSpace/1024.0/1024.0/1024.0;
}



@end
