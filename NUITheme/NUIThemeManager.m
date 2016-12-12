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
    //    NSLog(@"startDefaultThemeService皮肤:bundle:%@====theme:%@",bundlePath,themeFilePath);
    
    _currentThemeBundlePath = bundlePath;
    _defaultThemeBundlePath = bundlePath;
    
    //    NSLog(@"The sheet is %@", [[themeFilePath lastPathComponent] stringByDeletingPathExtension]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NUISettings setAutoUpdatePath:themeFilePath];
        [NUISettings initWithStylesheet:[[themeFilePath lastPathComponent] stringByDeletingPathExtension]];
    });
    
}

- (void)changeToThemeWithThemeBundlePath:(NSString *)themeBundlePath
{
    _currentThemeBundlePath = themeBundlePath;
    NSArray *paths = [NSBundle pathsForResourcesOfType:@"nss" inDirectory:themeBundlePath];
    NSString *themeFilePath = [paths firstObject];
    NSAssert(themeFilePath == nil, @"主题文件不存在");
    //        BOOL bundleExist = [[NSFileManager defaultManager] fileExistsAtPath:themeBundlePath];
    //        NSLog(@"changeToThemeWithThemeBundlePath皮肤:bundle:%@====theme:%@    dd%d",themeBundlePath,themeFilePath,bundleExist);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NUISettings setAutoUpdatePath:themeFilePath];
//        [NUIRenderer stylesheetFileChanged];
    });
}

@end
