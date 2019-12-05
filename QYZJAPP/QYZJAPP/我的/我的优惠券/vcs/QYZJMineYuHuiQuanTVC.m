//
//  QYZJMineYuHuiQuanTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/3.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineYuHuiQuanTVC.h"
#import "QYZJMineYuHuiQuanCell.h"
@interface QYZJMineYuHuiQuanTVC ()

@end

@implementation QYZJMineYuHuiQuanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineYuHuiQuanCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW - 20) * 125/345 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineYuHuiQuanCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
