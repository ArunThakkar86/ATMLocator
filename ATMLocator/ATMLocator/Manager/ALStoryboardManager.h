//
//  ALStoryboardManager.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ALStoryboardManager : NSObject

+ (UIStoryboard *)storyboardWithName:(NSString *)storyboardName;

+ (UIViewController *)storyboardWithName:(NSString *)storyboardName getViewControllerWithIdentifier:(NSString *)identifier;
+ (UIViewController *)storyboard:(UIStoryboard *)storyboard getViewControllerWithIdentifier:(NSString *)identifier;

+ (UIStoryboard *)getMainStoryboard;
@end
