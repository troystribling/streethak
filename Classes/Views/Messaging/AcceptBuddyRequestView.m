//
//  AcceptBuddyRequestView.m
//  webgnosus
//
//  Created by Troy Stribling on 2/22/09.
//  Copyright planBresearch 2010. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "AcceptBuddyRequestView.h"
#import "AccountModel.h"

#import "XMPPClient.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface AcceptBuddyRequestView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AcceptBuddyRequestView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize xmppClient;
@synthesize contactJID;
@synthesize account;

//===================================================================================================================================
#pragma mark AcceptBuddyRequestView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithClient:(XMPPClient*)client contactJID:(XMPPJID*)_contactJID account:(AccountModel*)_account andDelegate:(id)delegate {
    if (self = [super initWithTitle:[_contactJID user] message:@"wants to be in your Party" delegate:delegate cancelButtonTitle:@"no" otherButtonTitles:nil]) {
        [self addButtonWithTitle:@"yes"];
        self.xmppClient = client;
        self.contactJID = _contactJID;
        self.account = _account;
    }
    return self;
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
