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
@property (nonatomic, copy, readonly) NSString *defaultPath;
// 当前主题路径
@property (nonatomic, copy, readonly) NSString *currentPath;


+ (NUIThemeManager *)sharedInstance;

// 程序启动设置默认主题
- (void)startDefaultTheme;

// 切换主题  文件路径为绝对路径
- (void)changeThemeWithPath:(NSString *)filePath;

@end
