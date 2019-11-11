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
@interface QYZJSettingTVC ()<zkPickViewDelelgate>
@property(nonatomic,strong)NSArray *leftArr;
@property(nonatomic,copy)NSString *nickName,*phoneStr,*addressStr;
@property(nonatomic,strong)NSMutableArray<zkPickModel *> *cityArray;
@property(nonatomic,strong)UIImage *img;

@end

@implementation QYZJSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    [self.tableView registerNib:[UINib nibWithNibName:@"QYZJSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftArr = @[@[@"我的头像",@"昵称",@"省市区",@"详细地址"],@[@"换绑手机",@"绑定微信",@"登录密码修改",@"支付密码修改"],@[@"清除缓存"]];
    self.cityArray = @[].mutableCopy;
    [self getCityData];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    [self setFootV];
    
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
           
        }else if (indexPath.row == 1) {
            
            cell.rightLB.text = self.nickName;
            
        }else if (indexPath.row == 2) {
        
        }else {
            cell.rightLB.text = self.addressStr;
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
    
    if (((indexPath.row == 3 ||indexPath.row == 1) && indexPath.section == 0) || indexPath.section == 2) {
        cell.jianTouImgV.hidden = YES;
    }else {
       cell.jianTouImgV.hidden = NO;
    }
    
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
                
                self.nickName = userNameTF.text;
                 [self.tableView reloadData];
                
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
                
                self.addressStr = userNameTF.text;
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

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                self.img = image;
                [self.tableView reloadData];
            }];
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
                    self.img = photos[0];
                }
                [self.tableView reloadData];
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


#pragma mark ------- 点击筛选 ------
- (void)didSelectLeftIndex:(NSInteger)leftIndex centerIndex:(NSInteger)centerIndex rightIndex:(NSInteger )rightIndex{
    
    NSLog(@"%d---%d----%d",leftIndex,centerIndex,rightIndex);
    
    
}


@end
