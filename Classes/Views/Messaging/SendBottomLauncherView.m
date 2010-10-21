//
//  SendBottomLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/16/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SendBottomLauncherView.h"
#import "TouchAreaView.h"
#import "ViewControllerManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendBottomLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SendBottomLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize sendLauncher;

//===================================================================================================================================
#pragma mark SendBottomLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark SendBottomLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[SendBottomLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGFloat viewYPos = 0.425*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, viewYPos, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"send-bottom-launcher.png" andDelegate:_delegate])) {
        self.containedView = _view;
        CGRect sendFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.sendLauncher = [TouchAreaView createWithFrame:sendFrame name:@"send" andDelegate:self];
        [self addSubview:self.sendLauncher];
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
#pragma mark UIView

//===================================================================================================================================
#pragma mark NSObject

@end
