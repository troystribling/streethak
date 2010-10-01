//
//  NavigationLauncherView.m
//  streethak
//
//  Created by Troy Stribling on 9/30/10.
//  Copyright 2010 planBresearch. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "NavigationLauncherView.h"
#import "TouchAreaView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface NavigationLauncherView (PrivateAPI)

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NavigationLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize configLauncher;
@synthesize contactsLauncher;
@synthesize mapLauncher;
@synthesize delegate;

//===================================================================================================================================
#pragma mark NavigationLauncherView

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_view withImageNamed:(NSString*)_imageName andDelegate:(id<NavigationLauncherViewDelegate>)_delegate {
    return [[[NavigationLauncherView alloc] initInView:_view withImageNamed:_imageName andDelegate:_delegate] autorelease];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initInView:(UIView*)_view withImageNamed:(NSString*)_imageName andDelegate:(id<NavigationLauncherViewDelegate>)_delegate {
    CGFloat viewWidth =  _view.frame.size.width;
    CGFloat viewHeight = 0.1042*_view.frame.size.height;
    CGFloat viewPosY = 0.8958*_view.frame.size.height;
    CGRect viewFrame = CGRectMake(0.0,  viewPosY, viewWidth, viewHeight);
    if ((self = [self initWithFrame:viewFrame])) {
        self.delegate = _delegate;
        self.image = [UIImage imageNamed:_imageName];
        self.userInteractionEnabled = YES;
        CGRect configFrame = CGRectMake(0.7859*viewWidth, 0.0, 0.1797*viewWidth, viewHeight);
        self.configLauncher = [TouchAreaView createWithFrame:configFrame name:@"config" andDelegate:self];
        [self addSubview:self.configLauncher];
        CGRect contactsFrame = CGRectMake(0.2875*viewWidth, 0.0, 0.4531*viewWidth, viewHeight);
        self.contactsLauncher = [TouchAreaView createWithFrame:contactsFrame name:@"contacts" andDelegate:self];
        [self addSubview:self.contactsLauncher];
        CGRect mapFrame = CGRectMake(0.0312*viewWidth, 0.0, 0.2266*viewWidth, viewHeight);
        self.mapLauncher = [TouchAreaView createWithFrame:mapFrame name:@"location" andDelegate:self];
        [self addSubview:self.mapLauncher];
        [_view addSubview:self];
    }
    return self;
}

//===================================================================================================================================
#pragma mark MapTopLauncherView PrivateAPI

//===================================================================================================================================
#pragma mark TouchAreaView Delegate

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouched:(TouchAreaView*)touchedView {
    if ([touchedView.viewName isEqualToString:@"config"]) {
        if ([self.delegate respondsToSelector:@selector(touchedConfig)]) {
            [self.delegate touchedConfig];
        }         
    } else if ([touchedView.viewName isEqualToString:@"contacts"]) {
        if ([self.delegate respondsToSelector:@selector(touchedContacts)]) {
            [self.delegate touchedContacts];
        }         
    } else if ([touchedView.viewName isEqualToString:@"location"]) {
        if ([self.delegate respondsToSelector:@selector(touchedLocation)]) {
            [self.delegate touchedLocation];
        }         
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
