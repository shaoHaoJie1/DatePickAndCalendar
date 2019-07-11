//
//  UIButton+ChickBlock.h
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/11.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^chickTouchBlock)(void);

@interface UIButton (ChickBlock)


@property(nonatomic,strong)chickTouchBlock onechickBlock;

/**
 给按钮添加回调点击事件

 @param events 响应事件类型
 @param chickBlock 回调block
 */
-(void)addShjWithControlEvens:(UIControlEvents)events ChickBlock:(chickTouchBlock)chickBlock;

@end

NS_ASSUME_NONNULL_END
