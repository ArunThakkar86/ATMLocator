//
//  ALAPIManager.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAPIManager : NSObject

// get current location
+ (NSString *)getURL;

// get ATM list from server
+ (void)getStoreListCompletion:(void (^) (NSArray *locationArray))completionHandler;


@end
