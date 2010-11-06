//
//  MapTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 9/15/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapTopLauncherView : LauncherView {
    TouchAreaView* inventoryLauncher;
    TouchAreaView* statsLauncher;
    UILabel* levelLabel;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* inventoryLauncher;
@property (nonatomic, retain) TouchAreaView* statsLauncher;
@property (nonatomic, retain) UILabel* levelLabel;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setLevel;

@end
