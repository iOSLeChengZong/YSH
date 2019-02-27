//
//  AboutOurViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/25.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "AboutOurViewController.h"

@interface AboutOurViewController ()
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;

@end

@implementation AboutOurViewController



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.mapView viewcornerRadius:5 borderWith:0.01 clearColor:NO];
    [self.mapImageView viewcornerRadius:5 borderWith:0.01 clearColor:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)aboubVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
