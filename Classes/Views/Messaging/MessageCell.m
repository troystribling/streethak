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
#import "NSXMLElementAdditions.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MessageCell (PrivateAPI)

+ (NSString*)getMessageText:(MessageModel*)message;
+ (CGRect)getMessageRect:(NSString*)messageText;
+ (UIView*)viewForMessage:(MessageModel*)message;

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
    return message.messageText;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (CGRect)getMessageRect:(NSString*)messageText {
	CGFloat cellHeight = 20.0f;
    CGFloat width =  kDISPLAY_WIDTH;
    if (messageText) {
        CGSize textSize = {width, 20000.0f};
        CGSize size = [messageText sizeWithFont:[UIFont systemFontOfSize:kMESSAGE_CELL_FONT_SIZE] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
        cellHeight = MAX(size.height, cellHeight);
    }    
	return CGRectMake(0.0f, 0.0f, width, cellHeight);
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIView*)viewForMessage:(MessageModel*)message {
    NSString* messageText = [self getMessageText:message];
    CGRect viewRect = [self getMessageRect:messageText];
    UILabel* messageView = [[UILabel alloc] initWithFrame:viewRect];
    messageView.backgroundColor = [UIColor clearColor];
    messageView.lineBreakMode = UILineBreakModeWordWrap;
    messageView.numberOfLines = 0;
    messageView.text = messageText;
    return messageView;
}

//===================================================================================================================================
#pragma mark MessageCell

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)setTime:(MessageCell*)cell forMessage:(MessageModel*)message {
    NSRange dateAndTime = {0, 19};
    cell.dateLabel.text = [[message.createdAt description] substringWithRange:dateAndTime];
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)set:(MessageCell*)cell Jid:(NSString*)jid {
    cell.jidLabel.text = jid;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (CGFloat)tableView:(UITableView *)tableView heightForRowWithMessage:(MessageModel*)message {
    UIView* msgView = [self viewForMessage:message];
    CGRect msgRect = [msgView frame];
	return msgRect.size.height + kMESSAGE_CELL_HEIGHT_PAD;
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath forMessage:(MessageModel*)message fromJid:(NSString*)jid {        
    MessageCell* cell = (MessageCell*)[CellUtils createCell:[MessageCell class] forTableView:tableView];
    [self set:cell Jid:jid];
    [self setTime:cell forMessage:message];
    UIView* msgView = [self viewForMessage:message];
    CGRect msgRect = msgView.frame;
    UIView* container = [[UIView alloc] initWithFrame:CGRectMake(kMESSAGE_CELL_X_OFFSET, kMESSAGE_CELL_Y_OFFSET, msgRect.size.width,  msgRect.size.width)];
    [container addSubview:msgView];
    [cell addSubview:container];
    return cell;
}

//===================================================================================================================================
#pragma mark UITableViewCell

//===================================================================================================================================
#pragma mark NSObject

@end
