//
//  DetailInfoCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/26.
//  Copyright © 2018 yuandian. All rights reserved.
//


// /** 头部商品图URLS */
//@property(nonatomic,strong)NSArray *imageURLS;
/** 商品来源图标 */
//@property(nonatomic,strong)NSString *imageName;
///** 商品标题 */
//@property(nonatomic,strong)NSString *title;
///** 券后价 */
//@property(nonatomic,strong)NSString *discountPrice;
///** 原价 */
//@property(nonatomic,strong)NSString *originalPrice;
///** 月销 */
//@property(nonatomic,strong)NSString *monthSaleNum;
///** 优惠券 */
//@property(nonatomic,strong)NSString *couponPrice;
///** 使用期限 */
//@property(nonatomic,strong)NSString *serviceLife;


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailInfoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageName;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *discountPrice;
@property (weak, nonatomic) IBOutlet UILabel *originalPrice;
@property (weak, nonatomic) IBOutlet UILabel *monthSaleNum;
@property (weak, nonatomic) IBOutlet UILabel *couponPrice;
@property (weak, nonatomic) IBOutlet UILabel *serviceLife;

-(void)addClickHandler:(void(^)(void))hander;
@property(nonatomic,copy) void(^clickHandler)(void);

@end

NS_ASSUME_NONNULL_END
