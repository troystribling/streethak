//
//  MapTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 9/15/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MapTopLauncherView.h"
#import "TouchAreaView.h"
#import "ViewControllerManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MapTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize inventoryLauncher;
@synthesize statsLauncher;
@synthesize levelLabel;

//===================================================================================================================================
#pragma mark MapTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[MapTopLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"map-top-launcher.png" andDelegate:_delegate])) {
        self.containedView = _view;
        CGRect inventoryFrame = CGRectMake(0.8281*viewWidth, 0.0, 0.1562*viewWidth, viewHeight);
        self.inventoryLauncher = [TouchAreaView createWithFrame:inventoryFrame name:@"inventory" andDelegate:self];
        [self addSubview:self.inventoryLauncher];
        CGRect levelFrame = CGRectMake(0.0187*viewWidth, 0.0, 0.1562*viewWidth, 0.85*viewHeight);
        self.levelLabel = [[[UILabel alloc] initWithFrame:levelFrame] autorelease]; 
        self.levelLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:36.0];
        self.levelLabel.textAlignment = UITextAlignmentCenter;
        self.levelLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.levelLabel];
        CGRect statsFrame = CGRectMake(0.0391*viewWidth, 0.0, 0.7578*viewWidth, viewHeight);
        self.statsLauncher = [TouchAreaView createWithFrame:statsFrame name:@"stats" andDelegate:self];
        [self addSubview:self.statsLauncher];
        [_view addSubview:self];
    }
    return self;
}

//------------------------------------------------------------------------------------------------------------------------------------ 
- (void)setLevel {
    self.levelLabel.text = @"99";
}

//===================================================================================================================================
#pragma mark MapTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    [self.delegate viewTouchedNamed:touchedView.viewName];
}

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

@end
