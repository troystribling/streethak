//
//  StoreTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/29/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "StoreTopLauncherView.h"
#import "TouchAreaView.h"
#import "TouchImageView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation StoreTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize backLauncher;
@synthesize modeLauncher;

//===================================================================================================================================
#pragma mark StoreTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark StoreTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[StoreTopLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"store-top-launcher.png" andDelegate:_delegate])) {
        CGRect backFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.backLauncher = [TouchAreaView createWithFrame:backFrame name:@"back" andDelegate:self];
        [self addSubview:self.backLauncher];
        CGRect modeLauncherFrame = CGRectMake(0.7672*viewWidth, 0.05*viewHeight, 0.2062*viewWidth, 0.6800*viewHeight);
        self.modeLauncher = [TouchImageView createWithFrame:modeLauncherFrame name:@"mode" andDelegate:self];
        self.modeLauncher.contentMode = UIViewContentModeScaleToFill; 
        self.modeLauncher.image = [UIImage imageNamed:@"store-buy-button.png"];
        [self addSubview:self.modeLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    [self.delegate viewTouchedNamed:touchedView.viewName];
}

//===================================================================================================================================
#pragma mark TouchImageView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)imageTouched:(TouchImageView*)touchedView {
    [self.delegate viewTouchedNamed:touchedView.viewName];
}

//===================================================================================================================================
#pragma mark UIView

//===================================================================================================================================
#pragma mark NSObject

@end
