//
//  UIViewController+AlertShow.m
//  FMWXB
//
//  Created by kunzhang on 2017/11/10.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import "UIViewController+AlertShow.h"

@implementation UIViewController (AlertShow)

-(void)showAlertWithKey:(NSString *)num message:(NSString *)message{
    [SVProgressHUD dismiss];
    int n = [num intValue];
    NSString * msg = nil;
    
    switch (n)
    {
        case 1024:
        {
         
            break;
        }
           
        case 7:
        {
            
            
            break;
        }
          
        case 8:
        {
          
            break;
        }   
        default:
            msg=[NSString stringWithFormat:@"%@",message];
            break;
    }

    if (msg)
    {

        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * confirm =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    
    
    
}

@end
