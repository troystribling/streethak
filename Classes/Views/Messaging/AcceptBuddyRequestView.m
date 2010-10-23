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
#import "ContactModel.h"

#import "XMPPClient.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface AcceptBuddyRequestView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation AcceptBuddyRequestView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize xmppClient;
@synthesize contact;
@synthesize account;

//===================================================================================================================================
#pragma mark AcceptBuddyRequestView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithClient:(XMPPClient*)client contact:(ContactModel*)_contact account:(AccountModel*)_account andDelegate:(id)delegate {
    NSString* message = [[NSString alloc] initWithFormat:@"'%@'\n wants to be in your Party", [[_contact toJID] user]];
    if (self = [super initWithTitle:[[client myJID] full] message:message delegate:delegate cancelButtonTitle:@"no" otherButtonTitles:nil]) {
        [self addButtonWithTitle:@"yes"];
        self.xmppClient = client;
        self.contact = _contact;
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
