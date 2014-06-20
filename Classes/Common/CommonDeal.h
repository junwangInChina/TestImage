//
//  CommonDeal.h
//  TestImage
//
//  Created by wangjun on 14-6-20.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 版本判断
/**
 *	@brief  版本判断
 */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_Height      iPhone5 ? 568 : 480

#define DEVICE [[[UIDevice currentDevice] systemVersion] floatValue]
#define IOS7   DEVICE >= 7.0

#pragma mark - 屏幕尺寸
/**
 *	@brief  屏幕尺寸
 */
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define STATUS_BAR_HEIGHT   20
#define NAVIGATION_HEIGHT   44
#define TABBAR_HEIGHT       48
#define MAIN_BOUNDS         CGRectMake(0, IOS7 ? STATUS_BAR_HEIGHT : 0, 320, SCREEN_HEIGHT - STATUS_BAR_HEIGHT)
#define MAIN_NAV_BOUNDS     CGRectMake(0, IOS7 ? (STATUS_BAR_HEIGHT + NAVIGATION_HEIGHT) : 0, 320, SCREEN_HEIGHT - (STATUS_BAR_HEIGHT + NAVIGATION_HEIGHT))
#define MAIN_TAB_BOUNDS     CGRectMake(0, IOS7 ? (STATUS_BAR_HEIGHT + NAVIGATION_HEIGHT) : 0, 320, SCREEN_HEIGHT - (STATUS_BAR_HEIGHT + NAVIGATION_HEIGHT + TABBAR_HEIGHT))

#pragma mark - Debug 打印日志
/**
 *	@brief  Debug 打印日志
 */
#ifdef DEBUG
#define DebugLog(format, ...)  NSLog(format, ## __VA_ARGS__)
#else
#define DebugLog(format, ...)
#endif

#pragma mark - 安全释放目标对象
/**
 *	@brief  安全释放目标对象
 */
#define RELEASE_SAFETY(__POINTER) { [__POINTER release]; __POINTER = nil; }

#pragma mark - Font
/**
 *	@brief  Font
 */
#define HELVETICANEUEBOLD_FONT(font)		[UIFont fontWithName:@"HelveticaNeue-Bold" size:font]	//加粗
#define HELVETICANEUE_FONT(font)			[UIFont fontWithName:@"HelveticaNeue" size:font]		//不加粗

#pragma mark - Color
/**
 *	@brief  Color
 */
#define COLOR_4b5c66 [UIColor colorWithRed:75.0/255.0 green:92.0/255.0 blue:102.0/255.0 alpha:1.0]

@interface CommonDeal : NSObject

@end
