//
//  ContactsTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/6/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "TopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactsTopLauncherView : TopLauncherView {
    TouchAreaView* addContactLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* addContactLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;

@end
