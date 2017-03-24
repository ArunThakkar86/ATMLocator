//
//  ALColorManager.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kDEFAULT_WHITE_COLOR [UIColor whiteColor]
#define kDEFAULT_GRAY_COLOR [UIColor grayColor]
#define kDEFAULT_CLEAR_COLOR [UIColor clearColor]

@interface ALColorManager : NSObject

+(UIColor *)colorFromHexString:(NSString *)hexString;

@end
