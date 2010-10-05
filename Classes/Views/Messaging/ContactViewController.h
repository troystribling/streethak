//
//  ContactViewController.h
//  webgnosus
//
//  Created by Troy Stribling on 1/19/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------
@class AccountModel;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactViewController : UITableViewController <UITableViewDataSource> {
	NSMutableArray* items;
    AccountModel* account;
    NSInteger displayType;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) AccountModel* account;
@property (nonatomic, assign) NSInteger displayType;

//-----------------------------------------------------------------------------------------------------------------------------------

@end
