//
//  NotificationsTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/24/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "NotificationsTopLauncherView.h"
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NotificationsTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NotificationsTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------

//===================================================================================================================================
#pragma mark NotificationsTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark NotificationsTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[NotificationsTopLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"notifications-top-launcher.png" andDelegate:_delegate])) {
        self.containedView = _view;
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
}

//===================================================================================================================================
#pragma mark UIView

//===================================================================================================================================
#pragma mark NSObject

@end
