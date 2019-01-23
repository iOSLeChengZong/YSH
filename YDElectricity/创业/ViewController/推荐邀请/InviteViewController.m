//
//  InviteViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController ()

@end

@implementation InviteViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
}

- (IBAction)inviteVCBackBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBGColor;
    // Do any additional setup after loading the view.
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
