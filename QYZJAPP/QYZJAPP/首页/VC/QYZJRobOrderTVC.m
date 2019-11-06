//
//  QYZJRobOrderTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/6.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJRobOrderTVC.h"
#import "QYZJQianDanNavigaTitleView.h"
#import "QYZJHomeFourCell.h"
#import "QYZJQianDanOneCell.h"
@interface QYZJRobOrderTVC ()

@end

@implementation QYZJRobOrderTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addTitleView];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFourCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFourCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJQianDanOneCell" bundle:nil] forCellReuseIdentifier:@"QYZJQianDanOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)addTitleView {
    
    QYZJQianDanNavigaTitleView * view = [[QYZJQianDanNavigaTitleView alloc] initWithFrame:CGRectMake(0, 200, ScreenW - 160, 40)];
    view.navigaBlock = ^(NSInteger index) {
        
    };
    self.navigationItem.titleView = view;
    
//    [self.view addSubview:view];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 5;
    }
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    }
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
       QYZJHomeFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFourCell" forIndexPath:indexPath];
        return cell;
    }else {
       QYZJQianDanOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJQianDanOneCell" forIndexPath:indexPath];
        return cell;
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseNavigationController * navc = [[BaseNavigationController alloc] initWithRootViewController:[[QYZhuJiaLoginVC alloc] init]];
    [self presentViewController:navc animated:YES completion:nil];
}


@end
