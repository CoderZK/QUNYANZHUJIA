//
//  QYZJBaoXiuDetailCell.h
//  QYZJAPP
//
//  Created by zk on 2019/12/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface QYZJBaoXiuDetailCell : UITableViewCell
@property(nonatomic,strong)QYZJFindModel *waiModel;
@property(nonatomic,assign)BOOL isServer;
@property(nonatomic,strong)UIButton *fuHuiBt,*deleteBt;
@end


@interface QYZJBaoXiuDetailNeiCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)QYZJFindModel *model;
@end
