//
//  StoreItemCell.h
//  streethak
//
//  Created by Troy Stribling on 10/30/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface StoreItemCell : UITableViewCell {
	IBOutlet UILabel* itemLabel;
    IBOutlet UILabel* itemPriceLabel;
    IBOutlet UIImageView* itemImage;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UILabel* itemLabel;
@property (nonatomic, retain) UILabel* itemPriceLabel;
@property (nonatomic, retain) UIImageView* itemImage;

//-----------------------------------------------------------------------------------------------------------------------------------

@end
