//
//  SendMessageViewController.m
//  webgnosus
//
//  Created by Troy Stribling on 2/25/09.
//  Copyright 2009 Plan-B Research. All rights reserved.
//

//-----------------------------------------------------------------------------------------------------------------------------------
#import "SendMessageViewController.h"
#import "MessageModel.h"
#import "AccountModel.h"

#import "XMPPMessage.h"
#import "XMPPClientManager.h"
#import "XMPPClient.h"
#import "XMPPJID.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface SendMessageViewController (PrivateAPI)

- (void)loadAccount;

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SendMessageViewController

//-----------------------------------------------------------------------------------------------------------------------------------
@synthesize messageView;
@synthesize sendMessageButton;
@synthesize account;
@synthesize contact;
@synthesize containerView;

//===================================================================================================================================
#pragma mark SendMessageViewController

//-----------------------------------------------------------------------------------------------------------------------------------
+ (id)inView:(UIView*)_containerView {
    return [[SendMessageViewController alloc] initWithNibName:@"SendMessageViewController" bundle:nil inView:_containerView];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil inView:(UIView*)_containerView {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.containerView = _containerView;
        self.view.frame = self.containerView.frame;
    }
    return self;
}

//===================================================================================================================================
#pragma mark SendMessageViewController PrivateAPI

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)loadAccount {
    self.account = [AccountModel findFirstDisplayed];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (IBAction)sendMessageButtonWasPressed:(id)sender {
    NSString* enteredMessageText = self.messageView.text;
    if (![enteredMessageText isEqualToString:@""]) {
        MessageModel* model = [[MessageModel alloc] init];
        model.messageText = enteredMessageText;
        model.accountPk = self.account.pk;
        model.toJid = [self.contact fullJID];
        model.fromJid = [self.account fullJID];
        model.textType = MessageTextTypeBody;
        model.createdAt = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
        model.itemId = @"-1";
        model.messageRead = YES;
        [model insert];
        [model release];
        XMPPClient* xmppClient = [[XMPPClientManager instance] xmppClientForAccount:self.account];
        [XMPPMessage chat:xmppClient JID:[self.contact toJID] messageBody:enteredMessageText];
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
    [self.messageView becomeFirstResponder];
    [super viewDidLoad];
}

//-----------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [self loadAccount];
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

