//
//  ALAppUtility.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALAppUtility : NSObject

+ (ALAppUtility *)sharedInstance;

+ (UITableViewCell *)tableView:(UITableView *)tableView cellWithIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;

+ (void) callTo:(NSString *)aTelNumber;

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message tag:(int)tag cancelTitle:(NSString *)btnTitle ensureTitle:(NSString *)ensureTitle delegate:(UIViewController *)delegate completionHandler:(void (^) (NSString *buttonTitle))completionHandler;

//-------------------- server unable to process -----------------------------//
+ (void)showAlertWithServerUnableToProcess;

//-------------------- check internet connection alert -----------------------------//
+ (void)showAlertWithCheckInternetConnection;

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)btnTitle;
+ (void)showAlertWithMessage:(NSString *)message cancelTitle:(NSString *)btnTitle;
+ (void)showAlertWithMessage:(NSString *)message;

// indicatorview methods
//+ (void)showProgressViewWithStatus:(NSString *)status;
+ (void)showProgressView;
+ (void)dismissProgressView;
@end
