//
//  UIButton+ChickBlock.m
//  DatePickAndCalendar
//
//  Created by 邵浩杰 on 2019/7/11.
//  Copyright © 2019 邵浩杰. All rights reserved.
//

#import "UIButton+ChickBlock.h"

#import <objc/runtime.h>


@implementation UIButton (ChickBlock)

static chickTouchBlock _onechickBlock;

-(chickTouchBlock)onechickBlock{
    
    
    return objc_getAssociatedObject(self, &_onechickBlock);
}

-(void)setOnechickBlock:(chickTouchBlock)onechickBlock{
    
    
    objc_setAssociatedObject(self, &_onechickBlock, onechickBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


-(void)addShjWithControlEvens:(UIControlEvents)events ChickBlock:(chickTouchBlock)chickBlock{
    
    [self setOnechickBlock:chickBlock];
    
    [self addTarget:self action:@selector(chickBtn) forControlEvents:events];
    
}

-(void)chickBtn{
    
    if (self.onechickBlock) {
        
        self.onechickBlock();
    }
    
}


@end
