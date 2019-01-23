//
//  UISCrollView+Refresh.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Refresh)

/** 添加头部刷新视图 */
-(void)addHeaderRefreshingBlock:(void(^)(void))block;
/** 开始头部刷新 */
- (void)beginHeaderRefresh;
/** 结束头部刷新 */
- (void)endHeaderRefresh;
/** 开始脚部刷新 */
- (void)beginFooterRefresh;
/** 结束脚部刷新 */
- (void)endFooterRefresh;
/** 结束脚部刷新并设置没有更多数据 */
- (void)endFooterRefreshWithNoMoreData;
/** 添加脚部刷新 */
-(void)addFooterBackRefresh:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
