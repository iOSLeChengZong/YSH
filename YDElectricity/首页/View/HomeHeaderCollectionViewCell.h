//
//  HomeHeaderCollectionViewCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "HomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN
//在头部跳转商品列表还是秒杀专栏
typedef NS_ENUM(NSInteger,HomeHeaderPushModel) {
    HomeHeaderPushModelGoodList,
    HomeHeaderPushModelSeconSkill,
    HomeHeaderPushModelTaoBaoKeDetail,
};

@interface HomeHeaderCollectionViewCell : UICollectionViewCell<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//秒杀商品图片
@property (weak, nonatomic) IBOutlet UIView *imageViewParentV;

@property (strong,nonatomic) HomeViewModel *homeVM;
@property (strong,nonatomic) NSArray<NSString *> *imageURLs;


-(void)addClickHandler:(void(^)(NSString *goodID,NSString *title,HomeHeaderPushModel pushModel))hander;
@property(nonatomic,copy) void(^clickHandler)(NSString *goodID,NSString *title,HomeHeaderPushModel pushModel);



@end

NS_ASSUME_NONNULL_END
