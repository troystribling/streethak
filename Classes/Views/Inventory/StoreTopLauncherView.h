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
@class TouchImageView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreTopLauncherView : LauncherView {
    TouchAreaView* backLauncher;
    TouchImageView* modeLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* backLauncher;
@property (nonatomic, retain) TouchImageView* modeLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;

@end
