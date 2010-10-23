//
//  EventsMessageCache.m
//  webgnosus
//
//  Created by Troy Stribling on 10/31/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "EventsMessageCache.h"
#import "MessageModel.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation EventsMessageCache

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize node;

//===================================================================================================================================
#pragma mark EventsMessageCache

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNode:(NSString*)initNode andAccount:(AccountModel*)initAccount {
	if(self = [super initWithAccount:initAccount]) {
        self.node = initNode;
        [self load];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSArray*)addMessages {
    return [MessageModel findAllEventsLikeNode:self.node forAccount:self.account withPkGreaterThan:self.lastPk andLimit:self.cacheIncrement];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)totalCount {
    return [MessageModel countEventsLikeNode:self.node andAccount:self.account];
}

@end
