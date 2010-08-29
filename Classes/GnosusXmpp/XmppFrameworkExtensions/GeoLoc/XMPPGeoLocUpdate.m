//
//  XMPPGeoLocUpdate.m
//  webgnosus
//
//  Created by Troy Stribling on 7/30/10.
//  Copyright 2010 Plan-B Reserach. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "XMPPGeoLocUpdate.h"
#import <CoreLocation/CoreLocation.h>
#import "MessageModel.h"
#import "AccountModel.h"
#import "XMPPClient.h"
#import "XMPPClientManager.h"
#import "XMPPGeoLoc.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPGeoLocUpdate (PrivateAPI)
@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation XMPPGeoLocUpdate

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize account;

//===================================================================================================================================
#pragma mark XMPPLocationEvent

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(AccountModel*)initAcct {
	if(self = [super init])  {
        self.account = initAcct;
	}
	return self;
}

//===================================================================================================================================
#pragma mark LocationManagerDelegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)geoLocManager:(GeoLocManager*)geoLocMgr didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation {
    XMPPGeoLoc* geoLoc = [[[XMPPGeoLoc alloc] init] autorelease];
    [geoLoc addAlt:newLocation.altitude];
    [geoLoc addLat:newLocation.coordinate.latitude];
    [geoLoc addLon:newLocation.coordinate.longitude];
    [geoLoc addAccuracy:newLocation.horizontalAccuracy];
    [geoLoc addTimestamp:newLocation.timestamp];
    MessageModel* model = [[[MessageModel alloc] init] autorelease];
    model.accountPk = self.account.pk;
    model.toJid = [[self.account toJID] domain];
    model.fromJid = [self.account fullJID];
    model.createdAt = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    model.textType = MessageTextTypeGeoLocData;
    model.messageText = [geoLoc XMLString];
    model.itemId = @"-1";
    model.node = [self.account geoLocPubSubNode];
    model.messageRead = YES;
    [model insert];
    XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:self.account];
    [XMPPGeoLoc publish:xmppClient forAccount:self.account withData:geoLoc];    
}

@end
