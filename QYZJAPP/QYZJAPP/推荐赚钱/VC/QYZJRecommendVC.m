//
//  QYZJRecommendVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRecommendVC.h"
#import "QYZJRecommendOneCell.h"
#import "QYZJRecommendDetailTVC.h"
#import "QYZJFangDanOneTVC.h"
@interface QYZJRecommendVC ()

@end

@implementation QYZJRecommendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    self.navigationItem.title = @"详情";
    self.navigationItem.title = @"推荐赚钱";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJRecommendOneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setNavigation {
            
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
       button.frame = CGRectMake(0, 0, 50, 30);
       [button setTitle:@"放单" forState:UIControlStateNormal];
       button.titleLabel.font = [UIFont systemFontOfSize:14];
       [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       button.layer.cornerRadius = 0;
       button.clipsToBounds = YES;
       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           //点击放单
           QYZJFangDanOneTVC * vc =[[QYZJFangDanOneTVC alloc] init];
           vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
       }];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
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
    
    QYZJRecommendOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QYZJRecommendDetailTVC * vc =[[QYZJRecommendDetailTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
