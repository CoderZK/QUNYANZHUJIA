//
//  CIImage+Extension.h
//  QYZJAPP
//
//  Created by zk on 2019/12/20.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import <CoreImage/CoreImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)
+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
