//
//  QYZJCreateShiGongQingDanTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/25.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJCreateShiGongQingDanTVC.h"
#import "QYZJRecommendTwoCell.h"
@interface QYZJCreateShiGongQingDanTVC ()<zkPickViewDelelgate,UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)NSArray *leftArrOne;
@property(nonatomic,strong)NSArray *leftArrTwo;
@property(nonatomic,strong)NSArray * placeArrOne;
@property(nonatomic,strong)NSArray *placeArrTwo;
@property(nonatomic,strong)NSArray *rightArr;

@end

@implementation QYZJCreateShiGongQingDanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"创建施工清单";
    self.leftArrOne = @[@"标题",@"备注",@"总价",@"工期",@"时间段"];
    self.leftArrTwo = @[@"施工阶段",@"付款比例",@"阶段金额",@"工期",@"时间段"];
    self.placeArrOne =@[@"请输入标题",@"请输入备注",@"请输入总价",@"请输入总工期",@"请选择开始时间"];
    self.placeArrTwo = @[@"施工阶段",@"放款比例",@"施工金额",@"工期",@"时间段"];
    
    
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[QYZJRecommendTwoCell class] forCellReuseIdentifier:@"QYZJRecommendTwoCell"];
    
    [self addFootV];
    
}

- (void)addFootV {
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"发起交付" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton * _Nonnull button) {
        
    };
    [self.view addSubview:view];
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 15, 40)];
    [footV addSubview:bt];
    [bt setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    bt.titleLabel.font = kFont(14);
    [bt setTitle:@"添加新的施工工期,付款比例,工期,时间段" forState:UIControlStateNormal];
    [bt setTitleColor:OrangeColor forState:UIControlStateNormal];
    [bt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bt setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [bt addTarget:self action:@selector(addJieDuan) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.tableView.tableFooterView = footV;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.leftArrOne.count;
    }
    
    return self.leftArrTwo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 && indexPath.section == 0) {
        return 80;
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
    
    if (indexPath.row == 1 && indexPath.section ==0) {
        QYZJRecommendTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"QYZJRecommendTwoCell" forIndexPath:indexPath];
        cell.clipsToBounds = YES;
        return cell;
    }else {
        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.rightLB.hidden = YES;
        cell.swith.hidden = YES;
        cell.TF.userInteractionEnabled = YES;
        cell.moreImgV.hidden = YES;
        if (indexPath.section ==0) {
            cell.leftLB.text = self.leftArrOne[indexPath.row];
            cell.TF.placeholder = self.placeArrOne[indexPath.row];
            if (indexPath.row < 4 ) {
                if (indexPath.row == 3) {
                    cell.rightLB.hidden = NO;
                    cell.rightLB.text = @"天";
                }
            }else {
                cell.moreImgV.hidden = NO;
                cell.userInteractionEnabled = NO;
            }
        }else {
            cell.leftLB.text = self.leftArrTwo[indexPath.row];
            cell.TF.placeholder = self.placeArrTwo[indexPath.row];
            
            if (indexPath.row < 4 ) {
                
                if (indexPath.row == 1){
                    cell.rightLB.hidden = NO;
                    cell.rightLB.text = @"%";
                }else  if (indexPath.row == 2){
                    cell.rightLB.hidden = NO;
                    cell.rightLB.text = @"元";
                    cell.TF.userInteractionEnabled = NO;
                }else  if (indexPath.row == 3) {
                    cell.rightLB.hidden = NO;
                    cell.rightLB.text = @"天";
                }
            }else {
                cell.moreImgV.hidden = NO;
                cell.userInteractionEnabled = NO;
                
            }
            
            
        }
        cell.TF.delegate = self;
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        
        
    }else if (indexPath.row == 1) {
        
        //        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //        picker.delegate = self ;
        //        picker.arrayType = AreaArray;
        //        picker.array = self.quDaoArr;
        //        picker.selectLb.text = @"";
        //        [picker show];
        //        NSMutableArray<QYZJTongYongModel *> *arr = @[].mutableCopy;
        //        for (int i = 0 ; i < 10; i++) {
        //            QYZJTongYongModel * model = [[QYZJTongYongModel alloc] init];
        //            model.name = [NSString stringWithFormat:@"测试%d",i];
        //            [arr addObject:model];
        //        }
        //        self.moreChooseV.dataArray = arr;
        //        [self.moreChooseV show];
        
    }else if (indexPath.row == 2) {
        //        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //        picker.delegate = self ;
        //        picker.arrayType = NormalArray
        //        ;
        //        picker.array = self.LeiXingArr;
        //        picker.selectLb.text = @"";
        //        [picker show];
        
        
    }else if (indexPath.row == 3) {
        
        //        zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //        picker.delegate = self ;
        //        picker.arrayType = titleArray;
        //        picker.array = @[@"简约",@"中式",@"欧式",@"美式",@"田园",@"地中海",@"其它"].mutableCopy;
        //        picker.selectLb.text = @"";
        //        [picker show];
        
    }else if (indexPath.row == 4) {
        
    }
    
    
    
}

#pragma mark ---- 添加新阶段 ----
- (void)addJieDuan {
    
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



@end
