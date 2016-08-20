//
//  ServerMockup.m
//  SGTKofoed
//
//  Created by Tim Kofoed on 20/08/16.
//  Copyright © 2016 TKofoed. All rights reserved.
//

#import "ServerMockup.h"

static ServerMockup* _instance;

@implementation ServerMockup

+(ServerMockup*)instance
{
    return _instance;
}

-(id)init
{
    self = [super init];
    
    if(self)
    {
        _instance = self;
    }
    
    return self;
}

// Create a new user on the server, and generate the unique salt
-(bool)CreateNewUser:(NSString*)username
{
    // create and store the new user entry on the server
    // create and store a new unique salt for this user
    return YES;    // return true if it worked; false if the username is already taken
}

// Get the user-specific salt from server
-(NSString*)GetUserSalt:(NSString*)username
{
    // Get the unique salt for the requested user
    return @"#RWTGE4Y"; // if for some reason the user doesn't exist, return nil
}

//Send the username with the salted and hashed password and receive pass/fail from the server
-(bool)AttemptUserLogin:(NSString*)username withPassword:(NSString*)password
{
    NSString* correctPass = @"SHAPw";
    NSLog(@"compare (%@) with correct: (%@)", password, correctPass);
    
    // if the salted and hashed password matches, then return YES, otherwise return NO
    if([password compare:correctPass] == NSOrderedSame) // Salted, hashed password unique for this user
        return YES;
    else
        return NO;
}

// Store a new password for the given user ( SEND ONLY: salted and hashed passwords!)
-(bool)SetNewPassword:(NSString*)password usingPreviousPass:(NSString*)prevPassword
{
    // if the prevPassword matches the one in the DB, then approve the change, and store the new one; else return NO
    
    return YES;
}

@end
