//
//  InviteDetailCell.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/14.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InviteDetailCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *addTime;
@property (weak, nonatomic) IBOutlet UILabel *teamPeopleNum;
@property (weak, nonatomic) IBOutlet UILabel *contributeNum;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView;

@end

NS_ASSUME_NONNULL_END
