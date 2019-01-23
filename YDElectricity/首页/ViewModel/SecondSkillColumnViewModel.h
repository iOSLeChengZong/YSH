//
//  SecondSkillColumnViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/17.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN
//请求更多还是请求刷新
typedef NS_ENUM(NSInteger,SecondKillRequestMode) {
    SecondKillRequestModeRefresh,
    SecondKillRequestModeMore,
};


@interface SecondSkillColumnViewModel : NSObject
//1.根据UI
/** 商品数量 */
-(NSInteger)itemNumber;
/** 商品主图URL */
-(NSURL *)goodImageURLAtIndexPath:(NSIndexPath *)indexPath;
/** 商品平台图片 */
-(NSString *)goodPlatformImageAtIndexPath:(NSIndexPath *)indexPath;
/** 商品名称 */
-(NSString *)goodNameAtIndexPath:(NSIndexPath *)indexPath;
/** 商品原价 */
-(NSString *)goodOriginalPriceAtIndexPath:(NSIndexPath *)indexPath;
/** 商品现售价 */
-(NSString *)goodCurrentPriceAtIndexPath:(NSIndexPath *)indexPath;
/** 商品总数量 */
-(NSString *)goodTotalNumAtIndexPath:(NSIndexPath *)indexPath;
/** 商品已抢购 */
-(NSString *)goodCurrentNumAtIndexPath:(NSIndexPath *)indexPath;


//2.根据接口
@property(nonatomic,assign)NSInteger totalPage;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong)NSMutableArray<SecondSkillColumnPageList *> *pageList;
//限时抢购
-(void)getSecondSkillListModelDataRequestMode:(SecondKillRequestMode)requestMode timeInterverl:(NSString *)time pageSize:(NSInteger)size completionHandler:(void(^)(NSError *error))completionHandler;

@end

NS_ASSUME_NONNULL_END
