//
//  ContactsMessagesTopLauncher.m
//  streethak
//
//  Created by Troy Stribling on 10/13/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactsMessagesTopLauncher.h"
#import "TouchAreaView.h"
#import "ViewControllerManager.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactsMessagesTopLauncher (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactsMessagesTopLauncher

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize sendMessageLauncher;

//===================================================================================================================================
#pragma mark ContactsMessagesTopLauncher PrivateAPI

//===================================================================================================================================
#pragma mark ContactsMessagesTopLauncher

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate {
    return [[ContactsMessagesTopLauncher alloc] initInView:_view andDelegate:_delegate];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view andDelegate:(id<TopLauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame image:@"contacts-messages-top-launcher.png" andDelegate:_delegate])) {
        self.containedView = _view;
        CGRect addContactFrame = CGRectMake(0.8281*viewWidth, 0.0, 0.1562*viewWidth, viewHeight);
        self.sendMessageLauncher = [TouchAreaView createWithFrame:addContactFrame name:@"send-message" andDelegate:self];
        [self addSubview:self.sendMessageLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"add-contact"]) {
        [[ViewControllerManager instance] showAddContactView:self.containedView];
    } else {
        [self.delegate viewTouchedNamed:touchedView.viewName];
    }
}

//===================================================================================================================================
#pragma mark UIView

//===================================================================================================================================
#pragma mark NSObject

@end
