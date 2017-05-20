//
//  NSObject+Safe.m
//  CrashSafe
//
//  Created by 丁侃 on 2017/5/19.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "NSObject+Safe.h"
#import "RuntimeManager.h"
#import <runetype.h>

@implementation NSObject (Safe)

@end

@implementation NSURL (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
           [RuntimeManager methodExChangeAClass:[self class] selector:@selector(initWithString:relativeToURL:) selector:@selector(safe_initWithString:relativeToURL:) isClassMethod:NO];
    });
}

-(nullable instancetype)safe_initWithString:(NSString *)str relativeToURL:(NSURL *)url{
    if (str == nil) {
        str = @"";
    }
    return [self safe_initWithString:str relativeToURL:url];
}

@end


#pragma  mark ------------NSArray-------------------

@implementation NSArray (Safe)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        /**
         NSArray0表示一般空数组，NSArrayI表示一般数组，__NSArrayM可变数组
         */
        [RuntimeManager methodExChangeAClass:[self class] selector:@selector(arrayWithObjects:count:) selector:@selector(safe_arrayWithObjects:count:) isClassMethod:YES];
        
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSPlaceholderArray") selector:@selector(initWithObjects:count:) selector:@selector(safe_initWithObjects:count:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayI") selector:@selector(objectAtIndex:) selector:@selector(safe_objectAtIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayI") selector:@selector(subarrayWithRange:) selector:@selector(safe_subarrayWithRange:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayI") selector:@selector(arrayByAddingObject:) selector:@selector(safe_arrayByAddingObject:) isClassMethod:NO];
        
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSSingleObjectArrayI") selector:@selector(objectAtIndex:) selector:@selector(safe_singleObjectArrayI:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSSingleObjectArrayI") selector:@selector(subarrayWithRange:) selector:@selector(safe_singleSubarrayWithRange:) isClassMethod:NO];
        
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArray0") selector:@selector(objectAtIndex:) selector:@selector(safe_objectAtIndex0:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArray0") selector:@selector(subarrayWithRange:) selector:@selector(safe_subarrayWithRange0:) isClassMethod:NO];
    });
}

-(NSArray *)safe_subarrayWithRange0:(NSRange)range{
    if (range.length + range.location > self.count) {
        NSLog(@"safe_subarrayWithRange:range[%@]",NSStringFromRange(range));
        return self;
    }
    return [self safe_subarrayWithRange0:range];
}

-(id)safe_objectAtIndex0:(NSUInteger)index{
    if (index > self.count) {
        NSLog(@"safe_objectAtIndex atIndex:[%@] out of bound:[%@]",@(index),@(self.count));
        return nil;
    }
    return [self safe_objectAtIndex0:index];
}

-(NSArray *)safe_singleSubarrayWithRange:(NSRange)range{
    if (range.length + range.location > self.count) {
        NSLog(@"safe_subarrayWithRange:range[%@]",NSStringFromRange(range));
        return self;
    }
    return [self safe_singleSubarrayWithRange:range];
}

-(id)safe_singleObjectArrayI:(NSUInteger)index{
    if (index > self.count) {
        NSLog(@"safe_objectAtIndex atIndex:[%@] out of bound:[%@]",@(index),@(self.count));
        return nil;
    }
    return [self safe_singleObjectArrayI:index];
}

-(NSArray *)safe_arrayByAddingObject:(id)anObject{
    if (!anObject) {
        NSLog(@"safe_arrayByAddingObject");
        return self;
    }
    return [self safe_arrayByAddingObject:anObject];
}

-(NSArray *)safe_subarrayWithRange:(NSRange)range{
    if (range.location + range.length > self.count) {
        NSLog(@"safe_subarrayWithRange:range[%@]",NSStringFromRange(range));
        return self;
    }
    return [self safe_subarrayWithRange:range];
}

-(id)safe_objectAtIndex:(NSUInteger)index{
    if (index >= self.count) {
        NSLog(@"safe_objectAtIndex atIndex:[%@] out of bound:[%@]", @(index), @(self.count));
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

+ (instancetype)safe_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt {
    
    NSInteger index = 0;
    id objs[cnt];
    for (NSInteger i = 0; i < cnt ; ++i) {
        if (objects[i]) {
            objs[index++] = objects[i];
        }
    }
    return [self safe_arrayWithObjects:objs count:index];
}

-(instancetype)safe_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    NSInteger index = 0;
    id objs[cnt];
    for (NSInteger i = 0; i < cnt; i ++) {
        if (objects[i]) {
            objs[index++] = objects[i];
        }
    }
    return [self safe_initWithObjects:objs count:index];
}

@end

#pragma  mark ------------NSMutableArray-------------------


@implementation NSMutableArray(safe)
+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayM") selector:@selector(setObject:atIndexedSubscript:) selector:@selector(safe_setObject:atIndexedSubscript:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayM") selector:@selector(insertObject:atIndex:) selector:@selector(safe_insertObject:atIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayM") selector:@selector(removeObjectAtIndex:) selector:@selector(safe_removeObjectAtIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayM") selector:@selector(replaceObjectAtIndex:withObject:) selector:@selector(safe_replaceObjectAtIndex:withObject:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayM") selector:@selector(removeObject:inRange:) selector:@selector(safe_removeObject:inRange:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSArrayM") selector:@selector(subarrayWithRange:) selector:@selector(safe_subarrayWithRange:) isClassMethod:NO];
    });
}

-(NSArray *)safe_subarrayWithRange:(NSRange)range{
    if (range.length + range.location > self.count) {
        NSLog(@"safe_subarrayWithRange:range[%@]",NSStringFromRange(range));
        return self;
    }
    return [self safe_subarrayWithRange:range];
}

-(void)safe_removeObject:(id)anObject inRange:(NSRange)range{
    if (range.length + range.location > self.count) {
        NSLog(@"safe_subarrayWithRange:range[%@]",NSStringFromRange(range));
        return;
    }
    
    if (!anObject) {
        NSLog(@"safe_insertObject:[objc is nil] inRanfe:[%@]",NSStringFromRange(range));
        return;
    }
    
    return [self safe_removeObject:anObject inRange:range];
}

-(void)safe_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (index > self.count) {
        NSLog(@"safe_removeObjectAtIndex:[%@] out of bound:[%@]",@(index),@(self.count));
        return;
    }
    if (!anObject) {
        NSLog(@"safe_insertObject:[objc is nil] atIndex:[%@]",@(index));
        return;
    }
    
    return [self safe_replaceObjectAtIndex:index withObject:anObject];
}

-(void)safe_removeObjectAtIndex:(NSUInteger)index{
    if (index > self.count) {
        NSLog(@"safe_removeObjectAtIndex:[%@] out of bound:[%@]",@(index),@(self.count));
        return;
    }
    
    return [self safe_removeObjectAtIndex:index];
}

-(void)safe_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (index > self.count) {
        NSLog(@"safe_insertObject:[%@] out of bound:[%@]",anObject,@(index));
        return;
    }
    
    if (!anObject) {
        NSLog(@"safe_insertObject:[objc is nil] atIndex:[%@]",@(index));
        return;
    }
    return [self safe_insertObject:anObject atIndex:index];
}

-(void)safe_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx{
    if (idx >= self.count) {
        NSLog(@"safe_setObject:[%@] out of bound[%@]",@(idx),@(self.count));
        return;
    }
    
    if (!obj) {
        NSLog(@"safe_setObject:[obj is nil] atIndexedSubscript:[%@]",@(idx));
        return;
    }
    return [self safe_setObject:obj atIndexedSubscript:idx];
}



@end


#pragma  mark -------------NSDictionary------------------

@implementation NSDictionary (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSPlaceholderDictionary") selector:@selector(initWithObjects:forKeys:count:) selector:@selector(safe_initWithObjects:forKeys:count:) isClassMethod:NO];
    });
}

-(instancetype)safe_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    NSUInteger count = cnt;
    
    id newObjcs[cnt];
    id newKeys[cnt];
    NSUInteger newCnt = 0;
    
    for (NSInteger i = 0 ; i < count; i ++) {
        if (objects[i] && keys[i]) {
            newObjcs[newCnt] = objects[i];
            newKeys[newCnt] = keys[i];
            newCnt ++;
        }
        
        if (!objects[i]) {
            NSLog(@"safe_initWithObjects:[objs contain nil] forKeys:[the key = %@] ",keys[i]);
        }
        
        if (!keys[i]) {
            NSLog(@"safe_initWithObjects:[the objs = %@] forKeys:[keys contain nil] ",objects[i]);
        }
    }
    
    return [self safe_initWithObjects:newObjcs forKeys:newKeys count:newCnt];
}

@end


#pragma  mark ------------NSMutableDictionary-------------------

@implementation NSMutableDictionary (Safe)

+(void)load{
    [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSDictionaryM") selector:@selector(setObject:forKey:) selector:@selector(safe_setObject:forKey:) isClassMethod:NO];
    [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSDictionaryM") selector:@selector(removeObjectForKey:) selector:@selector(safe_removeObjectForKey:) isClassMethod:NO];
}

-(void)safe_removeObjectForKey:(id)aKey{
    if (!aKey) {
        NSLog(@"safe_removeObjectForKey:[the key is nil]");
        return;
    }
    return [self safe_removeObjectForKey:aKey];
}

-(void)safe_setObject:(id)anObject forKey:(id<NSCopying>)aKey{
    if (!aKey) {
        NSLog(@"safe_setObject:[%@] forKey:[the key is nil]",anObject);
        return;
    }
    
    if (!anObject) {
        NSLog(@"safe_setObject:[the objc is nil] forKey:[%@]",aKey);
        return;
    }
    return [self safe_setObject:anObject forKey:aKey];
}

@end


#pragma  mark ------------NSString-------------------

@implementation NSString (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFConstantString") selector:@selector(characterAtIndex:) selector:@selector(safe_characterAtIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFConstantString") selector:@selector(substringFromIndex:) selector:@selector(safe_substringFromIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFConstantString") selector:@selector(substringToIndex:) selector:@selector(safe_substringToIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFConstantString") selector:@selector(substringWithRange:) selector:@selector(safe_substringWithRange:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFConstantString") selector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) selector:@selector(safe_stringByReplacingOccurrencesOfString:withString:options:range:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFConstantString") selector:@selector(stringByReplacingCharactersInRange:withString:) selector:@selector(safe_stringByReplacingCharactersInRange:withString:) isClassMethod:NO];
    });
}

-(NSString *)safe_substringToIndex:(NSUInteger)to{
    if (to > self.length) {
        NSLog(@"safe_substringToIndex:[%@] out of bound:[%@]",@(to),@(self.length));
        return nil;
    }
    return [self safe_substringToIndex:to];
}

-(NSString *)safe_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement{
    if (range.length + range.location > self.length) {
        NSLog(@"safe_stringByReplacingCharactersInRange: withString: options: range:[%@]",NSStringFromRange(range));
        return nil;
    }
    if (!replacement) {
        NSLog(@"stringByReplacingOccurrencesOfString: replacement is nil");
        return  nil;
    }
    return [self safe_stringByReplacingCharactersInRange:range withString:replacement];
}

-(NSString *)safe_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange{
    
    if (searchRange.length + searchRange.location > self.length) {
        NSLog(@"stringByReplacingOccurrencesOfString: withString: options: range:[%@]",NSStringFromRange(searchRange));
        return nil;
    }
    
    if (!target) {
        NSLog(@"stringByReplacingOccurrencesOfString: target is nil");
        return  nil;
    }
    
    if (!replacement) {
        NSLog(@"stringByReplacingOccurrencesOfString: replacement is nil");
        return  nil;
    }
    
    return [self safe_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}

-(NSString *)safe_substringWithRange:(NSRange)range{
    if (range.length + range.location > self.length) {
        NSLog(@"safe_substringWithRange:[%@]",NSStringFromRange(range));
        return nil;
    }
    return [self safe_substringWithRange:range];
}

-(NSString *)safe_substringFromIndex:(NSUInteger)from{
    if (from > self.length) {
        NSLog(@"safe_substringFromIndex:[%@] out of bound:[%@]",@(from),@(self.length));
        return nil;
    }
    return [self substringFromIndex:from];
}

-(unichar)safe_characterAtIndex:(NSUInteger)index{
    if (index > self.length) {
        NSLog(@"safe_characterAtIndex:[%@] out of bound:[%@]",@(index),@(self.length));
        return 0;
    }
    return [self safe_characterAtIndex:index];
}

@end

#pragma  mark ------------NSMutableString-------------------


@implementation NSMutableString (Safe)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFString") selector:@selector(replaceCharactersInRange:withString:) selector:@selector(safe_replaceCharactersInRange:withString:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFString") selector:@selector(insertString:atIndex:) selector:@selector(safe_insertString:atIndex:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"__NSCFString") selector:@selector(deleteCharactersInRange:) selector:@selector(safe_deleteCharactersInRange:) isClassMethod:NO];
    });
    
    
}

-(void)safe_deleteCharactersInRange:(NSRange)range{
    if (range.length + range.location > self.length) {
        NSLog(@"safe_deleteCharactersInRange:[%@]",NSStringFromRange(range));
        return;
    }
    return [self safe_deleteCharactersInRange:range];
}

-(void)safe_insertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (loc > self.length) {
        NSLog(@"safe_insertString:atIndex:index out of bound:[%@]",@(self.length));
        return;
    }
    if (!aString) {
        NSLog(@"safe_insertString:string is nil");
        return;
    }
    return [self safe_insertString:aString atIndex:loc];
}

-(void)safe_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString{
    if (range.length + range.location > self.length) {
        NSLog(@"safe_replaceCharactersInRange:[%@]",NSStringFromRange(range));
        return;
    }
    
    if (!aString) {
        NSLog(@"safe_replaceCharactersInRange: withString:string is nil");
        return;
    }
    return [self safe_replaceCharactersInRange:range withString:aString];
}

@end


#pragma  mark ------------NSAttributeString-------------------

@implementation NSAttributedString (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"NSConcreteAttributedString") selector:@selector(initWithString:) selector:@selector(safe_initWithString:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"NSConcreteAttributedString") selector:@selector(initWithAttributedString:) selector:@selector(safe_initWithAttributedString:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"NSConcreteAttributedString") selector:@selector(initWithString:attributes:) selector:@selector(safe_initWithString:attributes:) isClassMethod:NO];
    });
}

-(instancetype)safe_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs{
    if (!str) {
        NSLog(@"safe_initWithString: str is nil attributes:");
        return nil;
    }
    
    if (!attrs) {
        NSLog(@"safe_initWithString:attributes:attrs is nil");
        return nil;
    }
    
    return [self safe_initWithString:str attributes:attrs];
}

-(instancetype)safe_initWithAttributedString:(NSAttributedString *)attrStr{
    if (!attrStr) {
        NSLog(@"safe_initWithAttributedString: attrStr is nil");
        return nil;
    }
    return [self safe_initWithAttributedString:attrStr];
}

-(instancetype)safe_initWithString:(NSString *)str{
    if (!str) {
        NSLog(@"safe_initWithString:string is nil");
        return nil;;
    }
    return [self safe_initWithString:str];
}

@end


#pragma  mark ------------NSMutableAttributeString-------------------

@implementation NSMutableAttributedString (Safe)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"NSConcreteMutableAttributedString") selector:@selector(initWithString:) selector:@selector(safe_initWithStringM:) isClassMethod:NO];
        [RuntimeManager methodExChangeAClass:NSClassFromString(@"NSConcreteMutableAttributedString") selector:@selector(initWithString:attributes:) selector:@selector(safe_initWithStringM:attributes:) isClassMethod:NO];
    });
}

-(instancetype)safe_initWithStringM:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs{
    if (!str) {
        NSLog(@"safe_initWithStringM: str is nil attributes:");
        return nil;
    }
    
    if (!attrs) {
        NSLog(@"safe_initWithStringM:attributes:attrs is nil");
        return nil;
    }
    return [self safe_initWithStringM:str attributes:attrs];
}

-(instancetype)safe_initWithStringM:(NSString *)str{
    if (!str) {
        NSLog(@"safe_initWithStringM: str is nil");
        return nil;
    }
    
    return [self safe_initWithStringM:str];
}



@end











