//
//  ViewController.m
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/2.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

#import "ViewController.h"

#import "DatePickViewController.h"

@interface ViewController ()




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titlearray =  @[@"datePick",@"CustomdatePick",@"calendar"];
    
    
    for (int i = 0; i<3; i++) {
        
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(100, 100*i+100, 150, 32)];
        
        [btn setTitle:titlearray[i] forState:0];
        
        btn.tag = i+1000;
        
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setBackgroundColor:[UIColor brownColor]];
        [btn addTarget:self action:@selector(chicBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }
    
    
    
}

-(void)chicBtn:(UIButton *)btn{

    
    
    switch (btn.tag) {
        case 1000:{
            
            DatePickViewController *date = [[DatePickViewController alloc]init];
          
            [self.navigationController pushViewController:date animated:YES];
            
         
       
        }
        break;
            
        case 1001:
            
        break;
            
        case 1002:
            
        break;
            
        default:
            
        break;
    }
    
}


@end
