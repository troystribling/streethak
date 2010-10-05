//
//  ContactCell.h
//  webgnosus
//
//  Created by Troy Stribling on 1/20/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ResourceCell.h"

//-----------------------------------------------------------------------------------------------------------------------------------
@class RosterItemModel;
@class ContactModel;
@class AccountModel;
@class XMPPJID;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface RosterCell : ResourceCell {
    IBOutlet UIImageView* activeImage;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIImageView* activeImage;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (UIImage*)rosterItemImage:(RosterItemModel*)rosterItem;
+ (UIImage*)contactImage:(ContactModel*)contact;

@end
