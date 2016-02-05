//
//  SignupViewController.m
//  Meetutu
//
//  Created by sanjeev s on 01/02/16.
//  Copyright © 2016 sanjeev s. All rights reserved.
//

#import "SignupViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "meetutuutility.h"
#import "LoginViewController.h"
#define EMAIL_REGEX @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
int count = 0;
NSString *email_string,*languages,*mobile,*password,*name,*teacher,*longitudeLabel,*latitudeLabel;

@interface SignupViewController ()<CLLocationManagerDelegate>
{
    UILabel *signup,*learner;
    UITextField *username,*email,*Password,*conf_Password,*Mob_num,*autocomplete;
    UIButton *yesorno,*signupBtn,*back;
   
    CLLocationManager *locationManager;
}

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    teacher = @"false";
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //ViewController *vc = [[ViewController alloc]init];
    locationManager = [[CLLocationManager alloc] init];
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
  

    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    signup = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-30, 40, 60, 30)];
    [signup setText:@"SignUP"];
    [signup setTextColor:[UIColor whiteColor]];
    signup.font = [UIFont fontWithName:@"Helveticaneue-Medium" size:16];
    [self.view addSubview:signup];
    
    
    
    username = [[UITextField alloc]initWithFrame:CGRectMake(20, signup.frame.origin.y+50, self.view.frame.size.width-40, 30)];
    [username setBackgroundColor:[UIColor whiteColor]];
    //username.font = [UIFont fontWithName:@"Helveticaneue-Medium" size:12];
    username.textColor = [UIColor blackColor];
    username.tag = 50;
    username.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:username];
    if ([username respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }
    
    
    email = [[UITextField alloc]initWithFrame:CGRectMake(20, username.frame.origin.y+50, username.frame.size.width, 30)];
    [email setBackgroundColor:[UIColor whiteColor]];
    email.keyboardType = UIKeyboardTypeEmailAddress;
    email.autocapitalizationType = UITextAutocapitalizationTypeNone;
    email.textColor = [UIColor blackColor];
    email.borderStyle = UITextBorderStyleRoundedRect;
    email.tag = 51;
    [self.view addSubview:email];
    if ([email respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }
    
    
    Password = [[UITextField alloc]initWithFrame:CGRectMake(20, email.frame.origin.y+50, username.frame.size.width, 30)];
    [Password setBackgroundColor:[UIColor whiteColor]];
    Password.secureTextEntry = YES;
    Password.tag = 52;
    Password.borderStyle = UITextBorderStyleRoundedRect;
    Password.textColor = [UIColor blackColor];
    [self.view addSubview:Password];
    if ([Password respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        Password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }
    
    conf_Password = [[UITextField alloc]initWithFrame:CGRectMake(20, Password.frame.origin.y+50, username.frame.size.width, 30)];
    [conf_Password setBackgroundColor:[UIColor whiteColor]];
    conf_Password.secureTextEntry = YES;
    conf_Password.textColor = [UIColor blackColor];
    conf_Password.borderStyle = UITextBorderStyleRoundedRect;
    conf_Password.tag = 56;
    [self.view addSubview:conf_Password];
    if ([conf_Password respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        conf_Password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }

    Mob_num = [[UITextField alloc]initWithFrame:CGRectMake(20, conf_Password.frame.origin.y+50, username.frame.size.width, 30)];
    [Mob_num setBackgroundColor:[UIColor whiteColor]];
    Mob_num.keyboardType = UIKeyboardTypeNumberPad;
    Mob_num.borderStyle = UITextBorderStyleRoundedRect;
    Mob_num.tag = 53;
    Mob_num.textColor= [UIColor blackColor];
    [self.view addSubview:Mob_num];
    if ([Mob_num respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        Mob_num.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone Number" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }

    learner = [[UILabel alloc]initWithFrame:CGRectMake(20, Mob_num.frame.origin.y+50, 200, 30)];
    [learner setText:@"Are you a Teacher ?"];
    learner.font = [UIFont fontWithName:@"Helveticaneue-Light" size:18];
    learner.textColor = [UIColor whiteColor];
    [self.view addSubview:learner];
    
    yesorno = [[UIButton alloc]initWithFrame:CGRectMake(learner.frame.origin.x+250, Mob_num.frame.origin.y+40, 50, 50)];
    [yesorno setTitle:@"NO" forState:UIControlStateNormal];
    [yesorno setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [yesorno addTarget:self action:@selector(yesclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yesorno];
    
    autocomplete = [[UITextField alloc]initWithFrame:CGRectMake(20, learner.frame.origin.y+50, username.frame.size.width, 30)];
    [autocomplete setBackgroundColor:[UIColor whiteColor]];
    autocomplete.borderStyle = UITextBorderStyleRoundedRect;
    autocomplete.tag = 54;
    [self.view addSubview:autocomplete];
    if ([autocomplete respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        autocomplete.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Technical Skills" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }

    signupBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-50, autocomplete.frame.origin.y+50, 100, 40)];
    [signupBtn setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signupBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [signupBtn addTarget:self action:@selector(apicall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signupBtn];
    
    
    back = [[UIButton alloc]initWithFrame:CGRectMake(25, 30, 60, 30)];
    [back setTitle:@"BACK" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    
    

    // Do any additional setup after loading the view.
}

-(void)dismissKeyboard {
    [self.view resignFirstResponder];
    [self.view endEditing:YES];
    
}
-(void)apicall
{
    NSString *p_string,*cp_sting;
    for(UIView *subView in self.view.subviews)
    {
        if(subView.tag == 51)
        {
            UITextField *mailField = (UITextField*)subView;
            
                
            if([meetutuutility checkForEmail:[mailField text]]==FALSE)
            {
                UIAlertController *
                loginError = [UIAlertController alertControllerWithTitle:@"Meetutu" message:@"Please enter valid Email ID." preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                          
                                                                          
                                                                      }];
                
                
                [loginError addAction:firstAction];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self presentViewController:loginError animated:YES completion:nil];
                    
                });
            }
            else
            {
            email_string = [mailField text];
            NSLog(@"EMAIL-->%@",email_string);
            }
        }
        if(subView.tag == 52)
        {
            UITextField *pwdField = (UITextField*)subView;
            p_string = [pwdField text];
            NSLog(@"Password--->%@",p_string);
        }
        
        if (subView.tag == 50) {
            UITextField *namefield = (UITextField*)subView;
            name = [namefield text];
            NSLog(@"NAME-->%@",name);
        }
        if (subView.tag == 53) {
            UITextField *mobfield = (UITextField*)subView;
            mobile = [mobfield text];
            NSLog(@"Mobile-->%@",mobile);
        }
        if (subView.tag == 54) {
            UITextField *languagefielf = (UITextField*)subView;
            languages = [languagefielf text];
            NSLog(@"LANG-->%@",languages);
        }
        if (subView.tag == 56) {
            UITextField *confpass = (UITextField *)subView;
            cp_sting = [confpass text];
            NSLog(@"confpass ----> %@",cp_sting);
        }
        if ([p_string isEqualToString:cp_sting]) {
            password = p_string;
        }
    }

    
    
    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tchinmai.xyz/guvi/signup.php?teacher=%@&email=%@&languages=%@&mobile=%@&password=%@&name=%@&location=%f,%f",teacher,email_string,languages,mobile,password,name,latitude,longitude]]];
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
    NSString *accessStr;
    if (json!=nil) {
       accessStr  = [json objectForKey:@"result"];
    }
    if ([accessStr isEqualToString:@"success"]) {
        [[NSUserDefaults standardUserDefaults] setObject:email_string forKey:@"email_id"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedin"];
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self presentViewController:vc animated:NO completion:nil];
    }
}

-(void)backaction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}



-(void)yesclicked
{
    count = count+1;
    if (count%2==0) {
        [yesorno setTitle:@"NO" forState:UIControlStateNormal];
        teacher =@"false";
        
    }
    else
    {
       [yesorno setTitle:@"YES" forState:UIControlStateNormal];
        teacher = @"true";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
