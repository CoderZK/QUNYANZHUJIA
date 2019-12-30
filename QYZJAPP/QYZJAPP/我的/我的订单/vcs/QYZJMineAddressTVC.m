//
//  QYZJMineAddressTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/2.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJMineAddressTVC.h"
#import "QYZJAddAddressVC.h"
#import "QYZJMineAddressTwoCell.h"
@interface QYZJMineAddressTVC ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJMoneyModel *> *dataArray;
@end

@implementation QYZJMineAddressTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 1;
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"地址列表";
    

    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJMineAddressTwoCell" bundle:nil] forCellReuseIdentifier:@"cell"];    
    [self setFootV];
    self.page = 1;
    self.dataArray = @[].mutableCopy;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getData];
    }];
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"token"] = [zkSignleTool shareTool].session_token;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addressListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJMoneyModel *>*arr = [QYZJMoneyModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (void)setFootV {
    
  self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
  if (sstatusHeight > 20) {
      self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
  }
  KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"添加新地址" andImgaeName:@"jia"];
  Weak(weakSelf);
   view.footViewClickBlock = ^(UIButton *button) {
       QYZJAddAddressVC * vc =[[QYZJAddAddressVC alloc] init];
       vc.hidesBottomBarWhenPushed = YES;
       [weakSelf.navigationController pushViewController:vc animated:YES];
  };
  [self.view addSubview:view];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJMineAddressTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLB.text = self.dataArray[indexPath.row].address;
    cell.addressLB.text = self.dataArray[indexPath.row].addressPca;
    cell.phoneLB.text = self.dataArray[indexPath.row].linkTel;
    cell.deleteBt.tag = indexPath.row;
    [cell.deleteBt addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.chooseAddressBlock != nil) {
        self.chooseAddressBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)delectAction:(UIButton *)button {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"id"] = self.dataArray[button.tag].ID;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_deleteAddressURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"删除地址成功"];
            [self.dataArray removeObjectAtIndex:button.tag];
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
      
        
    }];
    
}


@end
