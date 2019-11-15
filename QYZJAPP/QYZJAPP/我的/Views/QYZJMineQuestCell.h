//
//  QYZJMineQuestCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/14.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface QYZJMineQuestCell : UITableViewCell
@property(nonatomic,strong)QYZJFindModel *waiModel;
@end



@interface QYZJMineQuestNeiCell : UITableViewCell
@property(nonatomic,strong)UILabel *titelLB;
@property(nonatomic,strong)QYZJFindModel *model;
@end


