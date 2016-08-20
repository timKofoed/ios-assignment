//
//  ViewController.m
//  SGTKofoed
//
//  Created by Tim Kofoed on 19/08/16.
//  Copyright © 2016 TKofoed. All rights reserved.
//

#import "ViewController.h"
#import "ServerMockup.h"
#import "UserInfo.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UIButton* btnLogin;
@property (nonatomic, strong) IBOutlet UIButton* btnGotoNext;
@property (nonatomic, strong) IBOutlet UILabel* labelLoggedIn;
@property (nonatomic, strong) ServerMockup* serverConnection;
@property (nonatomic, strong) UserInfo* userInfo;   //CoreData DB connection? ...or a holder for a CoreData DB?
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.userInfo = [[UserInfo alloc] init];
    self.serverConnection = [[ServerMockup alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self checkLoginStatus];
}

// update accessibility and labels based on whether we're logged in or not
-(void)checkLoginStatus
{
    if( [self.userInfo GetUserLoggedIn] != nil )
    {
        NSLog(@"login YES");
        self.labelLoggedIn.text = [self.userInfo GetUserLoggedIn];
        [self.btnGotoNext setEnabled:YES];
        [self.btnLogin setTitle:@"Logout" forState:UIControlStateNormal];
        [self.btnGotoNext setBackgroundColor:[[UIColor alloc] initWithRed:0.0f green:0.8f blue:0.0f alpha:1.0f]];
        
        // I should probably have an alert popup in this case, if the "Logout" is pressed... but it's late, and I'm getting tired.
        
    }
    else
    {
        NSLog(@"login NO");
        self.labelLoggedIn.text = @"Not logged in";
        [self.btnGotoNext setEnabled:NO];
        [self.btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        [self.btnGotoNext setBackgroundColor:[[UIColor alloc] initWithRed:0.8f green:0.0f blue:0.0f alpha:1.0f]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
