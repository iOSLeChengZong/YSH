//
//  NSObject+AFNetworking.h
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UploadParam;
@interface UploadParam : NSObject
/**
 *  图片的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  服务器对应的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;

@end


@interface NSObject (AFNetworking)

//GET请求
+ (id)GET:(NSString *)path parameters:(id)parmeters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;

//GET请求 allPath
+ (id)GETAllPath:(NSString *)path parameters:(id)parmeters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;

//POST请求
+ (id)POST:(NSString *)path parameters:(id)paremeters progress:(void(^)(NSProgress *downloadProgress))downloadProgress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler;



/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParams 上传图片的信息
 *  @param completionHandler 回调
 */
- (void)uploadImageWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(NSArray <UploadParam *> *)uploadParams progress:(void(^)(NSProgress * UploadProgress))progress completionHandler:(void(^)(id responseObj,NSError *error))completionHandler; //success:(void (^)(void))success failure:(void (^)(NSError *error))failure;


/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)(void))progress success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
