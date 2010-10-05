//
//  RosterCell.m
//  webgnosus
//
//  Created by Troy Stribling on 1/20/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "RosterCell.h"
#import "RosterItemModel.h"
#import "MessageModel.h"
#import "ContactModel.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface RosterCell (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation RosterCell

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize activeImage;

//===================================================================================================================================
#pragma mark RosterCell

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIImage*)rosterItemImage:(RosterItemModel*)rosterItem {
    if ([rosterItem isAvailable]) {
        return [UIImage imageNamed:@"account-on-led.png"];
    } 
    return [UIImage imageNamed:@"account-off-led.png"];
}

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIImage*)contactImage:(ContactModel*)contact {
    if ([contact hasError]) {
        return [UIImage imageNamed:@"account-error-led.png"];
    } else if ([RosterItemModel isJidAvailable:[contact bareJID]]) {
        return [UIImage imageNamed:@"account-on-led.png"];
    } 
    return [UIImage imageNamed:@"account-off-led.png"];
}

//===================================================================================================================================
#pragma mark RosterCell PrivateAPI

//===================================================================================================================================
#pragma mark UITableViewCell

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    CGRect jidLabelRect = self.resourceLabel.frame;
    if (editing) {
        jidLabelRect.size.width = kSMALL_MESSAGE_WITH_STATUS_WIDTH;
    } else {
        jidLabelRect.size.width = kLARGE_MESSAGE_WITH_STATUS_WIDTH;
    }
    self.resourceLabel.frame = jidLabelRect;
    [super setEditing:editing animated:animated];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
