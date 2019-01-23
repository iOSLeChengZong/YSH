//
//  IdeaResponseCell.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/12.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface IdeaResponseCell : UICollectionViewCell
@property(nonatomic, strong) UIButton *imageViewBtn;
@property (strong, nonatomic) UIImageView *imageView;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic,strong)KKButton *cancleBtn1;

@end

NS_ASSUME_NONNULL_END
