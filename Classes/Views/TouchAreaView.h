//
//  TouchAreaView.h
//  streethak
//
//  Created by Troy Stribling on 9/16/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import <UIKit/UIKit.h>

//-----------------------------------------------------------------------------------------------------------------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface TouchAreaView : UIView {
    id delegate;
    NSString* viewName;
}

//-----------------------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSString* viewName;

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)createWithFrame:(CGRect)_frame name:(NSString*)_viewName andDelegate:(id)_delegate;
- (id)initWithFrame:(CGRect)_frame name:(NSString*)_viewName andDelegate:(id)_delegate;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NSObject (TouchAreaView)

- (void)viewTouched:(TouchAreaView*)touchedView;

@end
