//
//  FrequentlyQHeader.h
//  YDElectricity
//
//  Created by 元典 on 2019/2/16.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^openBlock)(NSIndexPath *indexPath);
typedef void(^closeBlock)(NSIndexPath *indexPath);

@interface FrequentlyQHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *indicatorImageView;

@property (assign, nonatomic) BOOL isOpen;
@property (assign, nonatomic) NSIndexPath *indexPath;


@property (copy, nonatomic) openBlock openblock;
@property (copy, nonatomic) closeBlock closeblock;

@end

NS_ASSUME_NONNULL_END
