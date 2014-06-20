//
//  MainViewController.m
//  TestImage
//
//  Created by wangjun on 13-12-12.
//  Copyright (c) 2013年 user. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

@interface MainViewController ()
{
    MainView *m_mainView;
}

@property (nonatomic, retain) MainView *mainView;

@end

@implementation MainViewController
@synthesize mainView = m_mainView;

- (void)dealloc
{
    self.mainView = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.mainView = [[[MainView alloc] initWithFrame:MAIN_NAV_BOUNDS] autorelease];
    [self.view addSubview:self.mainView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
