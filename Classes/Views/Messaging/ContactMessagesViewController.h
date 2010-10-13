//
//  ContactMessagesViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/28/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class ChatMessageCache;
@class UserModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessagesViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    ChatMessageCache* chatMessages;
    UIView* containerView;
    AccountModel* account;
    UserModel* rosterItem;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) ChatMessageCache* chatMessages;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) UserModel* rosterItem;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;


@end
