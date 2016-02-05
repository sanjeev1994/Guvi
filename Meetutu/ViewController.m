//
//  ViewController.m
//  Meetutu
//
//  Created by sanjeev s on 31/01/16.
//  Copyright © 2016 sanjeev s. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface ViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate,MFMessageComposeViewControllerDelegate>
{
    GMSMapView *mapView_;
    NSArray * localat ,*localong ;

    
}
@end

@implementation ViewController
@synthesize listArray;
CLLocationManager *locationManager;
-(void)viewDidAppear:(BOOL)animated
{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // NSArray *items = [theString componentsSeparatedByString:@","];
    locationManager = [[CLLocationManager alloc] init];
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    NSLog(@"LAT_LONG__>%f,%f",latitude,longitude);
    
    listArray = [[NSMutableArray alloc]init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"email_id"]);
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tchinmai.xyz/guvi/locationupdate.php?email=%@&location=%f,%f",[[NSUserDefaults standardUserDefaults] objectForKey:@"email_id"],latitude,longitude]]];
    NSError* e1;
    [request setHTTPMethod:@"GET"];
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:&e1];
    
    NSError* error;
    NSDictionary* json;
    if (requestHandler != nil)
    {
        json = [NSJSONSerialization JSONObjectWithData:requestHandler options:kNilOptions error:&error];
    }
    NSLog(@"JSON----->%@",json);
    
    if (json != nil) {
        for (NSDictionary *di in json[@"users"]) {
            NSString *name  = [di objectForKey:@"Name"];
            NSString *email = [di objectForKey:@"email"];
            NSString *mobile = [di objectForKey:@"mobile"];
            NSString *teacher = [di objectForKey:@"teacher"];
            NSString *location = [di objectForKey:@"Location"];
            NSString *language = [di objectForKey:@"languages"];
            
            NSString *fullstr = [NSString stringWithFormat:@"%@^%@^%@^%@^%@^%@",name,email,mobile,teacher,location,language];
            [listArray addObject:fullstr];
            
        }
        
        for (int j =0 ; j<listArray.count; j++) {
            //   NSLog(@"%@",[listArray objectAtIndex:j]);
        }
    }

    
    
    
    
    
    
    
    
    

    
    mapView_.settings.myLocationButton = YES;
    mapView_.myLocationEnabled = YES;
    
    
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude                                                            longitude:longitude zoom:11];
    //NSLog(@"%f,%f",lt,ln);
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.delegate = self;

    self.view = mapView_;
    
    

    
    
    // Creates a marker in the center of the map.
   double lt = 0.0 , ln = 0.0;
   // localat = [NSArray arrayWithObjects:@"13.05",@"13.0723", nil];
   // localong = [NSArray arrayWithObjects:@"80.2343",@"80.1543", nil];
    for (int i =0 ; i<[listArray count]; i++) {
        NSString *restr = [listArray objectAtIndex:i];
        NSArray *reArray = [restr componentsSeparatedByString:@"^"];
        NSString * name_string = [reArray objectAtIndex:0];
      //  NSString * mail_string = [reArray objectAtIndex:1];
        NSString * mobile_string = [reArray objectAtIndex:2];
        NSString *teacher_string = [reArray objectAtIndex:3];
        NSString *location_string = [reArray objectAtIndex:4];
        NSString *skills_string = [reArray objectAtIndex:5];
        
       // NSLog(@"Name ---> %@,mail---->@%@,mobile -->%@",name_string,mail_string,mobile_string);
        NSArray *locarray = [location_string componentsSeparatedByString:@","];
    
        lt = [[locarray objectAtIndex:0] doubleValue];
        ln = [[locarray objectAtIndex:1] doubleValue];
         GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(lt,ln);
        marker.title = name_string;
        marker.userData = mobile_string;
        if ([teacher_string isEqualToString:@"true"]) {
           marker.snippet = [NSString stringWithFormat:@"Teacher : %@",skills_string];
        
        }
        else
        {
            marker.snippet = [NSString stringWithFormat:@"Student"];
            marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        }
        [mapView_ animateToLocation:marker.position];
      //  [mapView_ setSelectedMarker:marker];
        [marker setMap:mapView_];
    }
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)getlocation
{
    

}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
   // NSString * sef = marker.snippet;
    
    
    NSArray *recipents = @[marker.userData];
    NSString *message = [NSString stringWithFormat:@"Hey! I would like to learn from you"];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    [self presentViewController:messageController animated:YES completion:nil];
   
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
        else if (result == MessageComposeResultSent)
        {
            NSLog(@"Message sent");
                }
            else
                NSLog(@"Message failed");
    
                }


-(void)locationManager:(CLLocationManager *)manager
didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        NSLog(@"%@",location);
        // Update your marker on your map using location.coordinate.latitude
        //and location.coordinate.longitude);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
