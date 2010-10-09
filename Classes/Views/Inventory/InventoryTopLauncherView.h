//
//  InventoryTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/3/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "TopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface InventoryTopLauncherView : TopLauncherView {
    TouchAreaView* storeLauncher;
    TouchAreaView* backLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* storeLauncher;
@property (nonatomic, retain) TouchAreaView* backLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;

@end
