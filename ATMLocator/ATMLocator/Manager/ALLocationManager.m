//
//  ALLocationManager.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALLocationManager.h"
#import "Constant.h"
@implementation ALLocationManager

+ (ALLocationManager *)sharedInstance {
    
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

#pragma mark - CLLocationManager
- (void)getCurrentLocation_WithBlock:(void(^)())block {
    self._locationBlock = block;
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //    if (IS_OS_8_OR_LATER) {
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
        //        }
    }
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLoc = [locations objectAtIndex:0];
    _coordinate = currentLoc.coordinate;
    _current_Lat = [NSString stringWithFormat:@"%f",currentLoc.coordinate.latitude];
    _current_Long = [NSString stringWithFormat:@"%f",currentLoc.coordinate.longitude];
    NSLog(@"here lat %@ and here long %@",_current_Lat,_current_Long);
    self._locationBlock();
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}
@end
