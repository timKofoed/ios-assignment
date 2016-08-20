//
//  LoginVC.m
//  SGTKofoed
//
//  Created by Tim Kofoed on 20/08/16.
//  Copyright © 2016 TKofoed. All rights reserved.
//

#import "LoginVC.h"
#import "ServerMockup.h"
#import "UserInfo.h"

@interface LoginVC ()

@property (nonatomic, strong) IBOutlet UITextField* usernameField;  //email == username
@property (nonatomic, strong) IBOutlet UITextField* passwordField;
@property (nonatomic, strong) IBOutlet UILabel* loginResult;

@end

@implementation LoginVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // if the user is logged in, then log him out right now, and present login as normal
    if([[UserInfo instance] GetUserLoggedIn] != nil)
    {
        [[UserInfo instance] SetUserLoggedIn:@""];
        self.loginResult.text = @"You are now logged Out";
    }
}

- (void)AttemptLogin
{
    // NOTE: "password must be ≥6 characters" is an invalid request, because I am not required to handle the creation of a new password. I'm therefore assuming that the password has been created, and that it is complex enough. If I were to enforce the >= 6, then the LHS of the email would have to also be >= 6, because you've defined that the password should be the LHS of the email. I don't know your names, so I therefore don't feel I should enforce that requirement.
    
    if([self verifyEmail])
        [self LoginAttemptWithName:self.usernameField.text withPassword:self.passwordField.text];
    else
        self.loginResult.text = @"Username should be an email address";
    
}

// verify that the entered username looks like an email address
-(bool)verifyEmail
{
    NSMutableArray* emailSplit = [[NSMutableArray alloc] initWithArray: [self.usernameField.text componentsSeparatedByString:@"@"] ];
    
    NSLog(@"split username into (%lu)", (unsigned long)emailSplit.count);
    
    // local @ email.com
    if( emailSplit.count == 2 )
    {
        // email . com
        if( [emailSplit[1] componentsSeparatedByString:@"."].count == 2 )
            return YES;
    }
    
    return NO;
}

// begin the process of attempting to login with a username (email) and raw password
- (void)LoginAttemptWithName:(NSString*)username withPassword:(NSString*)pass
{
    // Get the salt
    NSString* userSalt = [[ServerMockup instance] GetUserSalt:username];
    
    // Create the salted hash
    NSString* userSHA = [self createHashForUser:username withPassword:pass andSalt:userSalt];
    
    // Send the username and the salted hash to the server for verification
    bool loginVerified = [[ServerMockup instance] AttemptUserLogin:username withPassword:userSHA];
    
    if(loginVerified)
    {
        self.loginResult.text = [NSString stringWithFormat:@"%@ Logged in", username];
        [[UserInfo instance] SetUserLoggedIn:username];
        
        // automatically return to the main page after a short delay (if the user hasn't already done so)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(self.navigationController.visibleViewController == self)
                [self.navigationController popViewControllerAnimated:YES];
        });
    }
    else
    {
        self.loginResult.text = @"Incorrect username/password";
    }
    
}

-(void)Logout
{
    [[UserInfo instance] SetUserLoggedIn:nil];
}

// take the raw password and combine it with the salt and create a hash
- (NSString*)createHashForUser:(NSString*)username withPassword:(NSString*)password andSalt:(NSString*)salt
{
    // combine the salt an the password in a non-obvious manner
    NSString* newPass = [[NSString alloc] initWithFormat:@"%@%@", password, salt];
    
    // create the SHA from the salted password
    // ..
    // ..
    // ..
    
    // Mockup: assume all @shopgun accounts are valid
    NSString* localPartOfEmail = [[username componentsSeparatedByString:@"@"] firstObject];
    NSString* domainPartOfEmail = [[[[username componentsSeparatedByString:@"@"] lastObject] componentsSeparatedByString:@"."] firstObject];
    
    if(([domainPartOfEmail caseInsensitiveCompare:@"shopgun"] == NSOrderedSame) && ([password compare:localPartOfEmail] == NSOrderedSame))
    {
        NSLog(@"correct pass given");
        newPass = @"SHAPw"; // (mockup: correct) Salted, hashed password unique for this user
    }
    else
    {
        NSLog(@"false pass given");
        newPass = @"SHABS"; // (mockup: incorrect) Salted, hashed password unique for this user
    }

    
    return newPass;
}

@end
