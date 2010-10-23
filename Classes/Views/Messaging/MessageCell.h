//
//  MessageCell.h
//  webgnosus
//
//  Created by Troy Stribling on 4/17/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class MessageModel;
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MessageCell : UITableViewCell {
    IBOutlet UILabel* dateLabel;
    IBOutlet UILabel* jidLabel;
    IBOutlet UILabel* messageLabel;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UILabel* dateLabel;
@property (nonatomic, retain) UILabel* jidLabel;
@property (nonatomic, retain) UILabel* messageLabel;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (void)setTime:(MessageCell*)cell forMessage:(MessageModel*)message;
+ (void)setJID:(MessageCell*)cell forMessage:(MessageModel*)message;
+ (CGFloat)tableView:(UITableView *)tableView heightForRowWithMessage:(MessageModel*)message;
+ (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath forMessage:(MessageModel*)message andAccount:(NSString*)account;

@end
