//
//  ChatMessageCache.m
//  webgnosus
//
//  Created by Troy Stribling on 10/29/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ChatMessageCache.h"
#import "MessageModel.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ChatMessageCache

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize jid;

//===================================================================================================================================
#pragma mark ChatMessageCache

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithJid:(NSString*)initJid andAccount:(AccountModel*)initAccount {
	if(self = [super initWithAccount:initAccount]) {
        self.jid = initJid;
        [self load];
	}
	return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSArray*)addMessages {
    return [MessageModel findAllMessagesByJid:self.jid forAccount:self.account withPkGreaterThan:self.lastPk andLimit:self.cacheIncrement];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)totalCount {
    return [MessageModel countMessagesByJid:self.jid andAccount:self.account];
}

@end
