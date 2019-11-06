//
//  QYZJHomePayTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJHomePayTVC.h"
#import "QYZJHomePayCell.h"
@interface QYZJHomePayTVC ()

@end

@implementation QYZJHomePayTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的交付";
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(0, 0, 65, 30);
       [button setTitle:@"发起交付" forState:UIControlStateNormal];
       button.titleLabel.font = [UIFont systemFontOfSize:14];
       [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       button.layer.cornerRadius = 0;
       button.clipsToBounds = YES;
       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         
       }];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomePayCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJHomePayCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
