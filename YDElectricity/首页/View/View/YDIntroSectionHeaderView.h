//
//  YDIntroSectionHeaderView.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/28.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YDIntroSectionHeaderView;

@protocol YDIntroSectionHeaderViewDelegate <NSObject>

/** 头部右侧按钮被点击后触发 */
- (void)introSectionHeaderView:(YDIntroSectionHeaderView *)headerView clickBtnAtIndexPath:(NSIndexPath *)indexPath;
@end

typedef NS_ENUM(NSUInteger, IntroBtnMode) {
    IntroBtnModeChange,
    IntroBtnModeMore,
};
@interface YDIntroSectionHeaderView : UICollectionReusableView
@property (nonatomic) UILabel *titleLb;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) IntroBtnMode btnMode;
@property (nonatomic) id<YDIntroSectionHeaderViewDelegate> delegate;
/** 换一换功能 */
@property (nonatomic) UIControl *changeControl;
/** 更多功能 */
@property (nonatomic) UIControl *moreControl;
@end

NS_ASSUME_NONNULL_END
