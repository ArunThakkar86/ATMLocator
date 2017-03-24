//
//  Constant.h
//  ATMLocator
//
//  Created by Zensar on 23/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define kBaseURL @"https://m.chase.com/PSRWeb/location/list.action"
#define kUNABLE_TO_PROCESS_REQUEST @"Unable to process your request"
#define kENABLE_DATA_CONNECTION @"Network not available, please connect with data connection"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define kNODATAFOUND @"No atm/branch available at this location"
#endif /* Constant_h */
