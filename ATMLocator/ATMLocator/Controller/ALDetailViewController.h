//
//  ALDetailViewController.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALATMInfo.h"

@interface ALDetailViewController : UIViewController
@property (strong, nonatomic) ALATMInfo *selectedATM;
@property (nonatomic, assign) float tableHeight;

@end
