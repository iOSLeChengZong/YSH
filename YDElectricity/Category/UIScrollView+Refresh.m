//
//  UISCrollView+Refresh.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/27.
//  Copyright © 2018 yuandian. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
/** 添加mj_header */
-(void)addHeaderRefreshingBlock:(void (^)(void))block{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    
    // Set title
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;

    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:11];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];

    // Set textColor
    header.stateLabel.textColor = kFONTSlectRGB;
    header.lastUpdatedTimeLabel.textColor = kFONTSlectRGB;//[UIColor blueColor];
    self.mj_header = header;//[MJRefreshNormalHeader headerWithRefreshingBlock:block];
}

/** 开始头部刷新 */
-(void)beginHeaderRefresh{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.mj_header beginRefreshing];
    }];
}

/** 结束头部刷新 */
-(void)endHeaderRefresh{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.mj_header endRefreshing];
        
    }];
}

-(void)addFooterBackRefresh:(void (^)(void))block{
//    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    footer.stateLabel.font = [UIFont systemFontOfSize:11];
    footer.stateLabel.textColor = kFONTSlectRGB;
    self.mj_footer = footer;
    
}

/** 开始脚部刷新 */
-(void)beginFooterRefresh{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.mj_footer beginRefreshing];
    }];
}

/** 结束脚部刷新 */
-(void)endFooterRefresh{
    [self.mj_footer endRefreshing];
}

/** 结束脚部刷新并设置没有更多数据 */
-(void)endFooterRefreshWithNoMoreData{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.mj_footer endRefreshingWithNoMoreData];
    }];
}

@end


