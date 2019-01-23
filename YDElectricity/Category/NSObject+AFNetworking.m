//
//  NSObject+AFNetworking.m
//  YDElectricity
//
//  Created by 元典 on 2018/11/26.
//  Copyright © 2018年 yuandian. All rights reserved.
//

//该类对AFNetworking进行封装

@implementation UploadParam



@end

#import "NSObject+AFNetworking.h"

@implementation NSObject (AFNetworking)
+(id)GET:(NSString *)path parameters:(id)parmeters progress:(void (^)(NSProgress * _Nonnull))downloadProgress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL1]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    return [manager GET:path parameters:parmeters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil,error);
        NSLog(@"error %@",error);
    }];
    
}
    
+(id)POST:(NSString *)path parameters:(id)paremeters progress:(void (^)(NSProgress * _Nonnull))downloadProgress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL1]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    manager.requestSerializer.timeoutInterval = 30;
    return [manager POST:path parameters:paremeters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completionHandler(nil,error);
    }];
    
}


+(id)GETAllPath:(NSString *)path parameters:(id)parmeters progress:(void (^)(NSProgress * _Nonnull))downloadProgress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLTaoBao]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    return [manager GET:path parameters:parmeters progress:downloadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completionHandler(nil,error);
        NSLog(@"error %@",error);
    }];
    
}

//上传用户图片
+(void)POSTUploadUserHeaderImage:(NSDictionary *)dic progress:(void (^)(NSProgress * _Nonnull))downloadProgress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLTaoBao]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json"]];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    //    @"http://192.168.101.31:8090/app/personal/updateUserHeadImg?id=%@"
    
    NSString *fullPath = [NSString stringWithFormat:@"%@",dic[@"image"]];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.101.31:8090/app/personal/updateUserHeadImg?id=%@&file=%@",[[NSUserDefaults standardUserDefaults] stringForKey:kUserID],fullPath]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    NSURL *filePath = [NSURL fileURLWithPath:fullPath];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            !completionHandler ?: completionHandler(response,error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
            !completionHandler ?: completionHandler(response,error);
        }
    }];
    [uploadTask resume];
    
    
}


//上传图片
-(void)uploadImageWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(NSArray<UploadParam *> *)uploadParams progress:(void (^)(NSProgress * _Nonnull))progress completionHandler:(void (^)(id _Nonnull, NSError * _Nonnull))completionHandler{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL1]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json",@"image/jpeg",@"image/png",@"application/octet-stream",@"multipart/form-data"]];
    //设置请求超时
    manager.requestSerializer.timeoutInterval = 30;
    
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UploadParam *uploadParam in uploadParams) {
            NSLog(@"imageName:%@",uploadParam.filename);
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---->%lld",uploadProgress.totalUnitCount);
        !progress ?: progress(uploadProgress);
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        !completionHandler ?: completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !completionHandler ?: completionHandler(nil,error);
    }];
}

#pragma mark - 下载数据
- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)())progress success:(void (^)())success failure:(void (^)(NSError *))failure {
   
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress();
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    [downLoadTask resume];
}

/*
 
 AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 //网址
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
 
 [manager POST:@"http://112.74.67.161:8080/foodOrder/service/file/upload.do" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
 //01.21 测试
 NSString * imgpath = [NSString stringWithFormat:@"%@",dic[@"image"]];
 
 UIImage *image = [UIImage imageWithContentsOfFile:imgpath];
 NSData *data = UIImageJPEGRepresentation(image,0.7);
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 formatter.dateFormat = @"yyyyMMddHHmmss";
 NSString *str = [formatter stringFromDate:[NSDate date]];
 NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
 
 [formData appendPartWithFileData:data name:@"Filedata" fileName:fileName mimeType:@"image/jpg"];
 
 } success:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 //成功 后处理。
 NSLog(@"Success: %@", responseObject);
 NSString * str = [responseObject objectForKey:@"fileId"];
 if (str != nil) {
 //            [self.delegate uploadImgFinish:str];
 }
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 //失败
 NSLog(@"Error: %@", error);
 }];
 
 
 */

@end
