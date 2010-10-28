//
//  ContactMessagesTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/13/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactMessagesTopLauncherView.h"
#import "TouchAreaView.h"
#import "ViewControllerManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactMessagesTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactMessagesTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize contactNameLabel;
@synthesize sendMessageLauncher;
@synthesize backLauncher;

//===================================================================================================================================
#pragma mark ContactMessagesTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark ContactMessagesTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    return [[ContactMessagesTopLauncherView alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<LauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"contact-messages-top-launcher.png" andDelegate:_delegate])) {
        self.containedView = _view;
        CGRect labelFrame = CGRectMake(0.2891*viewWidth, 0.175*viewHeight, 0.4219*viewWidth, 0.45*viewHeight);
        self.contactNameLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.contactNameLabel.font = [UIFont fontWithName:kGLOBAL_FONT size:24.0];
        self.contactNameLabel.backgroundColor = [UIColor clearColor];
        self.contactNameLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.contactNameLabel];
        CGRect backFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.backLauncher = [TouchAreaView createWithFrame:backFrame name:@"back" andDelegate:self];
        [self addSubview:self.backLauncher];
        CGRect sendMessageFrame = CGRectMake(0.8047*viewWidth, 0.0, 0.1875*viewWidth, viewHeight);
        self.sendMessageLauncher = [TouchAreaView createWithFrame:sendMessageFrame name:@"send-message" andDelegate:self];
        [self addSubview:self.sendMessageLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    [self.delegate viewTouchedNamed:touchedView.viewName];
}

//===================================================================================================================================
#pragma mark UIView

//===================================================================================================================================
#pragma mark NSObject

@end
