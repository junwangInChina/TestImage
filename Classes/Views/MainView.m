//
//  MainView.m
//  TestImage
//
//  Created by wangjun on 13-12-12.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "MainView.h"
#import "UIImage+Fuzzy.h"

@interface MainView()
{
    UIImageView *m_oldImageView;
    UIImageView *m_coreImageView;
    UIImageView *m_accelerateImageView;
    UIImageView *m_gaussianImageView;
}

@property (nonatomic, retain) UIImageView *oldImageView;
@property (nonatomic, retain) UIImageView *coreImageView;
@property (nonatomic, retain) UIImageView *accelerateImageView;
@property (nonatomic, retain) UIImageView *gaussianImageView;

@end

@implementation MainView
@synthesize oldImageView = m_oldImageView;
@synthesize coreImageView = m_coreImageView;
@synthesize accelerateImageView = m_accelerateImageView;
@synthesize gaussianImageView = m_gaussianImageView;

- (void)dealloc
{
    self.oldImageView = nil;
    self.coreImageView = nil;
    self.accelerateImageView = nil;
    self.gaussianImageView = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.oldImageView = [self createImageView:CGRectMake(10, 10, 300, 100)];
        self.oldImageView.image = [UIImage imageNamed:@"banner 01"];
        
        self.coreImageView = [self createImageView:CGRectMake(10, 120, 300, 100)];
        self.coreImageView.image = [UIImage blurryCoreImage:[UIImage imageNamed:@"banner 01"] andBlurLevel:5];
        
        self.accelerateImageView = [self createImageView:CGRectMake(10, 230, 300, 100)];
        self.accelerateImageView.image = [UIImage blurryAccelerateImage:[UIImage imageNamed:@"banner 01"] andBlurLevel:0.2];
        
        self.gaussianImageView = [self createImageView:CGRectMake(10, 340, 300, 100)];
        self.gaussianImageView.image = [[UIImage imageNamed:@"banner 01"] imageWithGaussianBlur];
    }
    return self;
}

- (UIImageView *)createImageView:(CGRect)imageFrame
{
    UIImageView *imageView_ = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView_.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imageView_];
    
    return [imageView_ autorelease];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
