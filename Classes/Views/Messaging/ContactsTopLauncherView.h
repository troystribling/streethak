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
    TouchAreaView* partyPubSubLauncher;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* addContactLauncher;
@property (nonatomic, retain) TouchAreaView* partyPubSubLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;
- (id)initInView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate;

@end
