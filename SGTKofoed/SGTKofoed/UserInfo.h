//
//  UserInfo.h
//  SGTKofoed
//
//  Created by Tim Kofoed on 20/08/16.
//  Copyright © 2016 TKofoed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+(UserInfo*)instance;
-(NSString*)GetUserLoggedIn;
-(void)SetUserLoggedIn:(NSString*)user;

@end
