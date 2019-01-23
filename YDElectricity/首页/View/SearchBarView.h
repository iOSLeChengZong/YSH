//
//  SearchBarView.h
//  YDElectricity
//
//  Created by 元典 on 2018/12/12.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//定义一个协议,谁点击就调用谁
@protocol SearchBarViewDelegate <NSObject>

@optional
- (void)searchBarSearchBtnClicked:(id)searchBarView;

@end

@interface SearchBarView : UIView
@property(nonatomic,weak)id <SearchBarViewDelegate> delegate;
@end

@interface RounderView : UIView

@end




NS_ASSUME_NONNULL_END
