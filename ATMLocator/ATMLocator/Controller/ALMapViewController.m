//
//  ALMapViewController.m
//  ATMLocator
//
//  Created by Zensar on 24/03/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

#import "ALMapViewController.h"
#import "ALLocationManager.h"
#import "ALATMInfo.h"
#import "ALAPIManager.h"
#import "ALDetailViewController.h"
#import "ALStoryboardManager.h"
#import "ALAppUtility.h"
#import "AppDelegate.h"

@interface ALMapViewController(){
    
    NSArray *atmList;
}
@end


@implementation ALMapViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    _mapView.showsUserLocation = YES;
    
    if (![AppDelegate isServerReachable]) {
        [ALAppUtility showAlertWithCheckInternetConnection];
        return;
    }else {
     [self getATMListFromServer];
    }
}

- (void)getATMListFromServer{
    
    
    [ALAPIManager getStoreListCompletion:^(NSArray *locationArray) {
        if(locationArray.count >0){
            atmList = locationArray;
            [self setupMapUI];
        }
    }];
}

- (void)setupMapUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupMap];
        [self setupLocationManager];
        
    });
}

- (void)setupMap{
    if(atmList.count >0){
        for (ALATMInfo *atm in atmList) {
            
            MKPointAnnotation *marker = [[MKPointAnnotation alloc] init];
            double lattitude = [atm.lat doubleValue];
            double longitude = [atm.lng doubleValue];
            
            marker.coordinate = CLLocationCoordinate2DMake(lattitude, longitude);
            marker.title = atm.name;
            marker.subtitle = atm.city;
            [_mapView addAnnotation:marker];
        }
    }
    [ALAppUtility dismissProgressView];
    
}

- (void)setupLocationManager{
    [[ALLocationManager sharedInstance] getCurrentLocation_WithBlock:^{
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta=0.2;
        span.longitudeDelta=0.2;
        
        CLLocationCoordinate2D location = [ALLocationManager sharedInstance].coordinate;
        region.span=span;
        region.center=location;
        [_mapView setRegion:region];
        
    }];
}
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
//    MKPinAnnotationView *mypin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"current"];
//    //mypin.pinTintColor = MKPinAnnotationColorGreen;
//    mypin.backgroundColor = [UIColor clearColor];
//    UIButton *goToDetail = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    mypin.rightCalloutAccessoryView = goToDetail;
//    mypin.draggable = NO;
//    mypin.highlighted = YES;
//    mypin.animatesDrop = TRUE;
//    mypin.canShowCallout = YES;
//    return mypin;
    static NSString *atmLocator = @"ATMLocatorIdentifier";
    MKPinAnnotationView *pinView =
    (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:atmLocator];
    
    if([annotation.title isEqualToString:@"Current Location"])
        return pinView;
    
    if (!pinView)
    {
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:atmLocator];
        UIImage *flagImage = [UIImage imageNamed:@"mapMarker"];
        annotationView.image = flagImage;
//        UIButton * rightButton = [[UIButton alloc ] initWithFrame:CGRectMake(0, 0, 47, 47)];
//        [rightButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    else
    {
        pinView.annotation = annotation;
    }
    return pinView;
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ALAppUtility showProgressView];
    });
        id <MKAnnotation> selectedMarker = view.annotation;
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", selectedMarker.title];
//        NSArray *results = [atmList filteredArrayUsingPredicate:predicate];
//        if(results.count > 0){
            ALDetailViewController *viewController = (ALDetailViewController *)[ALStoryboardManager storyboardWithName:@"Main" getViewControllerWithIdentifier:@"StoreDetailView"];
            viewController.selectedMarker = selectedMarker;//[results objectAtIndex:0];
            viewController.atmList = atmList;
            [self.navigationController pushViewController:viewController animated:YES];
//        }
}


@end
