//
//  TouchAreaView.m
//  streethak
//
//  Created by Troy Stribling on 9/16/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface TouchAreaView (PrivateAPI)

- (void)delegateViewTouched;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TouchAreaView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize delegate;
@synthesize viewName;

//===================================================================================================================================
#pragma mark TouchAreaView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)createWithFrame:(CGRect)_frame name:(NSString*)_viewName andDelegate:(id)_delegate {
    return [[[TouchAreaView alloc] initWithFrame:_frame name:_viewName andDelegate:_delegate] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)_frame name:(NSString*)_viewName andDelegate:(id)_delegate {
    if (self = [self initWithFrame:_frame]) {
        self.delegate = _delegate;
        self.viewName = _viewName;
        self.userInteractionEnabled = YES;
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)delegateViewTouched {
    if ([self.delegate respondsToSelector:@selector(viewTouched:)]) {
        [self.delegate viewTouched:self];
    }
} 

//===================================================================================================================================
#pragma mark UIView

//===================================================================================================================================
- (id)initWithFrame:(CGRect)_frame {
    if ((self = [super initWithFrame:_frame])) {
        // Initialization code
    }
    return self;
}

//===================================================================================================================================
#pragma mark UIResponder

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    [self delegateViewTouched];
}

@end