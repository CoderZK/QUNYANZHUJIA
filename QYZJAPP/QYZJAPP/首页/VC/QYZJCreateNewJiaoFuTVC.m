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
#import "QYZJAddZiLiaoTVC.h"
@interface QYZJCreateNewJiaoFuTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate,zkPickViewDelelgate>
@property(nonatomic,strong)QYZJMoreChooseView *moreChooseV;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *quDaoArr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *LeiXingArr;
@property(nonatomic,strong)NSArray *leftArr,*placeholdArr,*chooseArr;
@property(nonatomic,strong)QYZJFindModel *dataModel;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation QYZJCreateNewJiaoFuTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建交付";
    
    self.dataModel = [[QYZJFindModel alloc] init];
    self.dataModel.proStr = self.dataModel.cityStr = self.dataModel.areaStr = @"";
    self.leftArr = @[@"客户姓名",@"客户地址",@"详细地址",@"联系方式",@"需求分类",@"建筑面积"];
    self.placeholdArr = @[@"请输入客户名字",@"请输入客户地址",@"详细地址",@"请输入联系方式",@"请选择需求分类",@"请输入建筑面积"];
    self.quDaoArr = [NSMutableArray mutableCopy];
    self.LeiXingArr = [NSMutableArray mutableCopy];
    self.cityArray = @[].mutableCopy;
    
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
    
    [self setFootV];
    
    [self getCityData];
    [self getLeiXingArrList];
    
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
         
         if (weakSelf.dataModel.nick_name.length == 0 || weakSelf.dataModel.pro_id.length == 0 || weakSelf.dataModel.address_pca.length == 0 || weakSelf.dataModel.telphone.length == 0 || weakSelf.dataModel.type_id == 0 || weakSelf.dataModel.area.length == 0) {
             [SVProgressHUD showErrorWithStatus:@"信息填写不全"];
             return ;
         }
         
         QYZJAddZiLiaoTVC * vc =[[QYZJAddZiLiaoTVC alloc] init];
         vc.hidesBottomBarWhenPushed = YES;
         vc.type = 1;
         vc.dataModel = self.dataModel;
         [weakSelf.navigationController pushViewController:vc animated:YES];
         
         
    };
    [self.view addSubview:view];
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
    return self.leftArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
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
    
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.text = self.leftArr[indexPath.row];
        cell.swith.hidden = YES;
        cell.TF.delegate = self;
        cell.TF.placeholder = self.placeholdArr[indexPath.row];
        cell.TF.userInteractionEnabled = NO;
        cell.TF.delegate = self;
        cell.moreImgV.hidden = NO;
        cell.TF.mj_w = ScreenW - 150;
        cell.TF.keyboardType= UIKeyboardTypeDefault;
        if (indexPath.row == 1||indexPath.row == 4 ) {
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
        
        if (indexPath.row == 0) {
            cell.TF.text = self.dataModel.nick_name.length > 0 ? self.dataModel.nick_name:@"";
        }else if (indexPath.row == 1){
            cell.TF.text = [NSString stringWithFormat:@"%@%@%@",self.dataModel.proStr,self.dataModel.cityStr,self.dataModel.areaStr];
        }else if (indexPath.row == 2){
            cell.TF.text = self.dataModel.address_pca;
        }else if (indexPath.row == 3){
            cell.TF.text = self.dataModel.telphone;
             cell.TF.keyboardType = UIKeyboardTypePhonePad;
        }else if (indexPath.row == 4){
            cell.TF.text = self.dataModel.type_name;
        }else if (indexPath.row == 5){
            cell.TF.text = self.dataModel.area;
            cell.TF.keyboardType =  UIKeyboardTypeDecimalPad;
        }
        return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    self.indexPath = indexPath;
    if (indexPath.row == 1) {
        if (self.cityArray.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"数据获取中..,先去填写其它资料"];
            [self getCityData];
            return;
            
        }
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = AreaArray;
        picker.array = self.cityArray;
        picker.selectLb.text = @"请选择地址";
        [picker show];
        
    }else if (indexPath.row == 4) {
        if (self.LeiXingArr.count == 0) {
           [SVProgressHUD showErrorWithStatus:@"数据获取中..,先去填写其它资料"];
           [self getLeiXingArrList];
           return;
        }
        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        picker.delegate = self ;
        picker.arrayType = NormalArray;
        picker.array = self.LeiXingArr;
        picker.selectLb.text = @"";
        [picker show];
        
        
    }
    
    
    
}



#pragma mark ------- 点击筛选城市或者其它 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    if (self.indexPath.row == 1) {
     
        self.dataModel.pro_id= self.cityArray[leftIndex].pid;
        self.dataModel.proStr = self.cityArray[leftIndex].pname;
        self.dataModel.city_id = self.cityArray[leftIndex].cityList[centerIndex].cid;
        self.dataModel.cityStr = self.cityArray[leftIndex].cityList[centerIndex].cname;
            if (rightIndex == 0) {
                self.dataModel.area_id = @"0";
                self.dataModel.areaStr = @"";
            }else {

                self.dataModel.area_id = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex-1].ID;
                self.dataModel.areaStr = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex-1].name;
            }
    }else {
      self.dataModel.type_id = [self.LeiXingArr[leftIndex].ID intValue];
      self.dataModel.type_name = self.LeiXingArr[leftIndex].name;
    }
    
    
    [self.tableView reloadData];
    
}

#pragma mark --- 填写内容结束时 ----
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    TongYongTwoCell * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 0) {
        self.dataModel.nick_name = textField.text;
    }else if (indexPath.row == 2) {
        self.dataModel.address_pca = textField.text;
    }else if (indexPath.row == 3) {
        self.dataModel.telphone = textField.text;
    }else if (indexPath.row == 5) {
        self.dataModel.area = textField.text;
    }
    
    [self.tableView reloadData];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    TongYongTwoCell  * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath.row == 5) {
        NSMutableString *futureString = [NSMutableString stringWithString:textField.text];
           [futureString insertString:string atIndex:range.location];
           
        if ([futureString containsString:@"-"]) {
            return NO;
        }
           NSInteger flag = 0;
           // 这个可以自定义,保留到小数点后两位,后几位都可以
           const NSInteger limited = 2;
           
           for (NSInteger i = futureString.length - 1; i >= 0; i--) {
               
               if ([futureString characterAtIndex:i] == '.') {
                   // 如果大于了限制的就提示
                   if (flag > limited) {
                       
                       [SVProgressHUD showErrorWithStatus:@"请输入最多两位小数的数值"];
                       return NO;
                   }
                   
                   break;
               }
               
               flag++;
           }
    }
    
    
    
    
   
    
    return YES;
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
