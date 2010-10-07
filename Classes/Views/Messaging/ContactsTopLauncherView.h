//
//  ContactsTopLauncherView.h
//  streethak
//
//  Created by Troy Stribling on 10/6/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

#import <UIKit/UIKit.h>


//-----------------------------------------------------------------------------------------------------------------------------------
@class TouchAreaView;

@interface ContactsTopLauncherView : UIImageView {
    TouchAreaView* backLauncher;
    UIView* containerView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) TouchAreaView* backLauncher;
@property (nonatomic, retain) UIView* containerView;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initInView:(UIView*)_view;

@end
