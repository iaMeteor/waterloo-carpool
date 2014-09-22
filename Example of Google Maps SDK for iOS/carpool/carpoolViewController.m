//
//  carpoolViewController.m
//  carpool
//
//  Created by zhang zidong on 2/24/2014.
//  Copyright (c) 2014 Zidong Zhang. All rights reserved.
//

#import "carpoolViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>


@interface carpoolViewController ()

@end

@implementation carpoolViewController {
    GMSMapView *mapView_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /********************************************
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(mapView_.bounds.size.width - 110, mapView_.bounds.size.height - 30, 100, 20);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [mapView_ addSubview:button];
    ********************************************/
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_
    self.view = mapView_;
    
    //CGFloat mm = 0.05;
    
   // mapView_.projection.CoordinateForPoint
   // MKPinAnnotationView aView = [[[MKAnnotationView alloc] initWithAnnotation:
                                                         //     reuseIdentifier:@"MyCustomAnnotation"] autorelease];
    //MKAnnotation s =
    //<MKAnnotation>
    
    
    NSLog(@"x: %f", mapView_.center.x);
    
    // Creates a marker in the center of the map.
    GMSMarker *marker =
    [[GMSMarker alloc] init];
   // marker.position = camera.
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
}


@end
