//
//  QYZJSystemCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJSystemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *whiteV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIView *whiteVTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picHcons;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)QYZJFindModel *model;
@end

NS_ASSUME_NONNULL_END
