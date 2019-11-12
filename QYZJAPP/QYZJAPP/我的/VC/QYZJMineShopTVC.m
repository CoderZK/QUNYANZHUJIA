//
//  QYZJMineShopTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineShopTVC.h"
#import "QYZJMineShopHeadView.h"
#import "QYZJMineShopCell.h"
@interface QYZJMineShopTVC ()
@property(nonatomic,strong)QYZJMineShopHeadView *headV;
@property(nonatomic,assign)NSInteger page;
@end

@implementation QYZJMineShopTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headV = [[QYZJMineShopHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    self.headV.mj_h = self.headV.headHeight;
    self.tableView.tableHeaderView = self.headV;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineShopCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.headV.clickShopHeadBlock = ^(NSInteger index) {
      
        
        
    };
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat hh = (ScreenW - 30) / 2 * 3 / 4;
    return hh + 40 +20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineShopCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
