//
//  PublicFuntionTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PublicFuntionTool : NSObject

+ (PublicFuntionTool *)shareTool;

#pragma mark ---- 获取图片第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size;
+ (void)presentVideoVCWithNSString:(NSString *)videoStr isBenDiPath:(BOOL)isBenDi;
- (void)palyMp3WithNSSting:(NSString *)meidaStr isLocality:(BOOL )isLocality;
@property(nonatomic,copy)void(^findPlayBlock)(void);

@end

NS_ASSUME_NONNULL_END
