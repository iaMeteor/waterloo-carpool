//
//  DetailViewController.m
//  carpool
//
//  Created by zhang zidong on 3/16/2014.
//  Copyright (c) 2014 Zidong Zhang. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
//@property (weak, nonatomic) IBOutlet UITextView *OriginToDestText;
@property (weak, nonatomic) IBOutlet UILabel *OriginToDestLabel;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *TelLabel;
@property (weak, nonatomic) IBOutlet UILabel *PreSentenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
@property (weak, nonatomic) IBOutlet UITextView *TelTextView;


@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *name = @"Someone";
    if([_post.name length]) {
        name = _post.name;
    }
    NSString *str = @"";
    if(_post.offering) {
        str = @" is offering:";
    } else {
        str = @" is looking for";
    }
    
    
    self.PreSentenceLabel.text = [name stringByAppendingString:str];
    
    self.OriginToDestLabel.text = [[_post.origin stringByAppendingString:@" → "] stringByAppendingString:_post.destination];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
    self.DateLabel.text = [@"Departure: " stringByAppendingString:[dateFormat stringFromDate:_post.date]];
    
    if([_post.price isEqualToNumber:@0]){
        self.PriceLabel.text = @"Price Not Avaliable";
    } else {
        self.PriceLabel.text = [@"$" stringByAppendingString:[_post.price stringValue]];
    }
    
    self.TelTextView.text = [@"Tel: " stringByAppendingString: _post.tel];
    
    if(_post.offering){
        self.view.backgroundColor = [[UIColor alloc]initWithRed:65.0/255.0 green:224.0/255.0 blue:208.0/255.0 alpha:1.0];
    }else{
        self.view.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:144.0/255.0 blue:163.0/255.0 alpha:1.0];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
