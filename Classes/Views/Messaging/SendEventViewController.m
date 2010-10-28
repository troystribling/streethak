//
//  SendEventViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 10/3/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SendEventViewController.h"
#import "SendBottomLauncherView.h"
#import "AlertViewManager.h"
#import "ServiceModel.h"
#import "ViewControllerManager.h"
#import "MessageModel.h"
#import "AccountModel.h"
#import "XMPPEntry.h"
#import "XMPPClientManager.h"
#import "XMPPClient.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendEventViewController (PrivateAPI)

- (void)loadAccount;
- (void)sendMessage;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SendEventViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize messageView;
@synthesize containerView;
@synthesize node;
@synthesize account;

//===================================================================================================================================
#pragma mark SendEventViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[SendEventViewController alloc] initWithNibName:@"SendEventViewController" bundle:nil inView:_containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.containerView = _containerView;
        self.view.frame = self.containerView.frame;
        self.messageView.font = [UIFont fontWithName:kGLOBAL_FONT size:24.0];
    }
    return self;
}

//===================================================================================================================================
#pragma mark SendEventViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirstDisplayed];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)sendMessage {
    NSString* enteredMessageText = self.messageView.text;
    if (![enteredMessageText isEqualToString:@""]) {
        MessageModel* model = [[MessageModel alloc] init];
        NSMutableArray* pubSubServices = [ServiceModel findAllByServiceCategory:@"pubsub"];
        if ([pubSubServices count] > 0) {
            ServiceModel* pubSubService = [pubSubServices objectAtIndex:0];
            model.messageText = enteredMessageText;
            model.accountPk = self.account.pk;
            model.toJid = pubSubService.jid;
            model.fromJid = [self.account fullJID];
            model.createdAt = [NSDate date];
            model.textType = MessageTextTypeEventText;
            model.itemId = @"-1";
            model.node = self.node;
            model.messageRead = YES;
            [model insert];
            [model release];
            XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:self.account];
            [XMPPEntry publish:xmppClient  JID:[XMPPJID jidWithString:pubSubService.jid] node:self.node withTitle:enteredMessageText];
        } else {
            [AlertViewManager showAlert:@"Service not found" withMessage:@""];
        }
    }    
    [self.messageView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}	

//===================================================================================================================================
#pragma mark UIViewController

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle { 
	if (self = [super initWithNibName:nibName bundle:nibBundle]) { 
	} 
	return self; 
} 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [SendTopLauncherView inView:self.view withImageNamed:@"send-shout-top-launcher.png" andDelegate:self];
    [SendBottomLauncherView inView:self.view andDelegate:self];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
    self.messageView.text = @"";
    [self.messageView becomeFirstResponder];
    [[XMPPClientManager instance] delegateTo:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated {
    [[XMPPClientManager instance] removeXMPPClientDelegate:self forAccount:self.account];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

//===================================================================================================================================
#pragma mark LauncherViewDelegate 

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewTouchedNamed:(NSString*)_name {
    if ([_name isEqualToString:@"send"]) {
        [self sendMessage];
        [[ViewControllerManager instance] shoutsViewWillAppear];
        [self.view removeFromSuperview];
    } else if ([_name isEqualToString:@"back"]) {
        [[ViewControllerManager instance] shoutsViewWillAppear];
        [self.view removeFromSuperview];
    }
}

//===================================================================================================================================
#pragma mark XMPPClientDelegate

//===================================================================================================================================
#pragma mark UITextViewDelegate

//===================================================================================================================================
#pragma mark NSObject

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {
    [super dealloc];
}

@end
