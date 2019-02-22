//
//  TViewController.m
//  YDElectricity
//
//  Created by 元典 on 2019/2/22.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "TViewController.h"

@interface TViewController ()
@property (weak, nonatomic) IBOutlet UIView *view0;

@end

@implementation TViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view0.frame;
    frame.size = CGSizeMake(kScreenW, 200);
    self.view0.frame = frame;
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
