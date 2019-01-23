//
//  leftTableCell.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/7.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "leftTagModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface leftTableCell : UITableViewCell
@property(strong,nonatomic)leftTagModel *curLeftTagModel;
//是否被选中
@property(assign,nonatomic)BOOL hasBeenSelected;
@end

NS_ASSUME_NONNULL_END
