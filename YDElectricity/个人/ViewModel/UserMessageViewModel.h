//
//  UserMessageViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/10.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

/*
 
 #pragma mark -- UICollectionViewDelegate
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
 }
 
 
 #pragma mark -- UICollectionViewDataSource
 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 return 10;
 }
 
 // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
 - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 SystemMessage *cell = [self.systemMessageCollectionV dequeueReusableCellWithReuseIdentifier:kSystemMessage forIndexPath:indexPath];
 
 return cell;
 }
 
 
 
 - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
 return 1;
 }
 
 */

//请求更多还是请求刷新
typedef NS_ENUM(NSInteger,RequestMode) {
    RequestModeRefresh,
    RequestModeMore,
};

NS_ASSUME_NONNULL_BEGIN

@interface UserMessageViewModel : NSObject
//根据UI
/** 消息数量 */
@property(nonatomic,assign)NSInteger itemCount;
/** 消息标题 */
-(NSString *)itemTitleAtIndextPath:(NSIndexPath *)indexPath;
/** 消息时间 */
-(NSString *)itemTimeAtIndexPath:(NSIndexPath *)indexPath;
/** 消息 */
-(NSString *)itemMessageAtIndexPath:(NSIndexPath *)indexPath;




//根据接口
/**商品总页数*/
@property(nonatomic,assign)NSInteger totalPage;
/** 当前请求页数 */
@property(nonatomic,assign)NSInteger pageNum;
/** 总消息条数 */
@property(nonatomic,strong)NSMutableArray<UserSystemMessage *> *messages;
-(void)getSystemUserMessageRequestMode:(RequestMode)mode pageSize:(NSInteger)size userID:(NSString *)userID CompletionHandler:(void(^)(NSError *error))completionHandler;


@end

NS_ASSUME_NONNULL_END
