//
//  LLPassWordAlertView.h
//  LLPassWordInsertView
//
//  Created by 李龙 on 2017/5/26.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^FinishedBlock)(NSString *pwStr);
typedef void (^CancelBlick)();

@interface LLPassWordAlertView : UIView


+ (void)showWithTitle:(NSString *)title desStr:(NSString *)desStr finish:(FinishedBlock)finish canelBtnOnClick:(CancelBlick)cancel;

+ (void)showWithTitle:(NSString *)title desStr:(NSString *)desStr finish:(FinishedBlock)finish;

@end
