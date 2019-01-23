//
//  rightCollectionViewCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "noHeadRightModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface rightCollectionViewCell : UICollectionViewCell
@property(strong,nonatomic)noHeadRightModel *curNoHeadRightModel;

+(CGSize)ccellSize;
@end

NS_ASSUME_NONNULL_END
