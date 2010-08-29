//
//  ViewControllerManager.h
//  streethak
//
//  Created by Troy Stribling on 8/25/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class CreateAccountViewController;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ViewControllerManager : NSObject {
    CreateAccountViewController* createAccountViewController;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) CreateAccountViewController* createAccountViewController;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (ViewControllerManager*)instance;

//-----------------------------------------------------------------------------------------------------------------------------------
- (CreateAccountViewController*)showCreateAccountViewController:(UIView*)containeView;

@end
