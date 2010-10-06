//
//  ContactCell.h
//  webgnosus
//
//  Created by Troy Stribling on 1/20/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class RosterItemModel;
@class ContactModel;
@class AccountModel;
@class XMPPJID;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactCell : UITableViewCell {
	IBOutlet UILabel* contactLabel;
	IBOutlet UILabel* messageCountLabel;
    IBOutlet UIImageView* messageCountImage;
    IBOutlet UIImageView* activeImage;
    XMPPJID* jid;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UILabel* contactLabel;
@property (nonatomic, retain) UILabel* messageCountLabel;
@property (nonatomic, retain) UIImageView* messageCountImage;
@property (nonatomic, retain) UIImageView* activeImage;
@property (nonatomic, retain) XMPPJID* jid;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIImage*)contactImage:(ContactModel*)contact;
- (void)setUnreadMessageCount:(AccountModel*)account;

@end
