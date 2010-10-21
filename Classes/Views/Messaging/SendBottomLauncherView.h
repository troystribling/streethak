//
//  SendBottomLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/16/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendBottomLauncherView : LauncherView {
    TouchAreaView* sendLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* sendLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;

@end
