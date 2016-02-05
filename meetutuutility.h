//
//  meetutuutility.h
//  Meetutu
//
//  Created by sanjeev s on 02/02/16.
//  Copyright © 2016 sanjeev s. All rights reserved.
//

#import <Foundation/Foundation.h>
#define EMAIL_REGEX @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define WEBSITE_REGEX @"((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
#define	PASSWORD_LENGTH 100




@interface meetutuutility : NSObject


+(BOOL) checkForEmail:(NSString *) emailId;
@end
