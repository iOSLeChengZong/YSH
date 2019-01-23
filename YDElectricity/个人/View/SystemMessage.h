//
//  SystemMessage.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/2.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemMessage : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageTime;
@property (weak, nonatomic) IBOutlet UILabel *message;


@end

NS_ASSUME_NONNULL_END
