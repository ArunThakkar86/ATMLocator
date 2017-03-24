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
#import "ConnectionManager.h"

@implementation ALAPIManager

+ (NSString *)getURL{
    __block NSString *url = @"";
    [[ALLocationManager sharedInstance] getCurrentLocation_WithBlock:^{
        NSString *current_lat = [ALLocationManager sharedInstance].current_Lat;
        NSString *current_long = [ALLocationManager sharedInstance].current_Long;
        url = [NSString stringWithFormat:@"%@?lat=%@&lng=%@", kBaseURL, current_lat, current_long];
    }];
    url = @"https://m.chase.com/PSRWeb/location/list.action?lat=40.147864&lng=-82.990959";
    return url;
}

// get store list from server
//+ (void)getStoreListCompletion:(void (^) (NSDictionary *responseDictionary, NSError *error))completionHandler {
+ (void)getStoreListCompletion:(void (^) (NSArray *locationArray))completionHandler{
    
    NSString *url = [ALAPIManager getURL];
    [ConnectionManager sendRequestWithURLString:url indicatorMessage:@"Loading Stores..." methodType:@"POST" requestDictionary:nil completionHandler:^(NSDictionary *responseDictionary, NSError *error) {
        
        //completionHandler(responseDictionary,error);
        NSArray *errors = responseDictionary[@"errors"];
        NSArray *locations = responseDictionary[@"locations"];
        NSMutableArray *atmArray = [[NSMutableArray alloc] init];
        if (errors.count <= 0 & locations.count > 0) {
            
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
        }
    }];
}


@end
