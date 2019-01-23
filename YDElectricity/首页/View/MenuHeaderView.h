//
//  MenuHeaderView.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/3.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"

NS_ASSUME_NONNULL_BEGIN

@class GXIndexPath;
@class MenuHeaderView;
@protocol MenuHeaderViewDelegate <NSObject>
- (NSArray <MenuModel *> *)dataSourceOfView:(MenuHeaderView *)headerView;
- (void)didSelectedIndexPath:(GXIndexPath *)indexPath imageType:(ButtonImageType)imageType forView:(MenuHeaderView *)headerView;
- (void)didChooseCompletionWithData:(NSArray *)array;
@end


@interface GXIndexPath : NSObject
@property (nonatomic, assign) NSInteger row; //行
@property (nonatomic, assign) NSInteger column; //列
- (instancetype)initWithColumn:(NSInteger)column row:(NSInteger)row;
+ (instancetype)indexPathWithColumn:(NSInteger)column row:(NSInteger)row;
@end


@interface MenuListCell : UITableViewCell
@property (nonatomic,strong) UIImageView *imgView;
@end


@interface MenuHeaderView : UIView
@property (nonatomic,weak) id <MenuHeaderViewDelegate> delegate;
//@property (nonatomic,assign) BOOL drawerCanPan;
@end

NS_ASSUME_NONNULL_END
