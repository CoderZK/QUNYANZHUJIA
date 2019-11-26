//
//  PublicFuntionTool.h
//  QYZJAPP
//
//  Created by zk on 2019/11/7.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KKKKFootView;
@interface PublicFuntionTool : NSObject

+ (PublicFuntionTool *)shareTool;

#pragma mark ---- 获取图片第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size;
+ (void)presentVideoVCWithNSString:(NSString *)videoStr isBenDiPath:(BOOL)isBenDi;
- (void)palyMp3WithNSSting:(NSString *)meidaStr isLocality:(BOOL )isLocality;
@property(nonatomic,copy)void(^findPlayBlock)(void);
@property(nonatomic,copy)void(^finshClickBlock)(UIButton *button);

- (KKKKFootView *) createFootvWithTitle:(NSString *)title andImgaeName:(NSString *)imgName;
- (KKKKFootView *) createFootvTwoWithLeftTitle:(NSString *)title letfTietelColor:(UIColor *)leftColor rightTitle:(NSString *)rightTitle rightColor:(UIColor *)rightColor;

+ (void)getImageFromPHAsset:(PHAsset *)asset Complete:(void(^)(NSData * data,NSString * str))result;
@end


@interface KKKKFootView : UIView
@property(nonatomic,copy)void(^footViewClickBlock)(UIButton *button);
@property(nonatomic,strong)NSString *titleStr;

@end

