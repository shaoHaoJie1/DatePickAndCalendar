//
//  CustomDatePicekView.h
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/2.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomDatePicekView.h"

typedef NS_ENUM(NSInteger,MyDatePickerViewMode) {
    
    MyDatePickerViewDateYearMonthDayHourMinuteSecondMode = 0,//年月日,时分秒
    MyDatePickerViewDateYearMonthDayHourMinuteMode,//年月日,时分
    MyDatePickerViewDateYearMonthDayHourMode,//年月日,时
    MyDatePickerViewDateYearMonthDayMode,//年月日
    MyDatePickerViewDateYearMonthMode,//年月
    MyDatePickerViewDateYearMode,//年
    
};



NS_ASSUME_NONNULL_BEGIN

@interface CustomDatePicekView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)NSString *titleStr;
//时间
@property(nonatomic,copy)NSString *Taketime;





@property (nonatomic,assign) id delegate;

@property(nonatomic,strong)UIPickerView *pickerView;

/**选择模式*/
@property (nonatomic, assign) MyDatePickerViewMode pickerViewMode;
/**
 
 */
-(void)setCurrentDate:(NSDate *)currentDate;
//时间戳
@property (nonatomic,strong) NSString *datestring;


@end



@protocol GZChooseDatePicekDelegate <NSObject>

@optional //@optional和@required 关键字用来告诉别人这个方法是可选还是必须要实现的

-(void)ChooseDatePicekView:(CustomDatePicekView*)alertView;

@end
NS_ASSUME_NONNULL_END

