//
//  MyOrderCollectionViewCell.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/11.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *afterDiscountLabel;
@property (weak, nonatomic) IBOutlet UILabel *estimatePriceLabel;


@end

NS_ASSUME_NONNULL_END
