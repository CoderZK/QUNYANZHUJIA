//
//  QYZJFindOneCell.h
//  QYZJAPP
//
//  Created by zk on 2019/11/4.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYZJFindOneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIButton *zanBt;
@property (weak, nonatomic) IBOutlet UIButton *pingLunBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentCons;

@end

NS_ASSUME_NONNULL_END
