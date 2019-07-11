//
//  CustomdatePickViewController.m
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/2.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

#import "CustomdatePickViewController.h"

#import "CustomDatePicekView.h"

#import "UIButton+ChickBlock.h"

@interface CustomdatePickViewController ()



@property(nonatomic,strong)UIButton *chooseTimer;



@end

@implementation CustomdatePickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CustomdatePick";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.chooseTimer = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 50)];
    
    self.chooseTimer.backgroundColor = [UIColor orangeColor];
    
    [self.chooseTimer setTitle:@"选择时间" forState:0];
    
    [self.view addSubview:self.chooseTimer];
    
 // [self.chooseTimer addTarget:self action:@selector(chickTimerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseTimer addShjWithControlEvens:UIControlEventTouchUpInside ChickBlock:^{
        
        NSLog(@"测试");
    }];
    
   
    
    
}

-(void)chickTimerBtn{
  NSLog(@"测试");
    
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
