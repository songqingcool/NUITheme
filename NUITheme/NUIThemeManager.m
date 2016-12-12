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
    NSArray *paths = [NSBundle pathsForResourcesOfType:@"nss" inDirectory:bundlePath];
    NSString *themeFilePath = [paths firstObject];
    NSAssert(themeFilePath == nil, @"主题文件不存在");
    
    _currentThemePath = themeFilePath;
    _defaultThemePath = themeFilePath;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NUISettings setAutoUpdatePath:themeFilePath];
        [NUISettings initWithStylesheet:[[themeFilePath lastPathComponent] stringByDeletingPathExtension]];
    });
}

- (void)changeThemeWithFilePath:(NSString *)filePath
{
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSAssert(!fileExist, @"主题文件不存在");
    
    _currentThemePath = filePath;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NUISettings setAutoUpdatePath:filePath];
//        [NUIRenderer stylesheetFileChanged];
    });
}

@end
