//
//  AcceptBuddyRequestView.h
//  webgnosus
//
//  Created by Troy Stribling on 2/22/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class XMPPClient;
@class ContactModel;
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface AcceptBuddyRequestView : UIAlertView {
    XMPPClient* xmppClient;
    ContactModel* contact;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) XMPPClient* xmppClient;
@property (nonatomic, retain) ContactModel* contact;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithClient:(XMPPClient*)client contact:(ContactModel*)_contact account:(AccountModel*)_account andDelegate:(id)delegate;

@end
