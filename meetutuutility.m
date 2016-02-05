//
//  meetutuutility.m
//  Meetutu
//
//  Created by sanjeev s on 02/02/16.
//  Copyright © 2016 sanjeev s. All rights reserved.
//

#import "meetutuutility.h"

@implementation meetutuutility



+(BOOL)checkForEmail:(NSString *) emailId
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EMAIL_REGEX];
    return [emailTest evaluateWithObject:emailId]?([emailId length] <= PASSWORD_LENGTH):NO;
}


@end
