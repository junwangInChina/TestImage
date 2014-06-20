//
//  UIImage+Fuzzy.m
//  TestImage
//
//  Created by wangjun on 13-12-12.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "UIImage+Fuzzy.h"
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (Fuzzy)

- (UIImage *)imageWithGaussianBlur
{
    float weight[5] = {0.2270270270, 0.1945945946, 0.1216216216, 0.0540540541, 0.0162162162};
    // Blur horizontally
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int x = 1; x < 5; ++x)
    {
        [self drawInRect:CGRectMake(x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
        [self drawInRect:CGRectMake(-x, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[x]];
    }
    UIImage *horizBlurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Blur vertically
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [horizBlurredImage drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[0]];
    for (int y = 1; y < 5; ++y)
    {
        [horizBlurredImage drawInRect:CGRectMake(0, y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
        [horizBlurredImage drawInRect:CGRectMake(0, -y, self.size.width, self.size.height) blendMode:kCGBlendModePlusLighter alpha:weight[y]];
    }
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //
    return blurredImage;
}

+ (UIImage *)blurryCoreImage:(UIImage *)image andBlurLevel:(CGFloat)blur
{
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey,inputImage,@"inputRadius",@(blur), nil];
    
    CIImage *outputImage = filter.outputImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outImage = [context createCGImage:outputImage fromRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    return [UIImage imageWithCGImage:outImage];
}

+ (UIImage *)blurryAccelerateImage:(UIImage *)image andBlurLevel:(CGFloat)blur
{
    if (blur < 0.0 || blur > 1.0)
    {
        blur = 0.5;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef imageRef = image.CGImage;
    
    vImage_Buffer inputBuffer , outputBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inprovider = CGImageGetDataProvider(imageRef);
    CFDataRef inBitmapData = CGDataProviderCopyData(inprovider);
    
    inputBuffer.width = CGImageGetWidth(imageRef);
    inputBuffer.height = CGImageGetHeight(imageRef);
    inputBuffer.rowBytes = CGImageGetBytesPerRow(imageRef);
    inputBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef));
    
    if (pixelBuffer == NULL) NSLog(@"NO PixelBuffer");
    
    outputBuffer.data = pixelBuffer;
    outputBuffer.width = CGImageGetWidth(imageRef);
    outputBuffer.height = CGImageGetHeight(imageRef);
    outputBuffer.rowBytes = CGImageGetBytesPerRow(imageRef);
    
    error = vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) NSLog(@"error from convolution %zd",error);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(outputBuffer.data, outputBuffer.width, outputBuffer.height, 8, outputBuffer.rowBytes, colorSpace, (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef_ = CGBitmapContextCreateImage(contextRef);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef_];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef_);
    
    return returnImage;
}

@end


































































































































































































