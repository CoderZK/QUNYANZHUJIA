//
//  QYZJFangDanTwoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJFangDanTwoTVC.h"
#import "QYZJRecommendTwoCell.h"
#import "QYZJRecommendFootV.h"
@interface QYZJFangDanTwoTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *quDaoArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *LeiXingArr;
@property(nonatomic,strong)NSArray *leftArr,*placeholdArr,*chooseArr;
@property(nonatomic,strong)QYZJRecommendFootV *footV;
@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;
@end

@implementation QYZJFangDanTwoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"放单";
    self.leftArr = @[@"小区名称",@"推荐渠道",@"需求类型",@"风格",@"户型",@"装修时间",@"建筑面积",@"预算",@"描述",@"",@"是否实名推荐",@"是否通知被推荐人"];
    self.placeholdArr = @[@"请输入小区名称",@"请选择分类(可多选)",@"请选择需求类型",@"请选择风格",@"请选择户型",@"请选择装修时间",@"请输入建筑面积",@"请输入预算",@"请输入描述",@"",@"是否实名推荐",@"是否通知被推荐人"];
    self.quDaoArr = [NSMutableArray mutableCopy];
    self.LeiXingArr = [NSMutableArray mutableCopy];
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getQuDaoArrList];
    [self getLeiXingArrList];
    

    [self setFootV];
    [self setTableViewFootView];
    self.moreChooseV = [[QYZJMoreChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
}

- (void)setTableViewFootView {
    
    self.footV = [[QYZJRecommendFootV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 120)];
    Weak(weakSelf);
    self.footV.clickRecommendFootVBlock = ^{
        
    };
    self.tableView.tableFooterView = self.footV;
    
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }

    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    Weak(weakSelf);
     view.footViewClickBlock = ^(UIButton *button) {
              NSLog(@"\n\n%@",@"完成");
    };
    [self.view addSubview:view];
}

- (void)getQuDaoArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_labelListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.quDaoArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)getLeiXingArrList {
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_demandTypeListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.LeiXingArr = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 8) {
        return 135;
    }
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 8) {
        QYZJRecommendTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYZJRecommendTwoCell" forIndexPath:indexPath];
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.TF.delegate = self;
        cell.TF.placeholder = self.placeholdArr[indexPath.row];
        cell.TF.userInteractionEnabled = NO;
        cell.moreImgV.hidden = NO;
        cell.TF.mj_w = ScreenW - 150;
        cell.swith.hidden = YES;
        if (indexPath.row == 0 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 9) {
            cell.moreImgV.hidden = YES;
            cell.TF.mj_w = ScreenW - 120;
            cell.TF.userInteractionEnabled = YES;
        }else if (indexPath.row == 11||indexPath.row == 10) {
            cell.swith.hidden = NO;
            cell.leftLB.mj_w = 200;
            cell.moreImgV.hidden =  cell.TF.hidden = YES;
            
        }
        return cell;
    }
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        //        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //        picker.delegate = self ;
        //        picker.arrayType = AreaArray;
        //        picker.array = self.quDaoArr;
        //        picker.selectLb.text = @"";
        //        [picker show];
        NSMutableArray<QYZJTongYongModel *> *arr = @[].mutableCopy;
        for (int i = 0 ; i < 10; i++) {
            QYZJTongYongModel * model = [[QYZJTongYongModel alloc] init];
            model.name = [NSString stringWithFormat:@"测试%d",i];
            [arr addObject:model];
        }
        self.moreChooseV.dataArray = arr;
        [self.moreChooseV show];
        
    }else if (indexPath.row == 2) {
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = NormalArray
        ;
        picker.array = self.LeiXingArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }else if (indexPath.row == 3) {
        
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = titleArray;
        picker.array = @[@"简约",@"中式",@"欧式",@"美式",@"田园",@"地中海",@"其它"].mutableCopy;
        picker.selectLb.text = @"";
        [picker show];
        
    }else if (indexPath.row == 4) {
        
    }
    
    
    
}

#pragma mark ---- 点击完成 ----
- (void)clickAction:(UIButton *)button {
    
}

#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    
}

#pragma mark ----- 输入描述结束 -----
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}
#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

@end
