//
//  ALAppUtility.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALAppUtility.h"
#import "UIWindow+VisibleViewController.h"
#import "Constant.h"
#import "ALColorManager.h"
#import "MBProgressHUD.h"

@implementation ALAppUtility

/*---------------------------------------------------------------------------
 * sharedInstance
 * This method returns sharedInstance ALAppUtility
 *--------------------------------------------------------------------------*/

+ (ALAppUtility *)sharedInstance {
    
    static dispatch_once_t onceToken;
    static id sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super alloc] init];
    });
    
    return sharedInstance;
}

+ (id) alloc {
    return [self sharedInstance];
}

/*---------------------------------------------------------------------------
 * sharedInstance
 * This method returns instance of UITableViewCell for selected identifier
 *--------------------------------------------------------------------------*/

+ (UITableViewCell *)tableView:(UITableView *)tableView cellWithIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

/*---------------------------------------------------------------------------
 * callTo
 * This method is used to make call to clicked number
 *--------------------------------------------------------------------------*/

+ (void) callTo:(NSString *)aTelNumber {
    UIDevice *device = [UIDevice currentDevice];
    if ([[device model] isEqualToString:@"iPhone"] ) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", aTelNumber]];
        
        if ([[UIApplication sharedApplication] canOpenURL: url])
        {
            [[UIApplication sharedApplication] openURL: url];
        }
    } else {
        [ALAppUtility showAlertViewWithTitle:@"Oops!" message:@"Your device doesn't support this feature." cancelTitle:@"OK"];
    }
}

#pragma mark - show alert methods

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message tag:(int)tag cancelTitle:(NSString *)btnTitle ensureTitle:(NSString *)ensureTitle delegate:(UIViewController *)delegate completionHandler:(void (^) (NSString *buttonTitle))completionHandler {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([UIAlertController class])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            // cancel(first) button
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                     {
                                         NSLog(@"Cancel action");
                                         
                                         if(completionHandler != nil) {
                                             completionHandler(btnTitle);
                                         }
                                     }];
            [alertController addAction:cancel];
            
            // ensure(second) button
            if (ensureTitle) {
                UIAlertAction *ok = [UIAlertAction actionWithTitle:ensureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                     {
                                         NSLog(@"ensureTitle action");
                                         if(completionHandler != nil) {
                                             completionHandler(ensureTitle);
                                         }
                                     }];
                [alertController addAction:ok];
            }
            UIViewController *mainController = [UIWindow visibleViewController];
            [mainController presentViewController:alertController animated:YES completion:nil];
        } else {
            
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:btnTitle otherButtonTitles:ensureTitle,nil];
            alertView.tag = tag;
            [alertView show];
        }
    });
}

//-------------------- server unable to process -----------------------------//
+ (void)showAlertWithServerUnableToProcess {
    [ALAppUtility showAlertWithMessage:kUNABLE_TO_PROCESS_REQUEST];
}

//-------------------- check internet connection alert -----------------------------//
+ (void)showAlertWithCheckInternetConnection {
    [ALAppUtility showAlertWithMessage:kENABLE_DATA_CONNECTION];
}

+ (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)btnTitle {
    [ALAppUtility showAlertViewWithTitle:title message:message tag:0 cancelTitle:@"OK" ensureTitle:nil delegate:nil completionHandler:nil];
}

+ (void)showAlertWithMessage:(NSString *)message cancelTitle:(NSString *)btnTitle {
    [ALAppUtility showAlertViewWithTitle:[self getApplicationNameForAlertHeader] message:message tag:0 cancelTitle:@"OK" ensureTitle:nil delegate:nil completionHandler:nil];
}

+ (void)showAlertWithMessage:(NSString *)message {
    [ALAppUtility showAlertViewWithTitle:[self getApplicationNameForAlertHeader] message:message tag:0 cancelTitle:@"OK" ensureTitle:nil delegate:nil completionHandler:nil];
}

+ (NSString *)getApplicationNameForAlertHeader {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

#pragma mark - MBProgressHUD methods -

/*---------------------------------------------------------------------------
 * showProgressView
 * This method is used to show loading indicator
 *--------------------------------------------------------------------------*/
+ (void)showProgressView{
    UIViewController *mainController = [UIWindow visibleViewController];
     [MBProgressHUD showHUDAddedTo:mainController.view animated:YES];
}

/*---------------------------------------------------------------------------
 * dismissProgressView
 * This method is used to dismiss loading indicator
 *--------------------------------------------------------------------------*/

+ (void)dismissProgressView {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *mainController = [UIWindow visibleViewController];
        [MBProgressHUD hideHUDForView:mainController.view animated:YES];
    });
}


@end
