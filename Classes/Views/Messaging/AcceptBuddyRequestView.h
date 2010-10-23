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
@class XMPPJID;
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface AcceptBuddyRequestView : UIAlertView {
    XMPPClient* xmppClient;
    XMPPJID* contactJID;
    AccountModel* account;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) XMPPClient* xmppClient;
@property (nonatomic, retain) XMPPJID* contactJID;
@property (nonatomic, retain) AccountModel* account;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithClient:(XMPPClient*)client contactJID:(XMPPJID*)_contactJID account:(AccountModel*)_account andDelegate:(id)delegate;

@end
