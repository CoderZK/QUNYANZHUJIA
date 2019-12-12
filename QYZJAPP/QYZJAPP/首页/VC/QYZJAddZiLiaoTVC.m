//
//  QYZJAddZiLiaoTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/12/12.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJAddZiLiaoTVC.h"
#import "QYZJJiaoFuZiLiaoCell.h"
@interface QYZJAddZiLiaoTVC ()<QYZJJiaoFuZiLiaoCellDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSArray *leftArr;
@property(nonatomic,strong)NSMutableArray *contracturlArr,*budgeturlArr,*drawingurlArr,*changetableurlArr;
@property(nonatomic,strong)NSString *signMoney,*commissionPrice;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)QYZJTongYongModel *imgModel,*videoModel;
@end

@implementation QYZJAddZiLiaoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加资料";
    [self.tableView registerClass:[QYZJJiaoFuZiLiaoCell class] forCellReuseIdentifier:@"QYZJJiaoFuZiLiaoCell"];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.leftArr = @[@"合同",@"预算表",@"图纸",@"变更表",@"签单额",@"佣金额"];
    self.contracturlArr = @[].mutableCopy;
    self.budgeturlArr = @[].mutableCopy;
    self.drawingurlArr = @[].mutableCopy;
    self.changetableurlArr = @[].mutableCopy;

    [self getImgDict];
    [self getVideoDict];
    
    [self setFootV];
    
}

- (void)setFootV {
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
    if (sstatusHeight > 20) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
    }
    
    KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"完成" andImgaeName:@""];
    Weak(weakSelf);
    view.footViewClickBlock = ^(UIButton *button) {
        [weakSelf.tableView endEditing:YES];
        
        [weakSelf clickAction:button];
        
    };
    [self.view addSubview:view];
}

- (void)getImgDict {
    [zkRequestTool getUpdateImgeModelWithCompleteModel:^(QYZJTongYongModel *model) {
           self.imgModel = model;
       }];
}


- (void)clickAction:(UIButton *)button {
 
    [self.tableView endEditing:YES];
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"demand_id"] = self.ID;
    dict[@"contract_url"] = [self.contracturlArr componentsJoinedByString:@","];
    dict[@"budget_url"] =  [self.contracturlArr componentsJoinedByString:@","];
    dict[@"drawing_url"] = [self.drawingurlArr componentsJoinedByString:@","];
    dict[@"change_table_url"] =  [self.changetableurlArr componentsJoinedByString:@","];
    dict[@"sign_money"] = self.signMoney;
    dict[@"commission_price"] = self.commissionPrice;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_addDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [SVProgressHUD showSuccessWithStatus:@"添加资料成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}

- (void)getVideoDict {
    
    [zkRequestTool getUpdateVideoModelWithCompleteModel:^(QYZJTongYongModel *model) {
        self.videoModel = model;
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4 || indexPath.row == 5) {
        return 50;
    }
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4 || indexPath.row == 5) {

        TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.leftLB.textColor = CharacterColor180;
        cell.rightLB.hidden = cell.swith.hidden = cell.moreImgV.hidden = YES;
        cell.TF.userInteractionEnabled = YES;
        if (indexPath.row == 4) {
            cell.leftLB.text = @"签单金额";
            cell.TF.placeholder = @"请输入签单额";
            cell.TF.text = self.signMoney;
        }else {
            cell.leftLB.text = @"佣金额";
            cell.TF.placeholder = @"点击获取佣金金额";
            cell.TF.userInteractionEnabled = NO;
            cell.TF.text = self.commissionPrice;
        }
        cell.TF.keyboardType = UIKeyboardTypeDecimalPad;
        cell.TF.delegate = self;
        return cell;
    }
    QYZJJiaoFuZiLiaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"QYZJJiaoFuZiLiaoCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.leftLB.text = self.leftArr[indexPath.row];
    if (indexPath.row == 0) {
          cell.dataArray = self.contracturlArr;
      }else if (indexPath.row == 1) {
          cell.dataArray = self.budgeturlArr;
      }else if (indexPath.row == 2) {
          cell.dataArray = self.drawingurlArr;
      }else if (indexPath.row == 3) {
          cell.dataArray = self.changetableurlArr;
      }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView endEditing:YES];
    if (indexPath.row == 5) {
        if ([self.signMoney floatValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入签单金额"];
            return;
        }
        [SVProgressHUD show];
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"demand_id"] = self.ID;
        dict[@"sign_money"] = self.signMoney;
        [zkRequestTool networkingPOST:[QYZJURLDefineTool app_getCommissonURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [SVProgressHUD dismiss];
            if ([responseObject[@"key"] intValue]== 1) {
                self.commissionPrice = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"commission_price"]];
                [self.tableView reloadData];
            }else {
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }];
        
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    TongYongTwoCell * cell = (TongYongTwoCell *)textField.superview;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row == 4) {
        self.signMoney = textField.text;
    }else if (indexPath.row ==5) {
        self.commissionPrice =  textField.text;
    }
    
}


#pragma mark ---- 点击图片添加或者删除 ----
- (void)didClickQYZJJiaoFuZiLiaoCell:(QYZJJiaoFuZiLiaoCell *)cell withIndex:(NSInteger)index withIsdelect:(BOOL)isDelect {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (isDelect) {
        if (indexPath.row == 0) {
            [self.contracturlArr removeObjectAtIndex:index];;
        }else if (indexPath.row == 1) {
            [self.budgeturlArr removeObjectAtIndex:index];
        }else if (indexPath.row == 2) {
            [self.drawingurlArr removeObjectAtIndex:index];
        }else if (indexPath.row == 3) {
            [self.changetableurlArr removeObjectAtIndex:index];
        }
        [self.tableView reloadData];
        
    }else {
        self.indexPath = indexPath;
        [self addPict];
    }
   
}


- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                if (self.indexPath.row == 0) {
                    [self.contracturlArr addObject:image];;
                }else if (self.indexPath.row == 1) {
                   [self.budgeturlArr addObject:image];
                }else if (self.indexPath.row == 2) {
                    [self.drawingurlArr addObject:image];
                }else if (self.indexPath.row == 3) {
                   [self.changetableurlArr addObject:image];
                }
                [self updateImgsToQiNiuYun];
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.allowTakeVideo = YES;
            imagePickerVc.allowTakePicture = NO;
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                if (self.indexPath.row == 0) {
                    [self.contracturlArr addObjectsFromArray:photos];;
                }else if (self.indexPath.row == 1) {
                   [self.budgeturlArr addObjectsFromArray:photos];
                }else if (self.indexPath.row == 2) {
                    [self.drawingurlArr addObjectsFromArray:photos];
                }else if (self.indexPath.row == 3) {
                   [self.changetableurlArr addObjectsFromArray:photos];
                }
                [self updateImgsToQiNiuYun];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}



//创建上传图片队列
- (void)updateImgsToQiNiuYun {
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray * picsArr = @[].mutableCopy;
    if (self.indexPath.row == 0) {
        picsArr = self.contracturlArr;
    }else if (self.indexPath.row == 1) {
        picsArr = self.budgeturlArr;
    }else if (self.indexPath.row == 2) {
        picsArr = self.drawingurlArr;
    }else if (self.indexPath.row == 3) {
        picsArr = self.changetableurlArr;
    }
     
    for (int i = 0 ; i < picsArr.count; i++) {
        if ([picsArr[i] isKindOfClass:[UIImage class]]) {
            dispatch_group_async(group, queue, ^{
                [self upimgWithindex:i withgrop:group];
            });
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       //全部上传成功
//        [SVProgressHUD showSuccessWithStatus:@"上传图片成功"];
        [self.tableView reloadData];
        
    });
}
//上传图片操作
- (void)upimgWithindex:(NSInteger)index withgrop:(dispatch_group_t)group{
    dispatch_group_enter(group);
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = self.imgModel.token;
    NSMutableArray * picsArr = @[].mutableCopy;
       if (self.indexPath.row == 0) {
           picsArr = self.contracturlArr;
       }else if (self.indexPath.row == 1) {
           picsArr = self.budgeturlArr;
       }else if (self.indexPath.row == 2) {
           picsArr = self.drawingurlArr;
       }else if (self.indexPath.row == 3) {
           picsArr = self.changetableurlArr;
       }
    [zkRequestTool NetWorkingUpLoad:QiNiuYunUploadURL image:picsArr[index] andName:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",@"京东卡的风控安徽");
        [picsArr removeObjectAtIndex:index];
        [picsArr insertObject:[NSString stringWithFormat:@"%@",responseObject[@"key"]] atIndex:index];
        dispatch_group_leave(group);
        
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
