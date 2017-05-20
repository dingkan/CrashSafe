//
//  RuntimeManager.h
//  CrashSafe
//
//  Created by 丁侃 on 2017/5/19.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeManager : NSObject
+(void)methodExChangeAClass:(Class)aclass selector:(SEL)aSelector selector:(SEL)bSelector isClassMethod:(BOOL)methodClass;

@end
