//
//  QYZJMineVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/1.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineVC.h"
#import "QYZJNoDataView.h"
#import "QYZJMineHeadView.h"
#import "HHYMineFourCell.h"
#import "QYZJMIneTwoCell.h"
#import "QYZJSettingTVC.h"
#import "QYZJMessageTVC.h"
@interface QYZJMineVC ()
@property(nonatomic,strong)QYZJMineHeadView *headV;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)NSArray *titleArr,*imgTitleArr;
@end

@implementation QYZJMineVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.headV = [[QYZJMineHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 160)];
    Weak(weakSelf);
    self.headV.clickMineHeadBlock = ^(NSInteger index) {
        if (index == 0) {
            //点击头像
            
        }else if (index == 1){
            QYZJSettingTVC * vc =[[QYZJSettingTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else {
            //点击消息
            QYZJMessageTVC * vc =[[QYZJMessageTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
    self.tableView.tableHeaderView = self.headV;
    
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH+sstatusHeight);
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYMineFourCell" bundle:nil] forCellReuseIdentifier:@"HHYMineFourCell"];
    [self.tableView registerClass:[QYZJMIneTwoCell class] forCellReuseIdentifier:@"QYZJMIneTwoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headTitleArr = @[@"",@"我的",@"资产",@"装修工具",@"联系客服"];
    
    self.titleArr = @[@[],@[@"我的收藏",@"我的支付",@"我的保修",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布",@"我的案例",@"预约裁判"],@[@"我的钱包",@"申请入住",@"服务方修改",@"我的优惠",@"增值服务",@"我的标签"],@[@"记账",@"3D设计",@"装修直播",@"装修贷"],@[@"联系客服",@"关于我们"]];
    
     self.imgTitleArr = @[@[],@[@"我的收藏",@"我的支付",@"我的保修",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布",@"我的案例",@"预约裁判"],@[@"我的钱包",@"申请入住",@"服务方修改",@"我的优惠",@"增值服务",@"我的标签"],@[@"记账",@"3D设计",@"装修直播",@"装修贷"],@[@"联系客服",@"关于我们"]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        NSArray * arr = self.titleArr[section];
        return arr.count /4 + (arr.count % 4>0?1:0);
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }else {
        return 100;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
        return 50;
        
    }
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    QYZJTongYongHeadFootView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (view == nil) {
        view = [[QYZJTongYongHeadFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 49.4, ScreenW, 0.6)];
         backV.backgroundColor = lineBackColor;
         [view addSubview:backV];
    }
    view.leftLB.text = self.headTitleArr[section];
    view.backgroundColor = WhiteColor;
    view.contentView.backgroundColor = WhiteColor;
    view.lineV.hidden = NO;
    view.clipsToBounds = view.rightBt.hidden = YES;
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HHYMineFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"HHYMineFourCell" forIndexPath:indexPath];
          
          return cell;
    }else {
        QYZJMIneTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJMIneTwoCell" forIndexPath:indexPath];
        NSArray * arr = self.titleArr[indexPath.section];
        NSArray * imgArr = self.imgTitleArr[indexPath.section];
        if ((indexPath.row + 1) * 4 <=arr.count) {
            cell.imgArr = [imgArr subarrayWithRange:NSMakeRange(indexPath.row * 4, 4)];
            cell.titleArr = [arr subarrayWithRange:NSMakeRange(indexPath.row * 4, 4)];
            
        }else {
            cell.imgArr = [imgArr subarrayWithRange:NSMakeRange(indexPath.row * 4, arr.count - indexPath.row * 4)];
            cell.titleArr = [arr subarrayWithRange:NSMakeRange(indexPath.row * 4, arr.count - indexPath.row * 4)];
            
        }
        
        return cell;
    }
    
    HHYMineFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"HHYMineFourCell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
