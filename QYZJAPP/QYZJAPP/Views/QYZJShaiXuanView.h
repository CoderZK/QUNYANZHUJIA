//
//  QYZJShaiXuanView.h
//  QYZJAPP
//
//  Created by zk on 2020/1/15.
//  Copyright © 2020 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJShaiXuanView : UIView
@property(nonatomic,copy)void(^clickShaiXuanBlock)(NSInteger index1,BOOL isDiss);
@property(nonatomic,assign)NSInteger selectIndex;
-(void)diss;
@end

NS_ASSUME_NONNULL_END
