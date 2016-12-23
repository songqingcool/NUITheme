//
//  NUIThemeManager.m
//  NUITheme
//
//  Created by 宋庆功 on 2016/12/12.
//  Copyright © 2016年 思源. All rights reserved.
//

#import "NUIThemeManager.h"
#import "NUIRenderer.h"

@implementation NUIThemeManager

+ (NUIThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static NUIThemeManager *instance = nil;
    dispatch_once(&once, ^{
        instance = [[NUIThemeManager alloc]init];
    });
    return instance;
}

- (void)startDefaultThemeService
{
    // 初始化为默认主题
    NSString *bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Themes.bundle"];
    NSString *themeFilePath = [NSBundle pathForResource:@"NUIStyle" ofType:@"nss" inDirectory:bundlePath];
    
    _defaultPath = themeFilePath;
    
    [self changeThemeWithPath:themeFilePath];
}

- (void)changeThemeWithPath:(NSString *)filePath
{
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSAssert(fileExist, @"主题文件不存在");
    
    _currentPath = filePath;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NUISettings setAutoUpdatePath:filePath];
        [NUIRenderer stylesheetFileChanged];
    });
}

@end
