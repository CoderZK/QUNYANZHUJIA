//
//  QYZJSettingTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/11.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJSettingTVC.h"
#import "QYZJSettingCell.h"
#import "cacheClear.h"
#import "QYZJChangePhoneVC.h"
#import "QYZJChangePasswordVC.h"
#import "QYZJChangePayPasswordOneVC.h"
@interface QYZJSettingTVC ()<zkPickViewDelelgate,TZImagePickerControllerDelegate>
@property(nonatomic,strong)NSArray *leftArr;
@property(nonatomic,copy)NSString *nickName,*phoneStr,*addressStr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)UIImage *img;
@property(nonatomic,strong)QYZJTongYongModel *imgModel;
@end

@implementation QYZJSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftArr = @[@[@"我的头像",@"昵称",@"省市区",@"详细地址"],@[@"换绑手机",@"解绑微信",@"登录密码修改",@"支付密码修改"],@[@"清除缓存"]];
    self.cityArray = @[].mutableCopy;
    [self getCityData];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    [self setFootV];
    [self getImgDict];
}

- (void)getImgDict {
    [zkRequestTool getUpdateImgeModelWithCompleteModel:^(QYZJTongYongModel *model) {
           self.imgModel = model;
       }];
}

- (void)setFootV {
    
    UIView * footV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - 70 - sstatusHeight - 44 - 30, ScreenW, 70)];
    [self.view addSubview:footV];
    footV.backgroundColor = [UIColor whiteColor];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, ScreenW - 40, 45)];
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(outLoginActio:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"backorange"] forState:UIControlStateNormal];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.font = kFont(14);
    [footV addSubview:button];
    
    
    
}

//退出登录
- (void)outLoginActio:(UIButton *)button {
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_app_logoutURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            [zkSignleTool shareTool].session_token = nil;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}

- (void)getCityData {
    
    [zkRequestTool networkingPOST:[QYZJURLDefineTool app_addressURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"key"]] isEqualToString:@"1"]) {
            self.cityArray = [zkPickModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.leftArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        return 80;
    }
    if (indexPath.row == 1 && indexPath.section == 1) {
        if ([zkSignleTool shareTool].isBindWebChat) {
            return 50;
        }else {
            return 0;
        }
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}



- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"view"];
    if (view == nil ) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
        view.clipsToBounds = YES;
        view.backgroundColor = RGB(245, 245, 245);
    }
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QYZJSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text  = self.leftArr[indexPath.section][indexPath.row];
    cell.lineV.hidden = NO;
    cell.rightLB.text = @"";
    if (indexPath.row + 1 == [self.leftArr[indexPath.section] count]) {
        cell.lineV.hidden = YES;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:self.dataModel.head_img]] placeholderImage:[UIImage imageNamed:@"963"] options:SDWebImageRetryFailed];
            cell.headImg.layer.cornerRadius = 25;
            cell.headImg.clipsToBounds = YES;
        }else if (indexPath.row == 1) {
            cell.rightLB.text = self.dataModel.nick_name;
            
        }else if (indexPath.row == 2) {
           cell.rightLB.text = [NSString stringWithFormat:@"%@%@%@",self.dataModel.pro_name,self.dataModel.city_name,self.dataModel.area_name];
        }else {
            cell.rightLB.text = self.dataModel.address;
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1) {
            
        }else if (indexPath.row == 2) {
            
        }else {
            
        }
    }else {
        cell.rightLB.text = [NSString stringWithFormat:@"%0.1fM",[cacheClear folderSizeAtPath]];
    }
    
//    if (((indexPath.row == 3 ||indexPath.row == 1) && indexPath.section == 0) || indexPath.section == 2) {
//        cell.jianTouImgV.hidden = YES;
//    }else {
//       cell.jianTouImgV.hidden = NO;
//    }
    cell.clipsToBounds = YES;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
             [self addPict];
        }else if (indexPath.row == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField*userNameTF = alertController.textFields.firstObject;
                
                 self.dataModel.nick_name = userNameTF.text;
                 [self.tableView reloadData];
                [self editUserInfoWithDict:@{@"nick_name":userNameTF.text}];

                
            }]];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
                
                textField.placeholder=@"请输入昵称";
                
                
                
            }];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }else if (indexPath.row == 2) {
            zkPickView *picker = [[zkPickView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            picker.delegate = self ;
            picker.arrayType = ArerArrayNormal;
            picker.array = self.cityArray;
            picker.selectLb.text = @"请选择地址";
            [picker show];
        }else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入详细地址" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UITextField*userNameTF = alertController.textFields.firstObject;
                
                  self.dataModel.address = userNameTF.text;
                  [self editUserInfoWithDict:@{@"address":userNameTF.text}];
                [self.tableView reloadData];
                
            }]];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField*_Nonnull textField) {
                
                textField.placeholder=@"请输入详细地址";
                
                
            }];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            QYZJChangePhoneVC * vc =[[QYZJChangePhoneVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            
            [self noBindWebChat];
            
        }else if (indexPath.row == 2) {
            QYZJChangePasswordVC * vc =[[QYZJChangePasswordVC alloc] init];
                       vc.hidesBottomBarWhenPushed = YES;
                       [self.navigationController pushViewController:vc animated:YES];
        }else {
            QYZJChangePayPasswordOneVC * vc =[[QYZJChangePayPasswordOneVC alloc] init];
                       vc.hidesBottomBarWhenPushed = YES;
                       [self.navigationController pushViewController:vc animated:YES];
        }
    }else {
        [cacheClear cleanCache:^{
            
            [tableView reloadData];
            
        }];
    }
    
}

- (void)noBindWebChat {
    
    [SVProgressHUD show];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"app_openid"] = @"0";
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"微信解除成功"];
            [zkSignleTool shareTool].isBindWebChat = NO;
            [self.tableView reloadData];
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
                       imagePickerVc.showSelectBtn = NO;
                       imagePickerVc.allowCrop = YES;
                       imagePickerVc.needCircleCrop = NO;
                       imagePickerVc.allowPickingImage = NO;
                       imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
                       imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
                       imagePickerVc.circleCropRadius = ScreenW/2;
                       [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                           if (photos.count > 0) {
                               [self updateImgWithImg:photos[0]];
                           }
                       }];
                       [self presentViewController:imagePickerVc animated:YES completion:nil];
            
//            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
//
//                self.img = image;
//                [self.tableView reloadData];
//            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (photos.count > 0) {
                    [self updateImgWithImg:photos[0]];
                }
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


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    NSLog(@"%@",asset);

//    [PublicFuntionTool getImageFromPHAsset:asset Complete:^(NSData * _Nonnull data, NSString * _Nonnull str) {
//
//
//
//    }];
}

#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    self.dataModel.pro_name = self.cityArray[leftIndex].pname;
    self.dataModel.pro_id = self.cityArray[leftIndex].pid;
    self.dataModel.city_name = self.cityArray[leftIndex].cityList[centerIndex].cname;
    self.dataModel.city_id = self.cityArray[leftIndex].cityList[centerIndex].cid;
    self.dataModel.area_name = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex].name;
    self.dataModel.area_id = self.cityArray[leftIndex].cityList[centerIndex].areaList[rightIndex].ID;
    
    [self editUserInfoWithDict:@{@"pro_id":self.dataModel.pro_id,@"city_id":self.dataModel.city_id,@"area_id":self.dataModel.area_id}];
    [self.tableView reloadData];
    
    
}

- (void )add:(NSInteger )a{
    
}

- (void)updateImgWithImg:(UIImage *)image {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"token"] = self.imgModel.token;
    [zkRequestTool NetWorkingUpLoad:QiNiuYunUploadURL image:image andName:@"file" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        self.dataModel.head_img = responseObject[@"key"];
        [self.tableView reloadData];
        [self editUserInfoWithDict:@{@"head_img":responseObject[@"key"]}];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)editUserInfoWithDict:(NSDictionary*)dict {
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[QYZJURLDefineTool user_editInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {

        [SVProgressHUD dismiss];
        if ([responseObject[@"key"] intValue]== 1) {
            
            
            
        }else {
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
   
        
    }];
    
}


@end
