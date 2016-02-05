//
//  ForgotPasswordViewController.m
//  Meetutu
//
//  Created by sanjeev s on 01/02/16.
//  Copyright © 2016 sanjeev s. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import <MessageUI/MessageUI.h>

@interface ForgotPasswordViewController ()<MFMessageComposeViewControllerDelegate>
{
    UILabel *login;
    UITextField *username;
    UIButton *Login,*back;
}
@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    login = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, (self.view.frame.size.height/2)-120, 200, 30)];
    login.text = @"Fogot Password";
    login.textColor = [UIColor whiteColor];
    login.font = [UIFont fontWithName:@"Helveticaneue-Bold" size:24];
    [self.view addSubview:login];
    
    username = [[UITextField alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height/2)-60, self.view.frame.size.width-40, 30)];
    //username. = @"Username";
    [username setBackgroundColor:[UIColor whiteColor]];
    //username.font = [UIFont fontWithName:@"Helveticaneue-Medium" size:12];
    username.keyboardType = UIKeyboardTypeEmailAddress;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.textColor = [UIColor blackColor];
    [self.view addSubview:username];
    if ([username respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:0.4f];
        username.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName : [UIFont fontWithName:@"Helveticaneue-Medium" size:16]}];
        
    } else {
        
    }
    
    
    
    Login = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-70, username.frame.origin.y+50, (self.view.frame.size.width/2)-30, 40)];
    [Login setTitle:@"submit" forState:UIControlStateNormal];
    [Login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [Login addTarget:self action:@selector(loginclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Login];
    
    
    back =[[UIButton alloc]initWithFrame:CGRectMake(25, 30, 60, 40)];
    [back setTitle:@"BACK" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];


    // Do any additional setup after loading the view.
}
-(void)loginclicked
{
    
    // Present message view controller on screen]
    //[self presentViewController:messageController animated:YES completion:nil];
    
}
-(void)backaction
{
    [self dismissViewControllerAnimated:nil completion:nil];
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
