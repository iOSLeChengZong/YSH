//
//  CommodityListlViewController.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommodityListlViewController : UIViewController
@property(nonatomic,strong)NSString *goodID;
@property(nonatomic,assign)GoodListState listState;

@end

NS_ASSUME_NONNULL_END
