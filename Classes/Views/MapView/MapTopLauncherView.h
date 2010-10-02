//
//  MapTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 9/15/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapTopLauncherView : UIImageView {
    TouchAreaView* inventoryLauncher;
    TouchAreaView* statsLauncher;
    UILabel* levelLabel;
    UIView* containerView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* inventoryLauncher;
@property (nonatomic, retain) TouchAreaView* statsLauncher;
@property (nonatomic, retain) UILabel* levelLabel;
@property (nonatomic, retain) UIView* containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initInView:(UIView*)_view;

@end
