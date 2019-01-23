//
//  MyOrderChildViewController.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/11.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserOrderViewModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface MyOrderChildViewController : UIViewController

@property (nonatomic,strong)UserOrderViewModel *orderViewModel;
@property (nonatomic,assign)OrderType orderMode;

@property(nonatomic,strong)NSString *userPid;


-(void)request;

@end

NS_ASSUME_NONNULL_END
