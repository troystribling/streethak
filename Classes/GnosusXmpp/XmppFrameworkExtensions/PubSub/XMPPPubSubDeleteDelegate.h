//
//  XMPPPubSubDeleteDelegate.h
//  webgnosus
//
//  Created by Troy Stribling on 9/23/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <Foundation/Foundation.h>
#import "XMPPResponse.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface XMPPPubSubDeleteDelegate : NSObject <XMPPResponseDelegate> {
    NSString* node;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) NSString* node;

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)init:(NSString*)initNode;

@end
