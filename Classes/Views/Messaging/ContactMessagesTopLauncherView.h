//
//  ContactMessagesTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/13/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "LauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessagesTopLauncherView : LauncherView {
    UILabel* contactNameLabel;
    TouchAreaView* sendMessageLauncher;
    TouchAreaView* backLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UILabel* contactNameLabel;
@property (nonatomic, retain) TouchAreaView* sendMessageLauncher;
@property (nonatomic, retain) TouchAreaView* backLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate;

@end
