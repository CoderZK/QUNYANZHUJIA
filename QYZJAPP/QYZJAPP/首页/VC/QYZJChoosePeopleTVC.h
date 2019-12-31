//
//  QYZJChoosePeopleTVC.h
//  QYZJAPP
//
//  Created by zk on 2019/12/23.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZJChoosePeopleTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; // 1 裁判  2 教练  1 预约 2 提问 
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,assign)BOOL isSelectOK;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *selctArr;
@property(nonatomic,strong)NSString *titleStr,*desStr,*videoStr,*strAudionStr;
@property(nonatomic,strong)NSArray *picArr;
@property(nonatomic,assign)NSInteger isOpen;
@end

NS_ASSUME_NONNULL_END
