//
//  ContactMessageViewController.h
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessageViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    ChatMessageCache* items;
    AccountModel* account;
    UserModel* rosterItem;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) ChatMessageCache* items;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) UserModel* rosterItem;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle andTitle:(NSString*)viewTitle;

@end
