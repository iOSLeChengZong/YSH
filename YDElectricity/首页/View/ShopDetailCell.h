//
//  ShopDetailCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//

///** 商店品牌图名称 或url */
//@property(nonatomic,strong)NSString *shopImageName;
///** 商店名称 */
//@property(nonatomic,strong)NSString *shopName;
///** 体验来源图片或名字 */
//@property(nonatomic,strong)NSString *experienceName;
///** 宝贝描述评分 */
//@property(nonatomic,strong)NSString *babyDetailScore;
///** 卖家服务评分 */
//@property(nonatomic,strong)NSString *sellerScore;
///** 物流服务评分 */
//@property(nonatomic,strong)NSString *logisticsScore;

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImageName;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *experienceName;
@property (weak, nonatomic) IBOutlet UILabel *babyDetailScore;
@property (weak, nonatomic) IBOutlet UILabel *sellerScore;
@property (weak, nonatomic) IBOutlet UILabel *logisticsScore;


@end

NS_ASSUME_NONNULL_END
