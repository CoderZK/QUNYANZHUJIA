//
//  QYZJShowFromTopView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJShowFromTopView : UIView
- (void)show;
- (void)diss;
@property(nonatomic,strong)UITextField *TF;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
