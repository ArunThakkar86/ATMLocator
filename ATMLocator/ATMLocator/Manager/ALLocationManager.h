//
//  ALLocationManager.h
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//Location
typedef void(^locationBlock)();

@interface ALLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic, strong) locationBlock _locationBlock;
@property (nonatomic, copy) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *current_Lat;
@property (nonatomic, strong) NSString *current_Long;

// singleton instance
+ (ALLocationManager *)sharedInstance;

// to retrive user's current location
- (void)getCurrentLocation_WithBlock:(void(^)())block;

@end
