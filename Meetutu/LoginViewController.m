//
//  LoginViewController.m
//  Meetutu
//
//  Created by sanjeev s on 01/02/16.
//  Copyright © 2016 sanjeev s. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "ForgotPasswordViewController.h"
#import "SignupViewController.h"
NSString *email_string1,*password_string1;
@interface LoginViewController ()
{
    UILabel *login;
    UITextField *username,*password;
    UIButton *Login,*forgotPass,*signup;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    login = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-50, (self.view.frame.size.height/2)-120, 120, 30)];
    login.text = @"Login";
    login.textColor = [UIColor whiteColor];
    login.font = [UIFont fontWithName:@"Helveticaneue-Bold" size:24];
    [self.view addSubview:login];
    
    username = [[UITextField alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height/2)-60, self.view.frame.size.width-40, 30)];
    //username. = @"Username";
    [username setBackgroundColor:[UIColor whiteColor]];
    username.borderStyle = UITextBorderStyleRoundedRect;
    //username.font = [UIFont fontWithName:@"Helveticaneue-Medium" size:12];
    username.keyboardType = UIKeyboardTypeEmailAddress;
    username.tag =51;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.textColor = [UIColor blackColor];
    [self.view addSubview:username];
    if ([username respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }
    
    
    password = [[UITextField alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height/2)-20,self.view.frame.size.width-40 , 30)];
    [password setBackgroundColor:[UIColor whiteColor]];
    password.secureTextEntry = YES;
    password.textColor =[UIColor blackColor];
    password.tag = 52;
    password.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:password];
    if ([password respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
    } else {
        
    }
    
    
    Login = [[UIButton alloc]initWithFrame:CGRectMake(20, password.frame.origin.y+50, (self.view.frame.size.width/2)-30, 40)];
    [Login setTitle:@"Login" forState:UIControlStateNormal];
    [Login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Login addTarget:self action:@selector(loginclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Login];
    
    signup = [[UIButton alloc]initWithFrame:CGRectMake(Login.frame.origin.x+Login.frame.size.width+20, password.frame.origin.y+50, Login.frame.size.width, 40)];
    [signup setTitle:@"Signup" forState:UIControlStateNormal];
    [signup setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [signup addTarget:self action:@selector(signupclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signup];
    
    forgotPass = [[UIButton alloc]initWithFrame:CGRectMake(100, signup.frame.origin.y+60, 200, 40)];
    [forgotPass setTitle:@"Forgot Password" forState:UIControlStateNormal];
    [forgotPass setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgotPass addTarget:self action:@selector(forgotpass) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPass];
    
    
    

    
    // Do any additional setup after loading the view.
}

-(void)signupclicked
{
    SignupViewController *svc = [[SignupViewController alloc]init];
    [self presentViewController:svc animated:NO completion:nil];
}

-(void)loginclicked
{
//    ViewController *vc = [[ViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
    
    for(UIView *subView in self.view.subviews)
    {
        if(subView.tag == 51)
        {
            UITextField *mailField = (UITextField*)subView;
            email_string1 = [mailField text];
            NSLog(@"EMAIL-->%@",email_string1);
        }
        if(subView.tag == 52)
        {
            UITextField *pwdField = (UITextField*)subView;
            password_string1 = [pwdField text];
            NSLog(@"Password--->%@",password_string1);
        }
    }
    
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tchinmai.xyz/guvi/login.php?email=%@&password=%@",email_string1,password_string1]]];
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
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid emailid or password" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    if ([accessStr isEqualToString:@"success"]) {
         [[NSUserDefaults standardUserDefaults] setObject:email_string1 forKey:@"email_id"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedin"];
        ViewController *vc = [[ViewController alloc]init];
        [self presentViewController:vc animated:NO completion:nil];
    }




}

-(void)forgotpass
{
    ForgotPasswordViewController *fpvc = [[ForgotPasswordViewController alloc]init];
    [self presentViewController:fpvc animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
