//
//  SendTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/16/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SendTopLauncherView.h"
#import "TouchAreaView.h"
#import "ViewControllerManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SendTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize backLauncher;

//===================================================================================================================================
#pragma mark SendTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark SendTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view withImageNamed:(NSString*)_image andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[SendTopLauncherView alloc] initInView:_view withImageNamed:(NSString*)_image andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view withImageNamed:(NSString*)_image andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:_image andDelegate:_delegate])) {
        self.containedView = _view;
        CGRect sendFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.backLauncher = [TouchAreaView createWithFrame:sendFrame name:@"back" andDelegate:self];
        [self addSubview:self.backLauncher];
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
