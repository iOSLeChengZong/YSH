//
//  HomeProductCellOne.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/4.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeProductCellOne : UICollectionViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
//商品来源
@property (weak, nonatomic) IBOutlet UILabel *productFromLabel;

//商品标题1
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel0;


//商品标题2
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel1;


//商品标题3
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel2;


//来源原价
@property (weak, nonatomic) IBOutlet UILabel *productFromMoneyLabel;


//销量
@property (weak, nonatomic) IBOutlet UILabel *saleNum;


//优惠券
@property (weak, nonatomic) IBOutlet UILabel *productFromeSaleMoneyLabel;

//券后价
@property (weak, nonatomic) IBOutlet UILabel *productAfterSaleMoneyLabel;

//赚 奖励
@property (weak, nonatomic) IBOutlet UILabel *profitMoney;
@end

NS_ASSUME_NONNULL_END
