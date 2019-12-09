//
//  QYZJCreateNewJiaoFuTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJCreateNewJiaoFuTVC.h"
#import "QYZJRecommendTwoCell.h"
#import "QYZJJiaoFuZiLiaoTVC.h"
@interface QYZJCreateNewJiaoFuTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate,zkPickViewDelelgate>
@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *quDaoArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *LeiXingArr;
@property(nonatomic,strong)NSArray *leftArr,*placeholdArr,*chooseArr;
@end

@implementation QYZJCreateNewJiaoFuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建交付";
    
    self.leftArr = @[@"客户姓名",@"客户地址",@"详细地址",@"联系方式",@"需求分类",@"建筑面积"];
    self.placeholdArr = @[@"请输入客户名字",@"请输入客户地址",@"详细地址",@"请输入联系方式",@"请选择需求分类",@"请输入建筑面积"];
    self.quDaoArr = [NSMutableArray mutableCopy];
    self.LeiXingArr = [NSMutableArray mutableCopy];
    self.cityArray = @[].mutableCopy;
    
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
    
    [self setFootV];
}


- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"下一步" andImgaeName:@""];
    Weak(weakSelf);
     view.footViewClickBlock = ^(UIButton *button) {
              NSLog(@"\n\n%@",@"下一步");
         QYZJJiaoFuZiLiaoTVC * vc =[[QYZJJiaoFuZiLiaoTVC alloc] init];
         vc.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:vc animated:YES];
         
         
    };
    [self.view addSubview:view];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 80;
    }
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.leftArr.count;
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
    
    if (indexPath.row == 2) {
        QYZJRecommendTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYZJRecommendTwoCell" forIndexPath:indexPath];
        cell.clipsToBounds = YES;
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.swith.hidden = YES;
        cell.TF.delegate = self;
        cell.TF.placeholder = self.placeholdArr[indexPath.row];
        cell.TF.userInteractionEnabled = NO;
        cell.moreImgV.hidden = NO;
        cell.TF.mj_w = ScreenW - 150;
        if (indexPath.row == 1||indexPath.row == 4) {
            cell.moreImgV.hidden = NO;
            cell.leftLB.mj_w = 200;
        } else   {
            cell.moreImgV.hidden = YES;
            cell.TF.mj_w = ScreenW - 120;
            cell.TF.userInteractionEnabled = YES;
            if (indexPath.row == 5) {
                cell.rightLB.hidden = NO;
                cell.rightLB.text = @"m²";
            }
        }
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArray;
        picker.array = self.cityArray;
        picker.selectLb.text = @"请选择地址";
        [picker show];
        
    }else if (indexPath.row == 1) {
        
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

#pragma mark ------- 点击筛选城市或者其它 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    
}

#pragma mark ----- 输入描述结束 -----
- (void)textViewDidEndEditing:(UITextView *)textView {
    
}
#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}


- (void)getCityData {
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_addressURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.cityArray = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
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
