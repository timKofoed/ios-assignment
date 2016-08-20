//
//  UserInfo.m
//  SGTKofoed
//
//  Created by Tim Kofoed on 20/08/16.
//  Copyright © 2016 TKofoed. All rights reserved.
//

#import "UserInfo.h"

@interface UserInfo()
@property (nonatomic, strong) NSString* userLoggedIn;
@end

static UserInfo* _instance;

@implementation UserInfo

+(UserInfo*)instance
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

-(NSString*)GetUserLoggedIn
{
    return self.userLoggedIn;
}

-(void)SetUserLoggedIn:(NSString*)user
{
    self.userLoggedIn = ([user isEqualToString:@""])?nil:[NSString stringWithString:user];
}

@end
