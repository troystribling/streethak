//
//  MapNavigationLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 9/17/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MapNavigationLauncherView : UIImageView {
    TouchAreaView* configLauncher;
    TouchAreaView* contactsLauncher;
    TouchAreaView* mapLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* configLauncher;
@property (nonatomic, retain) TouchAreaView* contactsLauncher;
@property (nonatomic, retain) TouchAreaView* mapLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initInView:(UIView*)_view;

@end
