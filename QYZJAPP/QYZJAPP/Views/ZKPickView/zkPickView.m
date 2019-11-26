//
//  zkPickView.m
//  QYZJAPP
//
//  Created by zk on 2019/11/5.
//  Copyright © 2019 kunzhang. All rights reserved.
//


//屏幕宽和高
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667
//字体大小
#define kfont 15

#import "zkPickView.h"
#import "zkPickModel.h"
@interface zkPickView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgV;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *conpleteBtn;
@property (nonatomic,strong)UIPickerView *pickerV;
@property (nonatomic,strong) UIView* line ;

/**
 *  选中的省份对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithProvince;
/**
 *  选中的市级对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithCity;
/**
 *  选中的县级对应的下标
 */
@property (nonatomic,assign)NSInteger      selectRowWithTown;

@end

@implementation zkPickView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //        self.array = [NSMutableArray array];
        self.selectRowWithProvince = self.selectRowWithCity = self.selectRowWithTown = 0;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = RGBA(51, 51, 51, 0.2);
        self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260*hScale)];
        self.bgV.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.bgV];
        
        [self showAnimation];
        //取消
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.cancelBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(44);
            
        }];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitleColor:[UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
        //完成
        self.conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgV addSubview:self.conpleteBtn];
        [self.conpleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(44);
            
        }];
        self.conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
        [self.conpleteBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.conpleteBtn setTitleColor:[UIColor colorWithRed:1.00f green:0.59f blue:0.00f alpha:1.00f] forState:UIControlStateNormal];
        
        //选择titi
        self.selectLb = [UILabel new];
        [self.bgV addSubview:self.selectLb];
        [self.selectLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(self.bgV.mas_centerX).offset(0);
            make.centerY.mas_equalTo(self.conpleteBtn.mas_centerY).offset(0);
            
        }];
        self.selectLb.font = [UIFont systemFontOfSize:kfont];
        self.selectLb.textAlignment = NSTextAlignmentCenter;
        
        //线
        UIView *line = [UIView new];
        [self.bgV addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(0.5);
            
        }];
        line.backgroundColor = RGBA(224, 224, 224, 1);
        self.line = line ;
        
        self.pickerV = [UIPickerView new];
        [self.bgV addSubview:self.pickerV];
        [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_line.mas_bottom);
            make.bottom.mas_equalTo(self.bgV);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        self.pickerV.delegate = self;
        self.pickerV.dataSource = self;
        
        
    }
    return self;
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = RGBA(51, 51, 51, 0.8);
        CGRect frame = self.bgV.frame;
        frame.origin.y = ScreenHeight-260*hScale;
        self.bgV.frame = frame;
    }];
    
}

- (void)setArray:(NSMutableArray *)array {
    _array = array;
    if (array.count == 0) {
        return;
    }
    if (array.count != 0) {
        [self.pickerV reloadAllComponents];
    }
    
}

- (void)diss {
    [self hideAnimation];
}

#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (self.arrayType == AreaArray ||  self.arrayType == ArerArrayNormal) {
        return  3 ;
    }else{
        return 1;
    }
    
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.arrayType == AreaArray || self.arrayType == ArerArrayNormal) {
        
        zkPickModel *province=self.array[self.selectRowWithProvince];
        zkPickModel *city=province.cityList[self.selectRowWithCity];
        if (component==0) return self.array.count;
        if (component==1) return province.cityList.count;
        if (component==2) {
            if (self.arrayType == AreaArray) {
                return city.areaList.count + 1;
            }else {
                return city.areaList.count;
            }
           
        }
        return 0;
    }
    else{
        
        return self.array.count;
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.arrayType == AreaArray || self.arrayType == ArerArrayNormal) {
        if (component==0) {                    // 只有点击了第一列才去刷新第二个列对应的数据
            self.selectRowWithProvince=row;   //  刷新的下标
            self.selectRowWithCity=0;
            [pickerView reloadComponent:1];  //   刷新第一,二列
            [pickerView reloadComponent:2];
        }
        else if(component==1){
            self.selectRowWithCity=row;       //  选中的市级的下标
            [pickerView reloadComponent:2];  //   刷新第三列
        }
        else if(component==2){
            self.selectRowWithTown=row;
        }
        
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.arrayType == AreaArray || self.arrayType == ArerArrayNormal) {
        NSString *showTitleValue=@"";
        if (component==0){
            zkPickModel *province=self.array[row];
            showTitleValue=province.pname;
        }
        if (component==1){
            zkPickModel *province=self.array[self.selectRowWithProvince];
            zkPickModel *city=province.cityList[row];
            showTitleValue=city.cname;
        }
        if (component==2) {
            
            zkPickModel *province=self.array[self.selectRowWithProvince];
            zkPickModel *city=province.cityList[self.selectRowWithCity];
            
            if (self.arrayType == AreaArray) {
                zkPickModel * model = [[zkPickModel alloc] init];
                model.ID = @"0";
                model.name = @"不限";
                NSMutableArray<zkPickModel *> * ddd = [city.areaList mutableCopy];
                [ddd insertObject:model atIndex:0];
                showTitleValue =  ddd[row].name;
            }else {
                zkPickModel * model = city.areaList[row];
                 showTitleValue = model.name;
            }
            
          
            
        }
        return showTitleValue;
        
    }else{
        
        if (self.arrayType == titleArray) {
            
            return [NSString stringWithFormat:@"%@",self.array[row]];;
        }else {
            zkPickModel * model = self.array[row];
            return model.name;
        }
        
    }
    
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    if ( self.arrayType == AreaArray || self.arrayType == ArerArrayNormal) {
        
        return (ScreenWidth - 30)/3.0;
        
    }else{
        
        return (ScreenWidth - 30);
    }
    
}



//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = ScreenHeight;
        self.bgV.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self.bgV removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}
//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = ScreenHeight-260*hScale;
        self.bgV.frame = frame;
    }];
    
}


#pragma mark-----点击方法

- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

- (void)completeBtnClick{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectLeftIndex:centerIndex:rightIndex:)]) {
        [self.delegate didSelectLeftIndex:self.selectRowWithProvince centerIndex:self.selectRowWithCity rightIndex:self.selectRowWithTown];
    }
    
    
    [self hideAnimation];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}



@end
