//
//  ALAPIManager.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALAPIManager.h"
#import "ALLocationManager.h"
#import "Constant.h"
#import "ALAPIManager.h"
#import "ALATMInfo.h"
#import "ALAppUtility.h"
#import <APIManager/ConnectionManager.h>


@implementation ALAPIManager

/*---------------------------------------------------------------------------
 * getStoreListCompletion
 * This method invoke method to get data from server and get response.
 * It also format the response and fill model object for further use
 *--------------------------------------------------------------------------*/

+ (void)getStoreListCompletion:(void (^) (NSArray *locationArray))completionHandler{
    
    [ALAppUtility showProgressView];
    [[ALLocationManager sharedInstance] getCurrentLocation_WithBlock:^{
        NSString *url = @"";
        NSString *current_lat = [ALLocationManager sharedInstance].current_Lat;
        NSString *current_long = [ALLocationManager sharedInstance].current_Long;
        url = [NSString stringWithFormat:@"%@?lat=%@&lng=%@", kBaseURL, current_lat, current_long];
        [ConnectionManager sendRequestWithURLString:url indicatorMessage:@"Loading Stores..." methodType:@"POST" requestDictionary:nil completionHandler:^(NSDictionary *responseDictionary, NSError *error) {
            
            if(error){
                [ALAppUtility dismissProgressView];
                NSString *strMsg = error.userInfo[@"NSLocalizedDescription"];
                [ALAppUtility showAlertWithMessage:strMsg cancelTitle:@"OK"];
                
            }
            NSArray *locations = responseDictionary[@"locations"];
           
            NSMutableArray *atmArray = [[NSMutableArray alloc] init];
            if (locations.count > 0) {
                [ALAppUtility dismissProgressView];
                for(int i = 0; i<locations.count; i++){
                    ALATMInfo *model = [[ALATMInfo alloc] init];
                    model.state = locations[i][@"state"];
                    model.locType = locations[i][@"locType"];
                    model.label = locations[i][@"label"];
                    model.address = locations[i][@"address"];
                    model.city = locations[i][@"city"];
                    model.zip = locations[i][@"zip"];
                    model.name = locations[i][@"name"];
                    model.lat = locations[i][@"lat"];
                    model.lng = locations[i][@"lng"];
                    model.bank = locations[i][@"bank"];
                    model.type = locations[i][@"type"];
                    model.lobbyHrs = locations[i][@"lobbyHrs"];
                    model.driveUpHrs = locations[i][@"driveUpHrs"];
                    model.services = locations[i][@"services"];
                    model.phone = locations[i][@"phone"];
                    model.distance = locations[i][@"distance"];
                    [atmArray addObject:model];
                }
                completionHandler(atmArray);
            }else {
                [ALAppUtility dismissProgressView];
                [ALAppUtility showAlertWithMessage:kNODATAFOUND cancelTitle:@"OK"];
            }
        }];
    }];
}


@end
