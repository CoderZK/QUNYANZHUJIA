//
//  QYZJSearchView.h
//  QYZJAPP
//
//  Created by zk on 2019/11/8.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QYZJSearchView : UIView
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)void(^clickHeadBlock)(NSInteger index);
@end




@interface QYZJSeNeiView : UIView
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,copy)void(^clickNeiBlock)(NSInteger index);
@end





