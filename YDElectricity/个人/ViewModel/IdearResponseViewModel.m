//
//  IdearResponseViewModel.m
//  YDElectricity
//
//  Created by 元典 on 2019/1/19.
//  Copyright © 2019 yuandian. All rights reserved.
//

#import "IdearResponseViewModel.h"

@implementation IdearResponseViewModel

-(void)postUserIdearReponseWithIdearType:(NSString *)iType idearContent:(NSString *)icontent contactMethod:(NSString *)cmethod idearImages:(NSArray<UploadParam *> *)iImages progress:(void (^)(NSProgress * _Nonnull))upLoadProgress CompletionHandler:(void (^)(NSError * _Nonnull))completionHandler{
    [YDNetManager postUserIdearReponseWithIdearType:iType idearContent:icontent contactMethod:cmethod idearImages:iImages progress:^(NSProgress * _Nonnull progress) {
        !upLoadProgress ?: upLoadProgress(progress);
    } CompletionHandler:^(VerifyRegisterModel * _Nonnull model, NSError * _Nonnull error) {
        if(!error){
            self.model = model;
            !completionHandler ?: completionHandler(error);
        }
    }];
}
@end
