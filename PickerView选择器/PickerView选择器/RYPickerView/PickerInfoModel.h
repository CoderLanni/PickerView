//
//  PickerInfoModel.h
//  Assistant
//
//  Created by yiheni on 2018/7/11.
//  Copyright © 2018年 yiheni. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickerInfoModel : NSObject

@property (nonatomic,strong)NSString *sex;
@property (nonatomic,strong)NSString *heigh;
@property (nonatomic,strong)NSString *weight;
@property (nonatomic,strong)NSString *birthday;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *rang;
@property (nonatomic,strong)NSString *city;

//首次月经时间
@property (nonatomic,strong)NSString *menstruationFirstTime;
///上次月经时间
@property (nonatomic,strong)NSString *menstruationLastTime;
///多久一次月经
@property (nonatomic,strong)NSString *menstruationEveryTime;
///每次月经时长
@property (nonatomic,strong)NSString *menstruationLongTime;
///生育
@property (nonatomic,strong)NSString *procreate;
///怀孕
@property (nonatomic,strong)NSString *gravid;


@property (nonatomic,assign) NSInteger heightInt;



@end

NS_ASSUME_NONNULL_END
