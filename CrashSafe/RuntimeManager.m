//
//  RuntimeManager.m
//  CrashSafe
//
//  Created by 丁侃 on 2017/5/19.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "RuntimeManager.h"
#import <objc/runtime.h>

@implementation RuntimeManager

+(void)methodExChangeAClass:(Class)aclass selector:(SEL)aSelector selector:(SEL)bSelector isClassMethod:(BOOL)methodClass{
 
    Method originalMethod;
    Method finallyMethod;
    
    if (methodClass) {
        originalMethod = class_getClassMethod(aclass, aSelector);
        finallyMethod = class_getClassMethod(aclass, bSelector);
    }else{
        originalMethod = class_getInstanceMethod(aclass, aSelector);
        finallyMethod = class_getInstanceMethod(aclass, bSelector);
    }
    
    BOOL success = class_addMethod(aclass, aSelector, method_getImplementation(finallyMethod), method_getTypeEncoding(finallyMethod));
    
    if (success) {
        class_replaceMethod(aclass, bSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, finallyMethod);
    }
    
}

@end
