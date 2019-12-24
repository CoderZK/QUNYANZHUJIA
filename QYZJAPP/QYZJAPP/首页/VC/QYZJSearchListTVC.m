//
//  QYZJSearchListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/26.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSearchListTVC.h"
#import "QYZJHomeFiveCell.h"
@interface QYZJSearchListTVC ()
@property(nonatomic,strong)UITextField *searchTF;
@property(nonatomic,strong)UIButton *editBt;
@property (nonatomic , strong)UIView * headView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray<QYZJFindModel *> *dataArray;
@property(nonatomic,strong)NSString *searchWord;
@end

@implementation QYZJSearchListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHeadView];;
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJHomeFiveCell" bundle:nil] forCellReuseIdentifier:@"QYZJHomeFiveCell"];
      self.page = 1;
      self.dataArray = @[].mutableCopy;
//      [self getData];
      self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          self.page = 1;
          [self getData];
      }];
      self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
          self.page++;
          [self getData];
      }];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)getData {
    
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"page"] = @(self.page);
    dict[@"pageSize"] = @(10);
    dict[@"type"] = @(self.type);
    dict[@"search_word"] = self.searchWord;
    dict[@"search_type"] = @(self.type);
    dict[@"search_end_type"] = @(1);
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_searchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] integerValue] == 1) {
            NSArray<QYZJFindModel *>*arr = [QYZJFindModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
            }
            [self.tableView reloadData];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"key"]] message:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
}

- (void)setHeadView {
    
     self.headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 100,44)];
    
      UIView * leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
      UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 14, 14)];
      imgView.image = [UIImage imageNamed:@"search-1"];
      [leftview addSubview:imgView];
      self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 5 , ScreenW - 130, 34)];
      NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索" attributes:
                                        @{NSForegroundColorAttributeName:CharacterBlack112,
                                          NSFontAttributeName:self.searchTF.font
                                          }];
      self.searchTF.attributedPlaceholder = attrString;
      self.searchTF.font = [UIFont systemFontOfSize:14];
      self.searchTF.backgroundColor = UIColor.whiteColor;
      self.searchTF.textColor = CharacterBlack112;
      self.searchTF.backgroundColor = [UIColor groupTableViewBackgroundColor];
      self.searchTF.leftView = leftview;
      self.searchTF.leftViewMode = UITextFieldViewModeAlways;
      self.searchTF.layer.cornerRadius = 4;
      self.searchTF.layer.masksToBounds = YES;
      self.searchTF.returnKeyType = UIReturnKeySearch;
    @weakify(self);
    [[self.searchTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.searchWord = x;
        self.page = 1;
        [self getData];
        
    }];
      [self.headView addSubview:self.searchTF];

     
      self.navigationItem.titleView = self.headView;
      
      
      UIButton * submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, 60, 44)];
      submitBtn.layer.cornerRadius = 22;
      submitBtn.layer.masksToBounds = YES;
      [submitBtn setTitle:@"搜索" forState:UIControlStateNormal];
      [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
      submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      submitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      self.editBt = submitBtn;
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
    
    [[self.searchTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
       
        
        
    }];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        QYZJHomeFiveCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJHomeFiveCell" forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        cell.headBt.tag = indexPath.row;
        return cell;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    QYZJMineZhuYeTVC * vc =[[QYZJMineZhuYeTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.ID = self.dataArray[indexPath.row].ID;
    

 
}




- (void)submitBtnClick:(UIButton *)button {
    
}

@end
