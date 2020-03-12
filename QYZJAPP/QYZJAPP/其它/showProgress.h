//
//  showProgress.h
//  QYZJAPP
//
//  Created by zk on 2019/12/27.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface showProgress : NSObject
-(void)showViewOnView:(UIView *)vv;
@property(nonatomic,assign)CGFloat progress;
-(void)diss;
@end

NS_ASSUME_NONNULL_END
