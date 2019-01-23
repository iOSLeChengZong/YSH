//
//  IdearResponseViewModel.h
//  YDElectricity
//
//  Created by 元典 on 2019/1/19.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YDNetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface IdearResponseViewModel : NSObject



@property(nonatomic,strong)VerifyRegisterModel *model;
//根据接口
-(void)postUserIdearReponseWithIdearType:(NSString *)iType idearContent:(NSString *)icontent
                         contactMethod:(NSString *)cmethod idearImages:(NSArray<UploadParam *> *)iImages
                              progress:(void(^)(NSProgress * progress))upLoadProgress
                     CompletionHandler:(void(^)(NSError *error))completionHandler;



@end

NS_ASSUME_NONNULL_END
