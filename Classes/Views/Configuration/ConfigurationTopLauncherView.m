//
//  ConfigurationTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/27/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ConfigurationTopLauncherView.h"
#import "TouchAreaView.h"
#import "ViewControllerManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ConfigurationTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ConfigurationTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark ConfigurationTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark ConfigurationTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[ConfigurationTopLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"configuration-top-launcher.png" andDelegate:_delegate])) {
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
