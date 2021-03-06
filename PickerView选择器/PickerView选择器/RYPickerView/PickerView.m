//
//  PickerView.m
//  Assistant
//
//  Created by yiheni on 2018/7/11.
//  Copyright © 2018年 yiheni. All rights reserved.
//

#import "PickerView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)

//RGB
#define RGB(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define WScale ([UIScreen mainScreen].bounds.size.width) / 375

#define HScale ([UIScreen mainScreen].bounds.size.height) / 667


#define KFont [UIFont systemFontOfSize:15]


@interface PickerView ()
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIButton *completeBtn;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,assign) NSInteger firstSelectIndex;
@property (nonatomic,assign) NSInteger secondSelectIndex;
@property (nonatomic,assign) NSInteger thirdSelectIndex;

@end



@implementation PickerView

- (UIPickerView *)picker{
    
    if (!_picker) {
        
        _picker = [[UIPickerView alloc]init];
      
        _picker.delegate = self;
        
        _picker.dataSource = self;
    }
    
    return _picker;
}

- (UIDatePicker *)datePicke{
    
    if (!_datePicke) {
        
        _datePicke = [UIDatePicker new];
    }
    
    return _datePicke;
}

- (NSMutableArray *)array{
    if (!_array) {
        
        _array = [NSMutableArray array];
        
    }
    
    return _array;
}
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self initUI];
        
    }
    
    return self;
}


- (void)initUI{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.frame = [UIScreen mainScreen].bounds;
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, KScreenWidth, 280*HScale)];
    [self addSubview:_bgView];
    _bgView.tag = 100;
     _bgView.backgroundColor = [UIColor whiteColor];
     [self showAnimation];
    
    
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.cancelBtn.titleLabel.font = KFont;
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:RGB(30, 144, 255, 1) forState:UIControlStateNormal];
    
    //清除
    self.cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.cleanBtn];
    [self.cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.cleanBtn.titleLabel.font = KFont;
    [self.cleanBtn setTitle:@"清除" forState:UIControlStateNormal];
    [self.cleanBtn addTarget:self action:@selector(cleanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cleanBtn setTitleColor:RGB(30, 144, 255, 1) forState:UIControlStateNormal];
    
    
    
    //完成
    self.completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(44);
        
    }];
    self.completeBtn.titleLabel.font = KFont;
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.completeBtn setTitleColor:RGB(30, 144, 255, 1) forState:UIControlStateNormal];
    
    //不确定
    self.noSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView addSubview:self.noSureBtn];
    [self.noSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.equalTo(self.completeBtn.mas_left).with.offset(-15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(44);
        
    }];
    self.noSureBtn.titleLabel.font = KFont;
    [self.noSureBtn setTitle:@"不确定" forState:UIControlStateNormal];
    [self.noSureBtn addTarget:self action:@selector(noSureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.noSureBtn setTitleColor:RGB(30, 144, 255, 1) forState:UIControlStateNormal];
     self.noSureBtn.hidden = YES;

    
    WS(ws);
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.textColor = RGB(51, 51, 51, 1);
    self.titleLab.font = KFont;
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.bgView.mas_centerX);
        make.centerY.mas_equalTo(self.completeBtn.mas_centerY);
    }];


    self.line = [[UIView alloc]init];
 
    [self.bgView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.width.mas_equalTo(KScreenWidth);
        make.height.mas_equalTo(0.5);
        
    }];
    self.line.backgroundColor = RGB(224, 224, 224, 1);
    
   

    
}







#pragma mark type
- (void)setType:(PickerViewType)type{
    
    _type = type;
    
    switch (type) {
        case PickerViewTypeSex:{
            
            self.titleLab.text = @"选择性别";
            [self sexData];
            [self isDataPicker:NO];
        }
            break;
        case PickerViewTypeHeigh:{
            self.titleLab.text = @"选择身高";
            [self heightData];
            [self isDataPicker:NO];
             [self.picker selectRow:70 inComponent:0 animated:NO];
        }
            break;
        case PickerViewTypeWeight:
        {
            self.titleLab.text = @"选择体重";
            [self weightData];
            [self isDataPicker:NO];
            [self.picker selectRow:20 inComponent:0 animated:NO];
        }
            break;
        case PickerViewTypeBirthday:
        {
            self.titleLab.text = @"选择出生年月";
            
           [self isDataPicker:YES];
            self.datePicke.datePickerMode = UIDatePickerModeDate;
            NSLocale *ch_zh_locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"] ;
            [self.datePicke setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];//设置时区，上海时区
            self.datePicke.locale = ch_zh_locale; //设置中文显示
            [self.datePicke setMinimumDate:[PickerView distanceYear:-19]];
            [self.datePicke setMaximumDate:[PickerView distanceYear:100]];
            
        }
            break;
        case PickerViewTypeTime:
        {
            self.titleLab.text = @"选择时间";
            [self isDataPicker:YES];
           self.datePicke.datePickerMode = UIDatePickerModeTime;
        }
            break;
        case PickerViewTypeRange:{
             self.titleLab.text = @"选择区间";
            [self formatterRangeAry];
           [self isDataPicker:NO];
        
        }
            break;
        case PickerViewTypeCity:{
             self.titleLab.text = @"选择城市";
            [self formatterCity];
            [self isDataPicker:NO];

        }
            break;
        case PickerViewTypeMenstruationDuration:{
            self.titleLab.text = @"选择月经时长";
            [self  menstruationDurationData];
            [self isDataPicker:NO];
            [self.picker selectRow:5 inComponent:0 animated:NO];
        }
             break;
        case PickerViewTypeMenstruationCycle:{
            self.titleLab.text = @"选择月经周期";
            [self  menstruationCycleData];
            [self isDataPicker:NO];
            [self.picker selectRow:5 inComponent:0 animated:NO];
        }
            break;
        case PickerViewTypeProcreateCount:{
            self.titleLab.text = @"选择生育次数";
            [self  procreateCountData];
            [self isDataPicker:NO];
        }
            break;
        case PickerViewTypGravidCount:{
            self.titleLab.text = @"选择怀孕次数";
            [self  gravidCountData];
            [self isDataPicker:NO];
        }
            break;
            
        case PickerViewTypeHalfAyear:{
            self.titleLab.text = @"选择日期";
            [self isDataPicker:NO];
        }
            break;
        default:
            break;
    }
    
    
    
    
    
}

- (void)setSelectComponent:(NSInteger)selectComponent{
    _selectComponent = selectComponent;
     [self.picker selectRow:selectComponent inComponent:0 animated:NO];
   
}
-(void)setTitleStr:(NSString *)titleStr{
    
    if (titleStr) {
        self.titleLab.text = titleStr;
    }
}
- (void)setRightBtnTypeStatus:(NSInteger)rightBtnTypeStatus{
    if (rightBtnTypeStatus == 1) {
        self.noSureBtn.hidden = NO;
    }
    else{
        self.noSureBtn.hidden = YES;
    }
}
- (void)setLeftBtnTypeStatus:(NSInteger)leftBtnTypeStatus{
    if (leftBtnTypeStatus == 1) {
        self.cleanBtn.hidden = NO;
        self.cancelBtn.hidden = YES;
    }
    else{
        self.cleanBtn.hidden = YES;
        self.cancelBtn.hidden = NO;
    }
}

- (void)isDataPicker:(BOOL)isData{
    
    WS(ws);
    
    if (isData) {
        
        [_bgView addSubview:self.datePicke];
        
        [self.datePicke mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
       
        
    }else{
        
        [_bgView addSubview:self.picker];
        
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ws.line.mas_bottom).offset(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
        
    }
    
    
}




#pragma mark Click

- (void)cleanBtnClick{
    
//    if (_returnCleanBtnBlock) {
//        _returnCleanBtnBlock();
//    }
      [self hideAnimation];
    NSString *resultStr = @"";
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:result:withFirstIndex:withSecondIndex:withThirdIndex:)]) {
        [_delegate pickerView:self result:resultStr withFirstIndex:self.firstSelectIndex withSecondIndex:self.secondSelectIndex withThirdIndex:self.thirdSelectIndex];
    }
    [self hideAnimation];
    
}
- (void)noSureBtnClick:(UIButton*)sender{
    
    if (_returnNoSureBtnBlock) {
        _returnNoSureBtnBlock();
    }
      [self hideAnimation];
    
}
- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}

-(void)completeBtnClick{
    
    [self hideAnimation];
     NSString *resultStr = [NSString string];
    
    if (self.type == PickerViewTypeBirthday) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        resultStr = [formatter stringFromDate:self.datePicke.date];

    }else if (self.type == PickerViewTypeTime){
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        resultStr = [formatter stringFromDate:self.datePicke.date];
        
    }else if (self.type==PickerViewTypeRange || self.type==PickerViewTypeCity){
        
        PickerModel *model = self.array[self.selectIndex];
        NSInteger cityIndex = [self.picker selectedRowInComponent:1];
        NSString *cityName = model.cities[cityIndex];
        resultStr = [NSString stringWithFormat:@"%@-%@",model.province,cityName];
        resultStr = [self handleCityWithCity:resultStr];
    }
    
    else{
        
        for (int i = 0; i < self.array.count; i++) {
            
            NSArray *arr = [self.array objectAtIndex:i];
            NSString *str = [arr objectAtIndex:[self.picker selectedRowInComponent:i]];
            
            resultStr = [resultStr stringByAppendingString:str];
        }
        
    }
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(pickerView:result:withFirstIndex:withSecondIndex:withThirdIndex:)]) {
        [_delegate pickerView:self result:resultStr withFirstIndex:self.firstSelectIndex withSecondIndex:self.secondSelectIndex withThirdIndex:self.thirdSelectIndex];
    }
    
    
}

#pragma mark 模拟数据
- (void)sexData{
    
    [self.array addObject:@[@"男",@"女"]];
   
}

- (void)heightData{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 100; i <= 250; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
    
}

- (void)weightData{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 30; i <= 150; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
}

- (void)menstruationDurationData{
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"不规律"];
    for (int i = 1; i <= 30; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d天",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
}

- (void)menstruationCycleData{
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"不规律"];
    for (int i = 1; i <= 100; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d天",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
}

/**
 生育次数
 */
- (void)procreateCountData{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i <= 10; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d次",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
}

/**
 怀孕
 */
- (void)gravidCountData{
    
    NSMutableArray *arr = [NSMutableArray array];
//    [arr addObject:@"不规律"];
    for (int i = 0; i <= 30; i++) {
        
        NSString *str = [NSString stringWithFormat:@"%d次",i];
        [arr addObject:str];
    }
    [self.array addObject:(NSArray *)arr];
}


#pragma mark event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.anyObject;
    
    if (touch.view.tag !=100) {
        
        [self hideAnimation];
    }
    
    
    
}

- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height-260*HScale;
        self.bgView.frame = frame;
    }];
    
}

- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgView.frame;
        frame.origin.y = self.frame.size.height;
        self.bgView.frame = frame;
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


#pragma mark-----UIPickerViewDataSource
//列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerVie{
    
    if (self.type == PickerViewTypeRange || self.type==PickerViewTypeCity) {
        
        return 2;
    }
    
    return self.array.count;
}
//指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.type==PickerViewTypeRange || self.type==PickerViewTypeCity) {
        
        if (component==0) {
            return self.array.count;
        }else{
            PickerModel *model = self.array[self.selectIndex];
            return model.cities.count;
            
        }
        
    }
    
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    return arr.count;
}

/*
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label=[[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component];

    return label;
    
}
 */
//指定列和列表项的标题文本
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (self.type == PickerViewTypeRange || self.type==PickerViewTypeCity) {
        
        if (component==0) {
            PickerModel *model = self.array[row];
            
            return model.province;
            
        }else{
             PickerModel *model = self.array[self.selectIndex];
            return model.cities[row];
            
        }
        
    }
    
    
    
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0) {
        
        if (self.type == PickerViewTypeRange || self.type==PickerViewTypeCity) {
            self.selectIndex = [pickerView selectedRowInComponent:0];
            
            [pickerView reloadComponent:1];
        }

        
    }
    
    if (component == 0) {
        self.firstSelectIndex = row;
    }
    else if (component == 1) {
        self.secondSelectIndex = row;
    }
    else if (component == 2) {
        self.thirdSelectIndex = row;
    }
    
}




- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(self.type) {
        case PickerViewTypeHalfAyear: return 300;
        default: return 110;;
    }
    
    //NOT REACHED
    return 110;
}

//防止崩溃
- (NSUInteger)indexOfNSArray:(NSArray *)arr WithStr:(NSString *)str{
    
    NSUInteger chosenDxInt = 0;
    if (str && ![str isEqualToString:@""]) {
        chosenDxInt = [arr indexOfObject:str];
        if (chosenDxInt == NSNotFound)
            chosenDxInt = 0;
    }
    return chosenDxInt;
}


#pragma mark tool
+ (NSDate *)distanceYear:(int)year{
    
    NSDate * mydate = [NSDate date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    
    [adcomps setYear:year];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    
    
    return newdate;
}


- (void)formatterCity{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"City.plist" ofType:nil];
    NSArray *plistAray = [NSArray arrayWithContentsOfFile:path];

    
    for (int i=0; i<plistAray.count; i++) {
        
        PickerModel *model = [[PickerModel alloc] init];
        
        NSDictionary *dict = plistAray[i];
        model.province = dict.allKeys[0];
        model.cities = [dict objectForKey:model.province];
        
        [self.array addObject:model];
        
        
    }
    
}



- (void)formatterRangeAry{
    
    NSMutableArray *rang = [self.array mutableCopy];
    
    [self.array removeAllObjects];
    
    for (int i=0; i<rang.count-1; i++) {
        
        PickerModel *model = [[PickerModel alloc] init];
        
        model.province = rang[i];
        
        NSMutableArray *cityAry = [NSMutableArray array];
        
        for (int m=i+1; m<rang.count; m++) {
            [cityAry addObject:rang[m]];
        }
        
        model.cities  = cityAry;
        
        [self.array addObject:model];
        
    }
    
    
    
}
//处理省份和城市名相同
- (NSString *)handleCityWithCity:(NSString *)result{
    
  NSArray *cityAry = [result componentsSeparatedByString:@"-"];
    
    if ([cityAry[0] isEqualToString:cityAry[1]]) {
        return cityAry[0];
    }else{
        
        return result;
    }
    
    
}

@end
