//
//  zkRequestTool.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkRequestTool.h"

@implementation zkRequestTool

+(void)networkingPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    [mDict setValue:device forKey:@"device_id"];
    mDict[@"channel-ios"] = @"1";
    [mDict setValue:@1 forKey:@"channel"];
    if (![mDict.allKeys containsObject:@"NoToken"]) {
        //不传token
        mDict[@"token"] = [zkSignleTool shareTool].session_token;
    }
    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [mDict setValue:version forKey:@"version"];
    
    //       NSString * str222 = [NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]];
    
    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
//    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    [manager POST:urlStr parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求异常,稍后再试"];
        if (failure)
        {
            failure(task,error);
        }
    }];
    
}
+(void)networkingTwoPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript",@"text/x-chdr", nil];
    // manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //  [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    //    NSDictionary * dict = parameters;
    //    //获取josnzi字符串
    //    NSString * josnStr = [NSString convertToJsonData:dict];
    //    //获取MD5字符串
    //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
    //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    NSURLSessionDataTask * task = [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
            
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
  
         [SVProgressHUD showErrorWithStatus:@"请求异常,稍后再试"];
        if (failure)
        {
            failure(task,error);
        }
    }];
    
    
}





+(NSURLSessionDataTask *)networkingGET:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    //    [mDict setValue:device forKey:@"deviceId"];
    //    [mDict setValue:@1 forKey:@"channel"];
    //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //    [mDict setValue:version forKey:@"version"];
    //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
    //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    NSURLSessionDataTask * task =  [manager GET:urlStr parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        if ( [[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]] isEqualToString:@"cancelled"]) {
//            return ;
//        }
         [SVProgressHUD showErrorWithStatus:@"请求异常,稍后再试"];
        if (failure)
        {
            failure(task,error);
        }
    }];
    
    return task;
}
/**
 上传图片
 */
+(void)NetWorkingUpLoadimage:(UIImage *)image  parameters:(id)parameters progress:(uploadProgressBlock)progress success:(SuccessBlock)success  failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    [manager POST:QiNiuYunUploadURL parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:@"file"  fileName:@"195926458462659.png" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"-------\n%@",uploadProgress);

        
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(task,error);
        }
    }];
}
///**
// 多张上传图片
// */
//+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images name:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
//{
//
//    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    //    [mDict setValue:device forKey:@"deviceId"];
//    //    [mDict setValue:@1 forKey:@"channel"];
//    //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    //    [mDict setValue:version forKey:@"version"];
//    //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
//
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
//    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
//    NSDictionary * dict = parameters;
//    //    //获取josnzi字符串
//    //    NSString * josnStr = [NSString convertToJsonData:dict];
//    //    //获取MD5字符串
//    //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
//
//    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        for (UIImage * image in images)
//        {
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:[NSString stringWithFormat:@"%ld.jpg",random() / 100] mimeType:@"image/jpeg"];
//
//        }
//
//
//
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (success)
//        {
//            success(task,responseObject);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD showSuccessWithStatus:@"网络异常"];
//        if (failure)
//        {
//            failure(task,error);
//        }
//    }];
//}

///**
// 上传视频或者视频
// */
//+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images imgName:(NSString *)name fileData:(NSData *)fileData andFileName:(NSString *)fileName parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
//{
//    
//    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    //    [mDict setValue:device forKey:@"deviceId"];
//    //    [mDict setValue:@1 forKey:@"channel"];
//    //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    //    [mDict setValue:version forKey:@"version"];
//    //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
//    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
//    
//    
//    //    NSDictionary * dict = parameters;
//    //    //获取josnzi字符串
//    //    NSString * josnStr = [NSString convertToJsonData:dict];
//    //    //获取MD5字符串
//    //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
//    
//    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        for (UIImage * image in images)
//        {
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
//        }
//        if (fileData) {
//            [formData appendPartWithFileData:fileData name:fileName fileName:@"369369.mp4" mimeType:@"video/quicktime"];
//        }
//        
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (success)
//        {
//            success(task,responseObject);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD showSuccessWithStatus:@"网络异常"];
//        if (failure)
//        {
//            failure(task,error);
//        }
//    }];
//}


+ (void)getUpdateImgeModelWithCompleteModel:(void(^)(QYZJTongYongModel * model))completeBlock {
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
       NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
       [mDict setValue:device forKey:@"device_id"];
       mDict[@"channel-ios"] = @"1";
       [mDict setValue:@1 forKey:@"channel"];
       mDict[@"token"] = [zkSignleTool shareTool].session_token;
       NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
       [mDict setValue:version forKey:@"version"];
       
       //       NSString * str222 = [NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]];
       
       NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
       [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
       
       AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
       //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
       //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
       //    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
       [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
       
       [manager POST:[QYZJURLDefineTool app_uploadImgTokenURL] parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           if (completeBlock)
           {
               QYZJTongYongModel * model2 = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
               completeBlock(model2);
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
           [SVProgressHUD dismiss];
           
           if (completeBlock)
                {
                    completeBlock(nil);
                }
           
       }];
    
    
}

+ (void)getUpdateVideoModelWithCompleteModel:(void(^)(QYZJTongYongModel * model))completeBlock {
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    [mDict setValue:device forKey:@"device_id"];
    mDict[@"channel-ios"] = @"1";
    [mDict setValue:@1 forKey:@"channel"];
    mDict[@"token"] = [zkSignleTool shareTool].session_token;
    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [mDict setValue:version forKey:@"version"];
    
    //       NSString * str222 = [NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]];
    
    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    [manager POST:[QYZJURLDefineTool app_uploadVideoTokenURL] parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock)
        {
            QYZJTongYongModel * model2 = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            completeBlock(model2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        if (completeBlock)
             {
                 completeBlock(nil);
             }
        
    }];
    
}

+ (void)getUpdateAudioModelWithCompleteModel:(void(^)(QYZJTongYongModel * model))completeBlock {
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    [mDict setValue:device forKey:@"device_id"];
    mDict[@"channel-ios"] = @"1";
    [mDict setValue:@1 forKey:@"channel"];
    mDict[@"token"] = [zkSignleTool shareTool].session_token;
    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [mDict setValue:version forKey:@"version"];
    
    //       NSString * str222 = [NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]];
    
    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    [manager POST:[QYZJURLDefineTool app_uploadAudioTokenURL] parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completeBlock)
        {
            QYZJTongYongModel * model2 = [QYZJTongYongModel mj_objectWithKeyValues:responseObject[@"result"]];
            completeBlock(model2);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        if (completeBlock)
             {
                 completeBlock(nil);
             }
        
    }];
    
    
}


/**  上传视频 */

+(void)NetWorkingUpLoadVeidoWithfileData:(NSData *)fileData  parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
   
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
      [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
      [manager POST:QiNiuYunUploadURL parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
          
          if (fileData) {
              [formData appendPartWithFileData:fileData name:@"file" fileName:@"369369.mp4" mimeType:@"video/quicktime"];
          }
          
      } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          if (success)
          {
              success(task,responseObject);
          }
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [SVProgressHUD showErrorWithStatus:@"网络异常"];
          if (failure)
          {
              failure(task,error);
          }
      }];
    
    
 
    
    
    
}

/** 上传音频或者视频 */
+(void)NetWorkingUpLoadVeidoWithfileData:(NSData *)fileData  parameters:(id)parameters progress:(uploadProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
       AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
         [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
         [manager POST:QiNiuYunUploadURL parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
             
             if (fileData) {
                 [formData appendPartWithFileData:fileData name:@"file" fileName:@"369369.mp4" mimeType:@"video/quicktime"];
             }
             
         } progress:^(NSProgress * _Nonnull uploadProgress) {
             
             NSLog(@"-------\n%@",uploadProgress);

             
             if (progress) {
                 progress(uploadProgress.fractionCompleted);
             }
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             if (success)
             {
                 success(task,responseObject);
             }
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [SVProgressHUD showErrorWithStatus:@"网络异常"];
             if (failure)
             {
                 failure(task,error);
             }
         }];
    
}


/**  上传音频 */
+(void)NetWorkingUpLoadMediaWithfileData:(NSData *)fileData  parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure{
    
   
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
      //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
      //    [mDict setValue:device forKey:@"deviceId"];
      //    [mDict setValue:@1 forKey:@"channel"];
      //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
      //    [mDict setValue:version forKey:@"version"];
      //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
      //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
      
      AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
      [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
      
      
      //    NSDictionary * dict = parameters;
      //    //获取josnzi字符串
      //    NSString * josnStr = [NSString convertToJsonData:dict];
      //    //获取MD5字符串
      //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
      //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
      
      [manager POST:QiNiuYunUploadURL parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
          
          if (fileData) {
//              [formData appendPartWithFileData:fileData name:@"file" fileName:@"369369.mp4" mimeType:@"video/quicktime"];
              [formData appendPartWithFileData:fileData name:@"file" fileName:@"369369.mp3" mimeType:@"application/octet-stream"];
          }
          
      } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
          if (success)
          {
              success(task,responseObject);
          }
          
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [SVProgressHUD showErrorWithStatus:@"网络异常"];
          if (failure)
          {
              failure(task,error);
          }
      }];
    
    
    
}





@end
