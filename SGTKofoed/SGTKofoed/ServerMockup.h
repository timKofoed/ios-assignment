//
//  ServerMockup.h
//  SGTKofoed
//
//  Created by Tim Kofoed on 20/08/16.
//  Copyright © 2016 TKofoed. All rights reserved.
//

#import <Foundation/Foundation.h>

// This server is not here. This is not the server you are looking for. It's in the cloud. Trust me.
@interface ServerMockup : NSObject

+(ServerMockup*)instance;
-(bool)CreateNewUser:(NSString*)username;   // Create a new user on the server, and generate the unique salt
-(NSString*)GetUserSalt:(NSString*)username;    // Get the user-specific salt from server
-(bool)AttemptUserLogin:(NSString*)username withPassword:(NSString*)password;   //Send the username with the salted and hashed password and receive pass/fail from the server
-(bool)SetNewPassword:(NSString*)password usingPreviousPass:(NSString*)prevPassword;  // Store a new password for the given user ( SEND ONLY: salted and hashed passwords!)

@end
