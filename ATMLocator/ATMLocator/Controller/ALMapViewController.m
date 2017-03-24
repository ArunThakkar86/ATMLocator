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

/*---------------------------------------------------------------------------
 * getATMListFromServer
 * This method invoke service call to another method to retrive 
 * data from server
 *--------------------------------------------------------------------------*/
- (void)getATMListFromServer{
    
    
    [ALAPIManager getStoreListCompletion:^(NSArray *locationArray) {
        if(locationArray.count >0){
            atmList = locationArray;
            [self setupMapUI];
        }
    }];
}

/*---------------------------------------------------------------------------
 * setupMapUI
 * This method invokes method to set up initial MAP 
 * and initializind Core Location
 *--------------------------------------------------------------------------*/

- (void)setupMapUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupMap];
        [self setupLocationManager];
        
    });
}

/*---------------------------------------------------------------------------
 * setupMap
 * This method is used to map latitude and longitude of all ATM / brance data
 * coming from server and place markers.
 *--------------------------------------------------------------------------*/

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

/*---------------------------------------------------------------------------
 * setupLocationManager
 * This method is used set region and span of Map (i.e. Zoom Level)
 *--------------------------------------------------------------------------*/
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


/*---------------------------------------------------------------------------
 * viewForAnnotation
 * This is delegate method to set view for marker (i.e to customize markers)
 *--------------------------------------------------------------------------*/
- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
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

/*---------------------------------------------------------------------------
 * calloutAccessoryControlTapped
 * This is delegate method and called when user taps on markers.
 *--------------------------------------------------------------------------*/

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [ALAppUtility showProgressView];
    });
        id <MKAnnotation> selectedMarker = view.annotation;
            ALDetailViewController *viewController = (ALDetailViewController *)[ALStoryboardManager storyboardWithName:@"Main" getViewControllerWithIdentifier:@"StoreDetailView"];
            viewController.selectedMarker = selectedMarker;
            viewController.atmList = atmList;
            [self.navigationController pushViewController:viewController animated:YES];
}


@end
