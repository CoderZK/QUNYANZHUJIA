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
#import "QYZJHomePayTVC.h"
#import "QYZJMineOrderTVC.h"
#import "QYZJMineInviteVC.h"
#import "QYZJMinePublicTVC.h"
#import "QYZJMineCaiPanTVC.h"
#import "QYZJAboutUsVC.h"
#import "QYZJMineAnLiTVC.h"
#import "QYZJMineWalletTVC.h"
#import "QYZJMineServicePeopleVC.h"
#import "QYZJMineZhuangXiuDaiVC.h"
#import "QYZJShengQingRuZhuVC.h"
#import "QYZJZengZhiFuWuTVC.h"
#import "HHYMineFiveCell.h"
#import "QYZJMineYuHuiQuanTVC.h"
#import "QYZJXiuGaiFuWuVC.h"
#import "QYZJMineCaiPanTVC.h"
#import "QYZJMineBaoXiuListTVC.h"
#import "QYZJMineYuYueDanTVC.h"
#import "QYZJMineZhiBoTVC.h"
#import "QYZJMineLabelsTVC.h"
#import "QYZJRuZhuThreeVC.h"
@interface QYZJMineVC ()<HHYMineFourCellDelegate,QYZJMIneTwoCellDelegate,HHYMineFiveCellDelegate>
@property(nonatomic,strong)QYZJMineHeadView *headV;
@property(nonatomic,strong)NSArray *headTitleArr;
@property(nonatomic,strong)NSArray *titleArr,*imgTitleArr;
@property(nonatomic,strong)QYZJUserModel *dataModel;
@end

@implementation QYZJMineVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    if ([zkSignleTool shareTool].isLogin) {
        [self getUserBaseicInfoTwo];
        [self getUserInfo];
    }else {
        [self gotoLoginVC];
    }
}

- (void)getUserBaseicInfoTwo {
    zkRequestTongYongTool * tool = [[zkRequestTongYongTool alloc] init];
    [tool requestWithUrl:[QYZJURLDefineTool user_basicInfoURL] andDict:@{}.mutableCopy];
    tool.subject = [[RACSubject alloc] init];
    @weakify(self);
    [tool.subject subscribeNext:^(id  _Nullable x) {
           @strongify(self);
           if (x !=nil && [x[@"key"] intValue] == 1) {
               [zkSignleTool shareTool].role = [[NSString stringWithFormat:@"%@",x[@"result"][@"role"]] intValue];
               if ([zkSignleTool shareTool].role == 0) {
                   self.titleArr = @[@[],@[@"我的收藏",@"我的交付",@"我的报修",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布",@"我的案例",@"预约裁判"],@[@"我的钱包",@"申请入驻",@"我的优惠",@"增值服务"],@[@"记账",@"3D设计",@"装修直播",@"装修贷"],@[@"联系客服",@"关于我们"]];
                   
                   self.imgTitleArr = @[@[],@[@"wd_1",@"wd_2",@"wd_3",@"wd_4",@"wd_5",@"wd_6",@"wd_7",@"wd_8",@"wd_9"],@[@"zc_1",@"zc_2",@"zc_3",@"zc_4"],@[@"zxgj_1",@"zxgj_2",@"zxgj_3",@"zxgj_4"],@[@"lxkf_1",@"lxkf_2"]];
                   
                   if (isUPUPUP) {
                       
                       
                       self.titleArr = @[@[],@[@"我的收藏",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布"],@[@"我的钱包",@"申请入驻"],@[],@[@"联系客服",@"关于我们"]];
                                         
                     self.imgTitleArr = @[@[],@[@"wd_1",@"wd_4",@"wd_5",@"wd_6",@"wd_7"],@[@"zc_1",@"zc_2"],@[],@[@"lxkf_1",@"lxkf_2"]];
                       
                   }
                   
                   [self.tableView reloadData];
               }else {
                   self.titleArr = @[@[],@[@"我的收藏",@"我的交付",@"我的报修",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布",@"我的案例",@"预约裁判"],@[@"我的钱包",@"申请入驻",@"服务方修改",@"我的优惠",@"增值服务",@"我的标签"],@[@"记账",@"3D设计",@"装修直播",@"装修贷"],@[@"联系客服",@"关于我们"]];
                   
                   self.imgTitleArr = @[@[],@[@"wd_1",@"wd_2",@"wd_3",@"wd_4",@"wd_5",@"wd_6",@"wd_7",@"wd_8",@"wd_9"],@[@"zc_1",@"zc_2",@"zc_6",@"zc_3",@"zc_4",@"zc_5"],@[@"zxgj_1",@"zxgj_2",@"zxgj_3",@"zxgj_4"],@[@"lxkf_1",@"lxkf_2"]];
                   
                   if (isUPUPUP) {
                       
                        self.titleArr = @[@[],@[@"我的收藏",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布"],@[@"我的钱包",@"申请入驻"],@[],@[@"联系客服",@"关于我们"]];
                                                               
                        self.imgTitleArr = @[@[],@[@"wd_1",@"wd_4",@"wd_5",@"wd_6",@"wd_7"],@[@"zc_1",@"zc_2"],@[],@[@"lxkf_1",@"lxkf_2"]];
                       
                       
                   }
                   
                   [self.tableView reloadData];
               }
           }else {
               [SVProgressHUD dismiss];
           }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headV = [[QYZJMineHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    self.headV.clipsToBounds = YES;
    Weak(weakSelf);
    self.headV.clickMineHeadBlock = ^(NSInteger index) {
        if (index == 0) {
            //点击头像
            
        }else if (index == 1){
            QYZJSettingTVC * vc =[[QYZJSettingTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.dataModel = weakSelf.dataModel;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"HHYMineFiveCell" bundle:nil] forCellReuseIdentifier:@"HHYMineFiveCell"];
    [self.tableView registerClass:[QYZJMIneTwoCell class] forCellReuseIdentifier:@"QYZJMIneTwoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.headTitleArr = @[@"",@"我的",@"资产",@"装修工具",@"联系客服"];
    
//    self.titleArr = @[@[],@[@"我的收藏",@"我的交付",@"我的报修",@"我的订单",@"我的预约",@"邀请有礼",@"我的发布",@"我的案例",@"预约裁判"],@[@"我的钱包",@"申请入驻",@"服务方修改",@"我的优惠",@"增值服务",@"我的标签"],@[@"记账",@"3D设计",@"装修直播",@"装修贷"],@[@"联系客服",@"关于我们"]];
//
//    self.imgTitleArr = @[@[],@[@"wd_1",@"wd_2",@"wd_3",@"wd_4",@"wd_5",@"wd_6",@"wd_7",@"wd_8",@"wd_9"],@[@"zc_1",@"zc_2",@"zc_6",@"zc_3",@"zc_4",@"zc_5"],@[@"zxgj_1",@"zxgj_2",@"zxgj_3",@"zxgj_4"],@[@"lxkf_1",@"lxkf_2"]];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUserInfo];
    }];
    
    
}


- (void)getUserInfo {
    [SVProgressHUD show];
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_centerInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            self.dataModel = [QYZJUserModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.dataModel = self.dataModel;
            self.headV.mj_h = 160;
            self.tableView.tableHeaderView = self.headV;
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
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
        if (isUPUPUP && indexPath.section == 3) {
            return 0;
        }
        return 100;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (isUPUPUP && section == 3) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
        if (isUPUPUP && section == 3) {
            return 0.01;
        }
        return 50;
        
    }
    return 0.01;
}

- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
        
        if ([zkSignleTool shareTool].role == 0) {
            HHYMineFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"HHYMineFiveCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.model = self.dataModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            HHYMineFourCell * cell =[tableView dequeueReusableCellWithIdentifier:@"HHYMineFourCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.model = self.dataModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark ----- dainji ------
- (void)didlMineTwoCell:(QYZJMIneTwoCell *)cell index:(NSInteger)index {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    NSInteger dd = index + indexPath.row * 4;
    
    if (isUPUPUP) {
        
        if (indexPath.section == 1) {
                
                if (dd == 0) {
                    QYZJMineCollectTVC * vc =[[QYZJMineCollectTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 1) {
                    QYZJMineOrderTVC * vc =[[QYZJMineOrderTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 2) {
                    QYZJMineYuYueDanTVC * vc =[[QYZJMineYuYueDanTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 3) {
                    QYZJMineInviteVC * vc =[[QYZJMineInviteVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.invitation_code = self.dataModel.invitation_code;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 4) {
                    QYZJMinePublicTVC * vc =[[QYZJMinePublicTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if (indexPath.section == 2) {
                if (dd == 0) {
                    QYZJMineWalletTVC * vc =[[QYZJMineWalletTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 1) {
                    if([zkSignleTool shareTool].role == 0) {
                        QYZJShengQingRuZhuVC* vc =[[QYZJShengQingRuZhuVC alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        
                        if (self.dataModel.is_referee && self.dataModel.is_coach) {
                            [SVProgressHUD showErrorWithStatus:@"您已经是教练和裁判身份"];
                            return;
                        }
                        QYZJRuZhuThreeVC * vc =[[QYZJRuZhuThreeVC alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        vc.isCocach = self.dataModel.is_coach;
                        vc.isReferee = self.dataModel.is_referee;
                        vc.isTwoApprove = YES;
                        vc.dataDict = @{}.mutableCopy;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        
                        
                    }
                    
                    
                }else {
                    
                    if ([zkSignleTool shareTool].role == 0) {
                        if (dd == 2) {
                            QYZJMineYuHuiQuanTVC * vc =[[QYZJMineYuHuiQuanTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 3) {
                            QYZJZengZhiFuWuTVC * vc =[[QYZJZengZhiFuWuTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.nameStr = self.dataModel.nick_name;
                            vc.headImg = self.dataModel.head_img;
                            vc.is_bond = self.dataModel.is_bond;
                            vc.bond_money = self.dataModel.bond_money;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }else {
                        if (dd == 2) {
                            QYZJXiuGaiFuWuVC * vc =[[QYZJXiuGaiFuWuVC alloc] init];
                           vc.hidesBottomBarWhenPushed = YES;
        //                   vc.proId = self.dataModel.pro_id;
        //                   vc.cityId = self.dataModel.city_id;
        //                   vc.aearId = self.dataModel.area_id;
        //                   vc.proStr = self.dataModel.pro_name;
        //                   vc.cityStr = self.dataModel.city_name;
        //                   vc.aearStr = self.dataModel.area_name;
                           [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 3) {
                            QYZJMineYuHuiQuanTVC * vc =[[QYZJMineYuHuiQuanTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 4) {
                            QYZJZengZhiFuWuTVC * vc =[[QYZJZengZhiFuWuTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.nameStr = self.dataModel.nick_name;
                            vc.headImg = self.dataModel.head_img;
                            vc.is_bond = self.dataModel.is_bond;
                            vc.bond_money = self.dataModel.bond_money;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 5){
                            QYZJMineLabelsTVC * vc =[[QYZJMineLabelsTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.labelsStr = self.dataModel.label;
                            vc.labelsId = self.dataModel.label_ids;
                            vc.role_id = self.dataModel.role_id;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }
                       
                    }
                }

            }else if (indexPath.section == 3) {
                if (dd == 3) {
                    QYZJMineZhuangXiuDaiVC * vc =[[QYZJMineZhuangXiuDaiVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 2){
                    QYZJMineZhiBoTVC * vc =[[QYZJMineZhiBoTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"暂未开放"];
                }
            }else if (indexPath.section == 4){
                if (dd == 0) {
                    QYZJMineServicePeopleVC * vc =[[QYZJMineServicePeopleVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 1) {
                    QYZJAboutUsVC * vc =[[QYZJAboutUsVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        
        
    }else {
       
        
        if (indexPath.section == 1) {
                
                if (dd == 0) {
                    QYZJMineCollectTVC * vc =[[QYZJMineCollectTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 1) {
                    QYZJHomePayTVC * vc =[[QYZJHomePayTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 2) {
                    QYZJMineBaoXiuListTVC * vc =[[QYZJMineBaoXiuListTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 3) {
                    QYZJMineOrderTVC * vc =[[QYZJMineOrderTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 4) {
                    QYZJMineYuYueDanTVC * vc =[[QYZJMineYuYueDanTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 5) {
                    QYZJMineInviteVC * vc =[[QYZJMineInviteVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.invitation_code = self.dataModel.invitation_code;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 6) {
                    QYZJMinePublicTVC * vc =[[QYZJMinePublicTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 7) {
                    QYZJMineAnLiTVC * vc =[[QYZJMineAnLiTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.user_id = [zkSignleTool shareTool].session_uid;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 8) {
                    QYZJMineCaiPanTVC * vc =[[QYZJMineCaiPanTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }else if (indexPath.section == 2) {
                if (dd == 0) {
                    QYZJMineWalletTVC * vc =[[QYZJMineWalletTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 1) {
                    
                    
                    
                    if([zkSignleTool shareTool].role == 0) {
                        QYZJShengQingRuZhuVC* vc =[[QYZJShengQingRuZhuVC alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:vc animated:YES];
                    }else {
                        
                        if (self.dataModel.is_referee && self.dataModel.is_coach) {
                            [SVProgressHUD showErrorWithStatus:@"您已经是教练和裁判身份"];
                            return;
                        }
                        QYZJRuZhuThreeVC * vc =[[QYZJRuZhuThreeVC alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        vc.isCocach = self.dataModel.is_coach;
                        vc.isReferee = self.dataModel.is_referee;
                        vc.isTwoApprove = YES;
                        vc.dataDict = @{}.mutableCopy;
                        [self.navigationController pushViewController:vc animated:YES];
                        
                        
                        
                    }
                    
                    
                }else {
                    
                    if ([zkSignleTool shareTool].role == 0) {
                        if (dd == 2) {
                            QYZJMineYuHuiQuanTVC * vc =[[QYZJMineYuHuiQuanTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 3) {
                            QYZJZengZhiFuWuTVC * vc =[[QYZJZengZhiFuWuTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.nameStr = self.dataModel.nick_name;
                            vc.headImg = self.dataModel.head_img;
                            vc.is_bond = self.dataModel.is_bond;
                            vc.bond_money = self.dataModel.bond_money;
                            [self.navigationController pushViewController:vc animated:YES];
                        }
                    }else {
                        if (dd == 2) {
                            QYZJXiuGaiFuWuVC * vc =[[QYZJXiuGaiFuWuVC alloc] init];
                           vc.hidesBottomBarWhenPushed = YES;
        //                   vc.proId = self.dataModel.pro_id;
        //                   vc.cityId = self.dataModel.city_id;
        //                   vc.aearId = self.dataModel.area_id;
        //                   vc.proStr = self.dataModel.pro_name;
        //                   vc.cityStr = self.dataModel.city_name;
        //                   vc.aearStr = self.dataModel.area_name;
                           [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 3) {
                            QYZJMineYuHuiQuanTVC * vc =[[QYZJMineYuHuiQuanTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 4) {
                            QYZJZengZhiFuWuTVC * vc =[[QYZJZengZhiFuWuTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.nameStr = self.dataModel.nick_name;
                            vc.headImg = self.dataModel.head_img;
                            vc.is_bond = self.dataModel.is_bond;
                            vc.bond_money = self.dataModel.bond_money;
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if (dd == 5){
                            QYZJMineLabelsTVC * vc =[[QYZJMineLabelsTVC alloc] init];
                            vc.hidesBottomBarWhenPushed = YES;
                            vc.labelsStr = self.dataModel.label;
                            vc.labelsId = self.dataModel.label_ids;
                            vc.role_id = self.dataModel.role_id;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        }
                       
                    }
                }

            }else if (indexPath.section == 3) {
                if (dd == 3) {
                    QYZJMineZhuangXiuDaiVC * vc =[[QYZJMineZhuangXiuDaiVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 2){
                    QYZJMineZhiBoTVC * vc =[[QYZJMineZhiBoTVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"暂未开放"];
                }
            }else if (indexPath.section == 4){
                if (dd == 0) {
                    QYZJMineServicePeopleVC * vc =[[QYZJMineServicePeopleVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }else if (dd == 1) {
                    QYZJAboutUsVC * vc =[[QYZJAboutUsVC alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        
        
    }
    
    
    
    
    
    
    
    
    
}


#pragma mark ----- 点击粉丝,关注等 ----
- (void)didClickView:(HHYMineFourCell *)cell withIndex:(NSInteger )index {
    
    if (index == 0) {
        QYZJMineQuestTVC * vc =[[QYZJMineQuestTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index < 3) {
        QYZJfansAndAttentionTVC * vc =[[QYZJfansAndAttentionTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = index;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //点击店铺
        QYZJMineShopTVC * vc =[[QYZJMineShopTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isMine = YES;
        vc.dataModel = self.dataModel;
        vc.user_id = [zkSignleTool shareTool].session_uid;;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)didClickFiveCellWithIndex:(NSInteger)index {
    
    if (index == 0) {
        QYZJMineQuestTVC * vc =[[QYZJMineQuestTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index < 3) {
        QYZJfansAndAttentionTVC * vc =[[QYZJfansAndAttentionTVC alloc] initWithTableViewStyle:(UITableViewStyleGrouped)];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = index;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
