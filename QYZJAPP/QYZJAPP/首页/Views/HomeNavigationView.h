//
//  HomeNavigationView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeNavigationView : UIView
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
