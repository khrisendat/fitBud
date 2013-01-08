//
//  oauthMachine.h
//  Fitbitappv3
//
//  Created by Khrisendat Persaud on 1/1/13.
//  Copyright (c) 2013 Khrisendat Persaud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthConsumer.h"


@interface oauthMachine : NSObject

-(NSString *)requestTempToken;
-(void)requestAcessToken:(NSString *)URLString;

@end
