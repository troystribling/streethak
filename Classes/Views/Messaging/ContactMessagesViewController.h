//
//  ContactMessagesViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 2/28/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>
#import "NavigationLauncherView.h"
#import "ContactsTopLauncherView.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;
@class ChatMessageCache;
@class ContactModel;
@class ContactMessagesTopLauncherView;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NavigationLauncherViewDelegate, LauncherViewDelegate> {
    IBOutlet UITableView* messagesView;
    ChatMessageCache* chatMessages;
    ContactMessagesTopLauncherView* topLauncher;
    UIView* containerView;
    AccountModel* account;
    ContactModel* contact;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UITableView* messagesView;
@property (nonatomic, retain) ChatMessageCache* chatMessages;
@property (nonatomic, retain) UIView* containerView;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, retain) ContactModel* contact;
@property (nonatomic, retain) ContactMessagesTopLauncherView* topLauncher;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView;
- (void)setContactName:(ContactModel*)_contact;

@end
