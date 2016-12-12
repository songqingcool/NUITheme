//
//  NUIThemeManager.h
//  NUITheme
//
//  Created by 宋庆功 on 2016/12/12.
//  Copyright © 2016年 思源. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NUIThemeManager : NSObject

// 默认主题路径
@property (nonatomic, copy, readonly) NSString *defaultThemeBundlePath;
// 当前主题路径
@property (nonatomic, copy, readonly) NSString *currentThemeBundlePath;


+ (NUIThemeManager *)sharedInstance;

// 初始化主题管理类并设置默认主题
- (void)startDefaultThemeService;

// 切换主题  主题bundle路径为绝对路径
- (void)changeToThemeWithThemeBundlePath:(NSString *)themeBundlePath;

@end
