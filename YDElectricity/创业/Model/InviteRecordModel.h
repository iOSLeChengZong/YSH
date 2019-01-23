//
//  InviteRecordModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/21.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class InviteRecordInfo;

@interface InviteRecordModel : NSObject<YYModel>
//pageList -> recordInfo
@property (nonatomic, strong) NSArray<InviteRecordInfo *> * recordInfo;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger totalPages;
@end

@interface InviteRecordInfo : NSObject<YYModel>
//add_time -> addTime
@property (nonatomic, strong) NSString * addTime;
//grand_total_income -> grandTotalIncome
@property (nonatomic, assign) CGFloat grandTotalIncome;
//head_img_url ->headImgUrl
@property (nonatomic, strong) NSString * headImgUrl;
//nick_name->nickName
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, assign) NSInteger userCount;

@end

NS_ASSUME_NONNULL_END
