//
//  FindHeadView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindHeadView : UIView
@property(nonatomic,strong)RACSubject *delegateSignal;
@property(nonatomic,assign)NSInteger isPresentVC;
@property(nonatomic,strong)NSString *titleStr;
@end

NS_ASSUME_NONNULL_END
