//
//  AddPostTableViewController.m
//  carpool
//
//  Created by zhang zidong on 3/16/2014.
//  Copyright (c) 2014 Zidong Zhang. All rights reserved.
//

#import "AddPostTableViewController.h"

#import "AFHTTPSessionManager.h"
#import "UIAlertView+AFNetworking.h"
#import <Foundation/Foundation.h>

#import "Post.h"
@interface AddPostTableViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *DoneButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (weak, nonatomic) IBOutlet UITextField *DestTextField;
@property (weak, nonatomic) IBOutlet UITextField *OriginTextField;
@property (weak, nonatomic) IBOutlet UITextField *PriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *TelTextField;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *OffOrLFSegCtrl; // index 0 is Offer, 1 is Looking for


@end

@implementation AddPostTableViewController
- (IBAction)ClickButtonDone:(id)sender {
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMddHHmm"];
    NSString *theDate = [dateFormat stringFromDate:self.DatePicker.date];
    //Ensure the date is valid.
    if([currDate compare:self.DatePicker.date] == NSOrderedDescending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Date invalid." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = @0;
    NSString *priceText  =self.PriceTextField.text;
    if([priceText length]){
        myNumber = [f numberFromString:self.PriceTextField.text];
    }
    //Ensure the price is valid.
    if(!myNumber || [priceText length] >= 10){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Price invalid." delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    AFHTTPSessionManager * Manager = [AFHTTPSessionManager manager];
    //NSURL *url = [NSURL URLWithString:@"http://carpool-waterloo.herokuapp.com/"];
   NSURL *url = [NSURL URLWithString:@"http://carpooltest1234.herokuapp.com/"];
    //NSURL *url = [NSURL URLWithString:@"http://pacific-reef-2211.herokuapp.com/"];
    //NSURL *url = [NSURL URLWithString:@"http://localhost:8080/Carpool_0.8/"];
    
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    cfg.HTTPAdditionalHeaders = @{@"Content-Type" : @"application/json"};
    
    
    Manager = [Manager initWithBaseURL:url sessionConfiguration:cfg];
    Manager.responseSerializer = [AFJSONResponseSerializer serializer];
    Manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[Manager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"admin" password:@"nimda"];
    Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    NSInteger index =  self.OffOrLFSegCtrl.selectedSegmentIndex;
    BOOL offerOrLF;
    if(index == 0){
        offerOrLF = YES;
    } else {
        offerOrLF = NO;
    }
    
    NSURLSessionDataTask *task = [Manager POST:@"posts" parameters:
                                  [NSDictionary dictionaryWithObjectsAndKeys:
                                   theDate, @"date_time",
                                   myNumber, @"price",
                                   self.TelTextField.text, @"tel",
                                   self.OriginTextField.text, @"origin",
                                   self.DestTextField.text, @"destination",
                                   self.NameTextField.text, @"name",
                                   [NSNumber numberWithBool:offerOrLF], @"off_LF",
                                   nil] success:^(NSURLSessionDataTask * __unused task, id JSON) {
                                      
                                  } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                      NSLog(@"%@",error);
                                  }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [task resume];
    
    /*for(int i=0;i<9;i++){
        NSURLSessionDataTask *task2 = [Manager POST:@"posts" parameters:
                                   [NSDictionary dictionaryWithObjectsAndKeys:
                                    theDate, @"date_time",
                                    myNumber, @"price",
                                    self.TelTextField.text, @"tel",
                                    self.OriginTextField.text, @"origin",
                                    self.DestTextField.text, @"destination",
                                    self.NameTextField.text, @"name",
                                    [NSNumber numberWithBool:offerOrLF], @"off_LF",
                                    nil] success:^(NSURLSessionDataTask * __unused task, id JSON) {
                                       
                                   } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                                       NSLog(@"%@",error);
                                   }];
        [task2 resume];
    }*/
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}

- (IBAction)test:(id)sender {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(!(textField != self.OriginTextField && textField != self.DestTextField && textField != self.TelTextField)) {
        
        NSUInteger length_origin = 0;
        NSUInteger length_dest = 0;
        NSUInteger length_tel = 0;
        
        if(textField == self.OriginTextField){
            length_origin = self.OriginTextField.text.length - range.length + string.length;
            length_dest = self.DestTextField.text.length ;
            length_tel = self.TelTextField.text.length ;

        }
        
        if(textField == self.DestTextField){
            length_origin = self.OriginTextField.text.length;
            length_dest = self.DestTextField.text.length - range.length + string.length;
            length_tel = self.TelTextField.text.length ;
            
        }
        
        if(textField == self.TelTextField){
            length_origin = self.OriginTextField.text.length;
            length_dest = self.DestTextField.text.length ;
            length_tel = self.TelTextField.text.length - range.length + string.length;
            
        }
        
        
        if (length_origin >0 && length_dest >0 && length_tel>0) {
            self.DoneButton.enabled = YES;
        } else {
            self.DoneButton.enabled = NO;
        }

    }
    
    return YES;
}


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.DoneButton.enabled = NO;
    
    self.DestTextField.delegate = self;
    self.OriginTextField.delegate = self;
    self.PriceTextField.delegate = self;
    self.TelTextField.delegate = self;
    self.NameTextField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    //self.DatePicker.backgroundColor = [[UIColor alloc]initWithRed:65.0/255.0 green:224.0/255.0 blue:208.0/255.0 alpha:1.0];
    UIFont *font = [UIFont boldSystemFontOfSize:13.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [self.OffOrLFSegCtrl setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)dismissKeyboard {
    [self.TelTextField resignFirstResponder];
    [self.OriginTextField resignFirstResponder];
    [self.DestTextField resignFirstResponder];
    [self.PriceTextField resignFirstResponder];
    [self.NameTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.NameTextField) {
        [self.TelTextField becomeFirstResponder];
    }
    
    if(textField == self.TelTextField) {
        [self.OriginTextField becomeFirstResponder];
    }
    
    if(textField == self.OriginTextField) {
        [self.DestTextField becomeFirstResponder];
    }
    
    if(textField == self.DestTextField) {
        [self.PriceTextField becomeFirstResponder];
    }
    
    if(textField == self.PriceTextField) {
        [textField resignFirstResponder];
    }
        
    
    return YES;
}

@end
