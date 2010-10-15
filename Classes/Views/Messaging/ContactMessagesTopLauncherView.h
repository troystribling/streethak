//
//  ContactMessagesTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/13/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "TopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessagesTopLauncherView : TopLauncherView {
    UILabel* contactNameLabel;
    TouchAreaView* sendMessageLauncher;
    TouchAreaView* backLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UILabel* contactNameLabel;
@property (nonatomic, retain) TouchAreaView* sendMessageLauncher;
@property (nonatomic, retain) TouchAreaView* backLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;

@end
