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
#import "QYZJfansAndAttentionTVC.h"
#import "QYZJMineShopTVC.h"
#import "QYZJMineCollectTVC.h"
#import "QYZJMineQuestTVC.h"
@interface QYZJMineVC ()<HHYMineFourCellDelegate,QYZJMIneTwoCellDelegate>
@property(nonatomic,strong)QYZJMineHeadView *headV;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)NSArray *titleArr,*imgTitleArr;
@property(nonatomic,strong)QYZJUserModel *dataModel;
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
    
    self.imgTitleArr = @[@[],@[@"wd_1",@"wd_2",@"wd_3",@"wd_4",@"wd_5",@"wd_6",@"wd_7",@"wd_8",@"wd_9"],@[@"zc_1",@"zc_2",@"zc_6",@"zc_3",@"zc_4",@"zc_5"],@[@"zxgj_1",@"zxgj_2",@"zxgj_3",@"zxgj_4"],@[@"lxkf_1",@"lxkf_2"]];
    
    
    [self getUserInfo];
}


- (void)getUserInfo {
    [SVProgressHUD show];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_centerInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
    
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
        cell.delegate = self;
        cell.model = self.dataModel;
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
        cell.delegate = self;
        
        return cell;
    }
    
    HHYMineFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"HHYMineFourCell" forIndexPath:indexPath];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark ----- dainji ------
- (void)didlMineTwoCell:(QYZJMIneTwoCell *)cell index:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 1) {
        if (index == 0) {
            QYZJMineCollectTVC * vc =[[QYZJMineCollectTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2) {
        
    }else if (indexPath.section == 3) {
        
    }else if (indexPath.section == 4) {
        
    }else if (indexPath.section == 5){
        
    }
    
    
    
    
}


#pragma mark ----- 点击粉丝,关注等 ----
- (void)didClickView:(HHYMineFourCell *)cell withIndex:(NSInteger )index {
    
    if (index == 0) {
        QYZJMineQuestTVC * vc =[[QYZJMineQuestTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index < 3) {
        QYZJfansAndAttentionTVC * vc =[[QYZJfansAndAttentionTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = index;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //点击店铺
        QYZJMineShopTVC * vc =[[QYZJMineShopTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.dataModel = self.dataModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
