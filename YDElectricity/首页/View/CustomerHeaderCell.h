//
//  CustomerHeader.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomerHeaderCell : UICollectionReusableView<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
//@property (weak, nonatomic) IBOutlet UILabel *indexPage;
@property (strong, nonatomic) UILabel *indexPage;

@property (strong,nonatomic)NSArray *imageURLStringsGroup;

@end

NS_ASSUME_NONNULL_END
