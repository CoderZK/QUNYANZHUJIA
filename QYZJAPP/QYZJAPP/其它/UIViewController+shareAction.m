//
//  UIViewController+shareAction.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "UIViewController+shareAction.h"
#import <objc/runtime.h>
@implementation UIViewController (shareAction)


static const void *urlKey = &urlKey;

- (void)shareWithSetPreDefinePlatforms:(NSArray *)platforms withUrl:(NSString *)url shareModel:(NSString *)imgStr withContentStr:(NSString *)contentStr andTitle:(NSString * )titleStr{
    

    
           [UMSocialUIManager setPreDefinePlatforms:platforms];
           [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
               // 根据获取的platformType确定所选平台进行下一步操作
               self.url = url;
               NSString *urlKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[QYZJURLDefineTool getImgURLWithStr: imgStr]]]];
                  UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlKey];
                  if (!image) {
                      image = [UIImage imageNamed:@"1024"];
                  }
               if (titleStr.length == 0) {
                   [self shareWebPageToPlatformType:platformType withTitle:@"群燕筑家" andContent:contentStr thumImage:image];
               }else {
                   [self shareWebPageToPlatformType:platformType withTitle:titleStr andContent:contentStr thumImage:image];
               }
              
               
           }];
    
    
    
}

- (void)setUrl:(NSString *)url {
    objc_setAssociatedObject(self, urlKey, url, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)url {
    return objc_getAssociatedObject(self, urlKey);
}





- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title andContent:(NSString *)contentStr thumImage:(id)thumImage
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:contentStr thumImage:thumImage];
    //设置网页地址
    shareObject.webpageUrl = self.url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}




@end
