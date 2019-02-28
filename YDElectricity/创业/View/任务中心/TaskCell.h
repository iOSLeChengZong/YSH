//
//  TaskCell.h
//  YDElectricity
//
//  Created by 元典 on 2019/2/15.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskCell : UICollectionViewCell
/** 任务名称 */
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;

/** 成长值奖励 */
@property (weak, nonatomic) IBOutlet UILabel *growthLabel;

/** 金币奖励 */
@property (weak, nonatomic) IBOutlet UILabel *goldLabel;

/** 任务状态 */
@property (weak, nonatomic) IBOutlet UIButton *taskStateBtn;

@end

NS_ASSUME_NONNULL_END
