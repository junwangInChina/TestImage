//
//  UIImage+Fuzzy.h
//  TestImage
//
//  Created by wangjun on 13-12-12.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Fuzzy)

- (UIImage *)imageWithGaussianBlur;

+ (UIImage *)blurryCoreImage:(UIImage *)image andBlurLevel:(CGFloat)blur;

+ (UIImage *)blurryAccelerateImage:(UIImage *)image andBlurLevel:(CGFloat)blur;

@end
