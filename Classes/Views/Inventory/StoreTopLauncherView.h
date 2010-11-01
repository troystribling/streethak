//
//  StoreTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/29/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreTopLauncherView : LauncherView {
    TouchAreaView* backLauncher;
    TouchAreaView* modeLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* backLauncher;
@property (nonatomic, retain) TouchAreaView* modeLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;

@end
