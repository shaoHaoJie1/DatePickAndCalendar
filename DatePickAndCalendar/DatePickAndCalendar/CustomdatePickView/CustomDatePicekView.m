//
//  CustomDatePicekView.m
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/2.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

#import "CustomDatePicekView.h"

#define BTNWIDTH   [UIScreen mainScreen].bounds.size.width/2
//屏幕尺寸
#define CIO_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define CIO_SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define RGBCOLOR(r,g,b,p) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:p]


@implementation CustomDatePicekView
{
    //时间参数
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    //
    
    long long  TimeStamp;
    
    NSMutableArray *minutesArray;
    NSMutableArray * hoursArray;
    NSString *hours;
    NSString *minutes;
    /*
     * 盖板
     */
    UIButton *viewPandle;
    
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    [self windowframe];
    
    UIView *viewbottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CIO_SCREEN_WIDTH, 40)];
    viewbottom.backgroundColor = RGBCOLOR(245, 245, 245, 1);
    //viewbottom.backgroundColor = [UIColor greenColor];
    [self addSubview:viewbottom];
    
    UIButton *buttonCancle = [[UIButton alloc]initWithFrame:CGRectMake(16,2, 36, 36)];
    [buttonCancle setTitle:@"取消" forState:UIControlStateNormal];
    //buttonCancle.backgroundColor = [UIColor brownColor];
    buttonCancle.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonCancle setTitleColor:RGBCOLOR(102, 102, 102, 1) forState:UIControlStateNormal];
    [buttonCancle addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewbottom addSubview: buttonCancle];
    
    UIButton *buttonSure = [[UIButton alloc]initWithFrame:CGRectMake(CIO_SCREEN_WIDTH-56,2, 36, 36)];
    buttonSure.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonSure setTitleColor:RGBCOLOR(0, 150, 255, 1) forState:UIControlStateNormal];
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    //buttonSure.backgroundColor = [UIColor whiteColor];
    [buttonSure addTarget:self action:@selector(determineClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewbottom addSubview: buttonSure];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CIO_SCREEN_WIDTH/2-75, 2, 150, 36)];
    label.text = self.titleStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    [viewbottom addSubview:label];
    
    //高度 默认值 162
    self.pickerView =[[UIPickerView alloc]init];
    self.pickerView.frame=CGRectMake(0,CGRectGetMaxY(viewbottom.frame), CIO_SCREEN_WIDTH, self.frame.size.height-viewbottom.frame.size.height);
    //设置数据源（返回多少区 多少行）
    self.pickerView.dataSource =self;
    //设置代理
    self.pickerView.delegate =self;
    
    [self addSubview:self.pickerView];
    
    
    NSCalendar *calendar0 = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps  = [calendar0 components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[comps year];
    
    startYear=year-100;
    
    yearRange=200;
    [self.pickerView reloadAllComponents];
    [self setCurrentDate:[NSDate date]];
    
}



#pragma mark- 代理协议方法
//确定每一列返回的东西
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
        {
            return yearRange;
        }
            break;
        case 1:
        {
            return 12;
        }
            break;
        case 2:
        {
            return dayRange;
        }
            break;
        case 3:
        {
            return 24;
        }
            break;
        case 4:
        {
            return 60;
        }
            break;
            
        default:
            break;
    }
    
    return 0;
}

#pragma mark -- UIPickerViewDelegate

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel*label=[[UILabel alloc]init];
    label.font=[UIFont systemFontOfSize:15.0];
    label.textAlignment=NSTextAlignmentCenter;
    
    
    switch (component) {
        case 0:
        {
            label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
        }
            break;
        case 1:
        {
            label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
        }
            break;
        case 2:
        {
            
            label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
        }
            break;
        case 3:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.text=[NSString stringWithFormat:@"%ld时",(long)row];
        }
            break;
        case 4:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.text=[NSString stringWithFormat:@"%ld分",(long)row];
        }
            break;
            
        default:
            break;
    }
    
    return label;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    
    return ([UIScreen mainScreen].bounds.size.width-40)/5;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 30;
}

// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    switch (component) {
        case 0:
        {
            selectedYear=startYear + row;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [self.pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            selectedMonth=row+1;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [self.pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            selectedDay=row+1;
        }
            break;
        case 3:
        {
            selectedHour=row;
        }
            break;
        case 4:
        {
            selectedMinute=row;
        }
            break;
            
        default:
            break;
    }
    
    NSString *str  =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld-%.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
    
    
    
    self.datestring = [self getTimestampFromTime:str];
    
    _Taketime = str;
    
}


#pragma mark 将时间转换成时间戳
- (NSString *)getTimestampFromTime:(NSString *)dateStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd-HH:mm"];// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate *datenow = [formatter dateFromString:dateStr];//现在时间,你可以输出来看下是什么格式
    
    NSString *nowtimeStr = dateStr;//----------将nsdate按formatter格式转成nsstring
    
    NSLog(@"%@", nowtimeStr);
    
    // 时间转时间戳的方法:
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    NSLog(@"timeSp:%@",timeSp);//时间戳的值
    
    return timeSp;
    
}


-(void)windowframe
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    viewPandle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CIO_SCREEN_WIDTH, CIO_SCREEN_HEIGHT)];
    
    viewPandle.backgroundColor = [UIColor clearColor];
    //viewPandle.alpha = 0.3;
    [viewPandle addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    
    self.frame = CGRectMake(0,CIO_SCREEN_HEIGHT*(2/3.0), CIO_SCREEN_WIDTH, CIO_SCREEN_HEIGHT/3.0);
    
    [window addSubview:viewPandle];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [viewPandle addSubview:self];
    
}

-(void)clickcancle
{
    [viewPandle removeFromSuperview];
}

-(void)cancelBtnClick:(UIButton*)btn{
    
    [viewPandle removeFromSuperview];
    //    _Taketime = @"选择时间";
    //    [self.delegate hisPickerView:self];
    
}
-(void)determineClick:(UIButton*)btn{
    
    [self clickcancle];
    
    [self.delegate ChooseDatePicekView:self];
    
}





- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    
    return 5;
}





//默认时间的处理
-(void)setCurrentDate:(NSDate *)currentDate
{
    //获取当前时间
    NSCalendar *calendar0 = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps  = [calendar0 components:unitFlags fromDate:[NSDate date]];
    
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
    NSInteger hour=[comps hour];
    NSInteger minute=[comps minute];
    NSInteger second=[comps second];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
    selectedHour=hour;
    selectedMinute=minute;
    selectedSecond =second;
    
    dayRange=[self isAllDay:year andMonth:month];
    
    [self.pickerView reloadAllComponents];
    
    [self.pickerView selectRow:year-startYear inComponent:0 animated:NO];
    [self.pickerView selectRow:month-1 inComponent:1 animated:NO];
    
    [self.pickerView selectRow:day-1 inComponent:2 animated:NO];
    
    [self.pickerView selectRow:hour inComponent:3 animated:NO];
    [self.pickerView selectRow:minute inComponent:4 animated:NO];
    
    [self pickerView:self.pickerView didSelectRow:year-startYear inComponent:0];
    [self pickerView:self.pickerView didSelectRow:month-1 inComponent:1];
    [self pickerView:self.pickerView didSelectRow:day-1 inComponent:2];
    [self pickerView:self.pickerView didSelectRow:hour inComponent:3];
    [self pickerView:self.pickerView didSelectRow:minute inComponent:4];
    
    [self.pickerView reloadAllComponents];
}

#pragma mark - 选择对应月份的天数
-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}




@end
