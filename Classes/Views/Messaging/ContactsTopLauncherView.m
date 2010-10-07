//
//  ContactsTopLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 10/6/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "ContactsTopLauncherView.h"
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ContactsTopLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ContactsTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize backLauncher;
@synthesize containerView;


//===================================================================================================================================
#pragma mark ContactsTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark ContactsTopLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view {
    return [[[ContactsTopLauncherView alloc] initInView:_view] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0, 0.0, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame])) {
        self.containerView = _view;
        self.image = [UIImage imageNamed:@"contacts-top-launcher.png"];
        self.userInteractionEnabled = YES;
        CGRect backFrame = CGRectMake(0.0234*viewWidth, 0.0, 0.2109*viewWidth, viewHeight);
        self.backLauncher = [TouchAreaView createWithFrame:backFrame name:@"back" andDelegate:self];
        [self addSubview:self.backLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"back"]) {
        [self.containerView removeFromSuperview];
    } else if ([touchedView.viewName isEqualToString:@"add_contact"]) {
    }
}

//===================================================================================================================================
#pragma mark UIView

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

@end
