//
//  ALStoryboardManager.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALStoryboardManager.h"

@implementation ALStoryboardManager

+ (UIStoryboard *)storyboardWithName:(NSString *)storyboardName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return storyboard;
}

+ (UIViewController *)storyboardWithName:(NSString *)storyboardName getViewControllerWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

+ (UIViewController *)storyboard:(UIStoryboard *)storyboard getViewControllerWithIdentifier:(NSString *)identifier {
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

+ (UIStoryboard *)getMainStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyboard;
}


@end
