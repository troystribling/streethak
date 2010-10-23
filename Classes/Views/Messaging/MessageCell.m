//
//  MessageCell.m
//  webgnosus
//
//  Created by Troy Stribling on 4/17/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "MessageCell.h"
#import "MessageModel.h"
#import "CellUtils.h"
#import "XMPPEntry.h"
#import "XMPPJID.h"
#import "NSXMLElementAdditions.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MessageCell (PrivateAPI)

+ (NSString*)getMessageText:(MessageModel*)message;
+ (CGRect)getMessageRect:(NSString*)messageText;
+ (UIView*)viewForMessage:(MessageModel*)message andColor:(UIColor*)color;
+ (NSString*)getJID:(MessageModel*)message;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation MessageCell

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize dateLabel;
@synthesize jidLabel;
@synthesize messageLabel;

//===================================================================================================================================
#pragma mark MessageCell PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
+ (NSString*)getMessageText:(MessageModel*)message {
    NSString* msgText;
    if (message.textType == MessageTextTypeEventText) {
        msgText = message.messageText;
    } else if (message.textType == MessageTextTypeBody) {
        msgText = message.messageText;
    } else if (message.textType == MessageTextTypeEventEntry) {
        msgText = [[message parseEntryMessage] title];
    }
    return msgText;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (CGRect)getMessageRect:(NSString*)messageText {
	CGFloat cellHeight = 20.0f;
    CGFloat width =  kDISPLAY_WIDTH;
    if (messageText) {
        CGSize textSize = {width, 20000.0f};
        CGSize size = [messageText sizeWithFont:[UIFont fontWithName:@"Washington Text" size:24.0] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
        cellHeight = MAX(size.height, cellHeight);
    }    
	return CGRectMake(0.0f, 0.0f, width, cellHeight);
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIView*)viewForMessage:(MessageModel*)message andColor:(UIColor*)color {
    NSString* messageText = [self getMessageText:message];
    CGRect viewRect = [self getMessageRect:messageText];
    UILabel* messageView = [[UILabel alloc] initWithFrame:viewRect];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.lineBreakMode = UILineBreakModeWordWrap;
    messageView.numberOfLines = 0;
    messageView.text = messageText;
    messageView.font = [UIFont fontWithName:@"Washington Text" size:24.0];
    if (color) {
        messageView.textColor = color;
    } else {
        messageView.textColor = [UIColor blackColor];
    }
    return messageView;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (NSString*)getJID:(MessageModel*)message {
    NSString* msgJID;
    if (message.textType == MessageTextTypeEventText) {
        msgJID = [[XMPPJID jidWithString:message.fromJid] user];
    } else if (message.textType == MessageTextTypeBody) {
        msgJID = [[XMPPJID jidWithString:message.fromJid] user];
    } else if (message.textType == MessageTextTypeEventEntry) {
        NSArray* nodeComp = [message.node componentsSeparatedByString:@"/"];
        msgJID = [NSString stringWithFormat:@"%@", [nodeComp objectAtIndex:3]];
    }
    return msgJID;
}

//===================================================================================================================================
#pragma mark MessageCell

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)setTime:(MessageCell*)cell forMessage:(MessageModel*)message {
    NSRange dateAndTime = {0, 16};
    cell.dateLabel.text = [[message createdAtAsString] substringWithRange:dateAndTime];
    cell.dateLabel.font = [UIFont fontWithName:@"Washington Text" size:20.0];
    cell.dateLabel.textColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.20 alpha:0.8]; 
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)setJID:(MessageCell*)cell forMessage:(MessageModel*)message {
    cell.jidLabel.font = [UIFont fontWithName:@"Washington Text" size:20.0];
    cell.jidLabel.text = [self getJID:message];
    cell.jidLabel.textColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.20 alpha:0.8]; 
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (CGFloat)tableView:(UITableView *)tableView heightForRowWithMessage:(MessageModel*)message {
    UIView* msgView = [self viewForMessage:message andColor:nil];
    CGRect msgRect = [msgView frame];
	return msgRect.size.height + kMESSAGE_CELL_HEIGHT_PAD;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath forMessage:(MessageModel*)message andAccount:(NSString*)account {        
    MessageCell* cell = (MessageCell*)[CellUtils createCell:[MessageCell class] forTableView:tableView];
    UIColor* color = [UIColor blackColor];
    if ([account isEqualToString:[[XMPPJID jidWithString:message.fromJid] user]]) {
        color = [UIColor colorWithRed:0.4 green:0.05 blue:0.05 alpha:1.0];
    }
    [self setJID:cell forMessage:message];
    [self setTime:cell forMessage:message];
    UIView* msgView = [self viewForMessage:message andColor:color];
    CGRect msgRect = msgView.frame;
    UIView* container = [[UIView alloc] initWithFrame:CGRectMake(kMESSAGE_CELL_X_OFFSET, kMESSAGE_CELL_Y_OFFSET, msgRect.size.width,  msgRect.size.width)];
    [container addSubview:msgView];
    [cell addSubview:container];
    return cell;
}

//===================================================================================================================================
#pragma mark UITableViewCell

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)coder { 
	if (self = [super initWithCoder:coder]) { 
	} 
	return self; 
} 

//===================================================================================================================================
#pragma mark NSObject

@end
