//
//  ALStoryboardManager.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALStoryboardManager.h"

@implementation ALStoryboardManager

/*---------------------------------------------------------------------------
 * storyboardWithName
 * This method returns storyborad of given name
 *--------------------------------------------------------------------------*/
+ (UIStoryboard *)storyboardWithName:(NSString *)storyboardName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return storyboard;
}

/*---------------------------------------------------------------------------
 * getViewControllerWithIdentifier
 * This method returns UIViewcontroller from storyboard using 
 * storyboard's identifier and name
 *--------------------------------------------------------------------------*/

+ (UIViewController *)storyboardWithName:(NSString *)storyboardName getViewControllerWithIdentifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

/*---------------------------------------------------------------------------
 * getViewControllerWithIdentifier
 * This method returns UIViewcontroller from storyboard using
 * storyboard's identifier and instance of storyboard
 *--------------------------------------------------------------------------*/
+ (UIViewController *)storyboard:(UIStoryboard *)storyboard getViewControllerWithIdentifier:(NSString *)identifier {
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}

/*---------------------------------------------------------------------------
 * getMainStoryboard
 * This method returns instance of Main Storybaord
 *--------------------------------------------------------------------------*/

+ (UIStoryboard *)getMainStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return storyboard;
}


@end
