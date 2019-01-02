//
//  PickerView.h
//  Assistant
//
//  Created by yiheni on 2018/7/11.
//  Copyright © 2018年 yiheni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "PickerModel.h"
typedef NS_ENUM(NSInteger, PickerViewType) {
PickerViewTypeSex,//性别
PickerViewTypeHeigh,//身高
PickerViewTypeWeight,//体重
PickerViewTypeBirthday,//出生年月
PickerViewTypeTime,//时分秒
PickerViewTypeRange,//区间范围比如筛选
PickerViewTypeCity,//城市
PickerViewTypeHalfAyear,//半年日期
PickerViewTypeMenstruationDuration,//月经时长
PickerViewTypeMenstruationCycle,//月经周期
PickerViewTypeProcreateCount,//生育次数
PickerViewTypGravidCount,//怀孕次数
};


@protocol PickerViewResultDelegate <NSObject>
@optional
- (void)pickerView:(UIView *)pickerView result:(NSString *)string withFirstIndex:(NSInteger)firstIndex withSecondIndex:(NSInteger)secondIndex withThirdIndex:(NSInteger)thirdIndex;
@end



@interface PickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *picker;
@property (nonatomic,strong)UIDatePicker *datePicke;
@property(nonatomic,assign)PickerViewType type;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic ,strong) NSString *titleStr;

//默认选中第一列
@property (nonatomic,assign)NSInteger selectComponent;


@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *cleanBtn;
@property(nonatomic,strong)UIButton *noSureBtn;
@property(nonatomic ,copy)void (^returnNoSureBtnBlock)(void);

///左按钮的类型 0:取消  1:清除
@property (nonatomic,assign) NSInteger leftBtnTypeStatus;


///右按钮的类型 0:完成  1:不确定&&完成
@property (nonatomic,assign) NSInteger rightBtnTypeStatus;



@property(nonatomic,weak)id<PickerViewResultDelegate>delegate;
@end
