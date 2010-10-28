//
//  ConfigurationTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/27/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ConfigurationTopLauncherView : LauncherView {
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;

@end
