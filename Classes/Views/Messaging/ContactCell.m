//
//  ContactCell.m
//  webgnosus
//
//  Created by Troy Stribling on 1/20/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactCell.h"
#import "RosterItemModel.h"
#import "MessageModel.h"
#import "ContactModel.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactCell (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactCell

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize activeImage;
@synthesize contactLabel;
@synthesize messageCountLabel;
@synthesize messageCountImage;
@synthesize jid;

//===================================================================================================================================
#pragma mark ContactCell PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setUnreadMessageCount:(AccountModel*)account {
    NSInteger msgCount = [MessageModel countUnreadMessagesByFromJid:[self.jid full] andAccount:account];
    if (msgCount == 0) {
        self.messageCountImage.hidden = YES;
        self.messageCountLabel.hidden = YES;
    } else {
        self.messageCountImage.hidden = NO;
        self.messageCountLabel.hidden = NO;
        self.messageCountLabel.text = [NSString stringWithFormat:@"%d", msgCount];
    }
}

//===================================================================================================================================
#pragma mark ContactCell

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIImage*)contactImage:(ContactModel*)contact {
    if ([RosterItemModel isJidAvailable:[contact bareJID]]) {
        return [UIImage imageNamed:@"contact-offline.png"];
    } 
    return [UIImage imageNamed:@"contact-online.png"];
}

//===================================================================================================================================
#pragma mark UITableViewCell

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    CGRect jidLabelRect = self.contactLabel.frame;
    if (editing) {
        jidLabelRect.size.width = kSMALL_MESSAGE_WITH_STATUS_WIDTH;
    } else {
        jidLabelRect.size.width = kLARGE_MESSAGE_WITH_STATUS_WIDTH;
    }
    self.contactLabel.frame = jidLabelRect;
    [super setEditing:editing animated:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//===================================================================================================================================
#pragma mark NSObject

@end
