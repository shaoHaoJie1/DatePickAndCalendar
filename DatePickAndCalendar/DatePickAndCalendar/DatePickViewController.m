//
//  DatePickViewController.m
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/2.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

/** 1、屏幕的宽高 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#import "DatePickViewController.h"

@interface DatePickViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *DateField;

@property(nonatomic,strong)UIDatePicker *datePicker;


@end

@implementation DatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"DatePick";
    
    self.DateField = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH-40, 40)];
    self.DateField.placeholder = @"请选择时间";
    self.DateField.delegate = self;
    [self.view addSubview:self.DateField];
   
    UILabel *datepicjModel = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH-40, 30)];
    
    datepicjModel.textColor = [UIColor blackColor];
    
    datepicjModel.adjustsFontSizeToFitWidth = YES;
    
    datepicjModel.text = @"UIDatePicker datePickerMode的4️⃣中样式";
    
    [self.view addSubview:datepicjModel];
    
    NSArray *datePickerMode = @[@"UIDatePickerModeTime",@"UIDatePickerModeDate",@"UIDatePickerModeDateAndTime",@"UIDatePickerModeCountDownTimer"];
    
    for (int i = 0; i<4; i++) {
        
        CGFloat x = 0;
        
        CGFloat y = 0;
        
        CGFloat with = 150;
        
        CGFloat height = 50;
        if (i == 0 || i == 1) {
            
            x = 50+(160*i);
            
            y = 200;
        }
        if (i == 2 || i == 3) {
            
            x = 50+(160*i)-320;
            
            y = 260;
        }
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, with, height)];
        btn.backgroundColor = [UIColor blueColor];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.layer.cornerRadius = 25;
        
        btn.clipsToBounds = YES;
        [btn setTitle:datePickerMode[i] forState:0];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [self.view addSubview:btn];
        btn.tag = i;
        btn.titleLabel.numberOfLines = 0;
        [btn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    [self setDatePicker];
    
    [self.DateField becomeFirstResponder];
}

-(void)chickBtn:(UIButton *)btn{
    
    
    
   
    self.datePicker.datePickerMode = btn.tag;
    
    
    
}

#pragma mark 初始化 DatePicker
-(void)setDatePicker{
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置地区: zh-中国
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //设置日期模式(Displays month, day, and year depending on the locale setting)
    datePicker.datePickerMode = UIDatePickerModeDate;
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
   
     // 设置显示最小时间
    datePicker.minimumDate = [self gettimeStr:@"19000101000000"];
    
     // 设置显示最大时间
    
    datePicker.maximumDate = [self gettimeStr:@"20990101000000"];
   
    //监听DataPicker的滚动
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
   
    self.datePicker = datePicker;
    
    //设置时间输入框的键盘框样式为时间选择器
    self.DateField.inputView = datePicker;
  
}

- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式
    formatter.dateFormat = @"yyyy MM dd HH:mm";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    
    self.DateField.text = dateStr;
}

//禁止用户输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

//将时间字符串转化为NSdate

-(NSDate *)gettimeStr:(NSString *)timerstr{
    
    //时间字符串
    NSString *str = timerstr;
    //规定时间格式
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    //设置时区  全球标准时间CUT 必须设置 我们要设置中国的时区
    NSTimeZone *zone = [[NSTimeZone alloc] initWithName:@"CUT"];
                        [formatter setTimeZone:zone];
                        //变回日期格式
                        NSDate *stringDate = [formatter dateFromString:str];
    
    
    return stringDate;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.DateField resignFirstResponder];
    
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
