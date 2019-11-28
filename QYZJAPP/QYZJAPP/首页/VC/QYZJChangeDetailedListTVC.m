//
//  QYZJChangeDetailedListTVC.m
//  QYZJAPP
//
//  Created by zk on 2019/11/19.
//  Copyright © 2019 kunzhang. All rights reserved.
//

#import "QYZJChangeDetailedListTVC.h"

@interface QYZJChangeDetailedListTVC ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *picsArr;
@property(nonatomic,strong)UIView *whiteOneV;
@property(nonatomic,strong)NSArray *leftTitleArr,*placeHolderArr;
@end

@implementation QYZJChangeDetailedListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createHeadV];
    self.picsArr = @[].mutableCopy;
    [self addPicsWithArr:self.picsArr];
    self.navigationItem.title = @"添加变更清单";
    [self addFootV];
    [self.tableView registerClass:[TongYongTwoCell class] forCellReuseIdentifier:@"cell"];
    self.leftTitleArr = @[@"施工阶段",@"施工金额",@"工期",@"时间段"];
    self.placeHolderArr = @[@"请输入施工阶段",@"请输入金额",@"请输入工期",@"请选择时间段"];
    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
}

- (void)addFootV {
    
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 60);
       if (sstatusHeight > 20) {
           self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH  - 60 - 34);
       }
       
       KKKKFootView * view = [[PublicFuntionTool shareTool] createFootvWithTitle:@"提交" andImgaeName:@""];
        Weak(weakSelf);
           view.footViewClickBlock = ^(UIButton *button) {
                    NSLog(@"\n\n%@",@"完成");
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

- (void)createHeadV {
    
    CGFloat ww = 90;
    self.headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ww+40 + 20)];
    UIView * backV1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    backV1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headV addSubview:backV1];
    self.whiteOneV = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenW, ww+40)];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.whiteOneV.frame) , ScreenW, 10)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.whiteOneV addSubview:backV];
    self.whiteOneV.backgroundColor = WhiteColor;
    
    
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, self.whiteOneV.frame.size.height-20)];
    lb3.textColor = CharacterBlack112;
    lb3.font = kFont(14);
    lb3.text = @"变更单";
    [self.whiteOneV addSubview:lb3];
    [self.headV addSubview:self.whiteOneV];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 10, ScreenW-110, ww+20)];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.whiteOneV addSubview:self.scrollView];
    
    [self.headV addSubview:self.whiteOneV];
    self.headV.backgroundColor = WhiteColor;
    self.tableView.tableHeaderView = self.headV;
    
}

- (void)addPicsWithArr:(NSMutableArray *)picsArr {

    CGFloat space = 20;
    CGFloat ww = 90;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.contentSize = CGSizeMake((picsArr.count + 1) * (ww+space), ww+10);
    for (int i = 0 ; i < picsArr.count + 1; i++) {
        
        UIButton * anNiuBt = [[UIButton alloc] initWithFrame:CGRectMake((ww +  space) * i , 10, ww, ww)];
        anNiuBt.layer.cornerRadius = 3;
        anNiuBt.tag = 100+i;
        anNiuBt.clipsToBounds = YES;
        [anNiuBt addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:anNiuBt];
        
        if (i == picsArr.count) {
            
            [anNiuBt setBackgroundImage:[UIImage imageNamed:@"tianjia"] forState:UIControlStateNormal];
            
        }else {
            UIButton * deleteBt = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(anNiuBt.frame) - 10 ,0 , 20, 20)];
            [deleteBt setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
            deleteBt.tag = 100+i;
            [deleteBt addTarget:self action:@selector(deleteHitAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:deleteBt];
             if ([picsArr[i] isKindOfClass:[NSString class]]) {
                            [anNiuBt sd_setBackgroundImageWithURL:[NSURL URLWithString:[QYZJURLDefineTool getImgURLWithStr:picsArr[i]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
                       }else {
                            [anNiuBt setBackgroundImage:picsArr[i] forState:UIControlStateNormal];
                       }
            
        }
        
        
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    TongYongTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.rightLB.hidden =cell.moreImgV.hidden =  YES;
    cell.TF.userInteractionEnabled = NO;
    if (indexPath.row == 2) {
        cell.TF.userInteractionEnabled = YES;
    }else if (indexPath.row == 0 || indexPath.row == 3) {
        cell.moreImgV.hidden= NO;
    }
    cell.leftLB.text = self.leftTitleArr[indexPath.row];
    cell.TF.placeholder = self.placeHolderArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark ---- 添加阶段 ----
- (void)addJieDuan {
    
}

- (void)deleteHitAction:(UIButton *)button {
    [self.picsArr removeObjectAtIndex:button.tag - 100];
}

- (void)hitAction:(UIButton *)button {
    
    if (button.tag == self.picsArr.count + 100) {
        //添加图片
        [self addPict];
    }else {
        [[zkPhotoShowVC alloc] initWithArray:self.picsArr index:button.tag - 100];
        
    }
}

- (void)addPict {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.picsArr addObject:image];
                
                
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:MAXFLOAT columnNumber:4 delegate:self pushPhotoPickerVc:YES];
            imagePickerVc.allowPickingVideo = YES;
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = NO;
            imagePickerVc.cropRectPortrait = CGRectMake(0, (ScreenH - ScreenW)/2, ScreenW, ScreenW);
            imagePickerVc.cropRectLandscape = CGRectMake(0, (ScreenW - ScreenH)/2, ScreenH, ScreenH);
            imagePickerVc.circleCropRadius = ScreenW/2;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                
                [self.picsArr addObjectsFromArray:photos];
                
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




@end
