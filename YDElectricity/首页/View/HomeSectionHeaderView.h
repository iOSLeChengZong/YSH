//
//  HomeSectionHeaderView.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSectionHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *introBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;

-(void)addClickHandler:(void(^)(HomeRequestMode requestMode,HotOrRecomend hotOrRecomend))hander;
@property(nonatomic,copy) void(^clickHandler)(HomeRequestMode,HotOrRecomend);
@end

NS_ASSUME_NONNULL_END
