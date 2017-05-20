//
//  ViewController.m
//  CrashSafe
//
//  Created by 丁侃 on 2017/5/19.
//  Copyright © 2017年 丁侃. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Safe.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testArray];
//    [self testArrayM];
    
//    [self testDict];
//    [self testDictM];
//    [self testStr];
    [self testNSMutableString];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testArray{
    
    NSString *str = nil;
    NSArray *temp = @[@"1",@"2",str];
    
    [temp objectAtIndex:5];
    [temp subarrayWithRange:NSMakeRange(0, 10)];
    [temp arrayByAddingObject:str];
}

-(void)testArrayM{
    NSString *str = nil;
    NSMutableArray *temp = [NSMutableArray arrayWithObjects:@"1",@"2",str, nil];
    
    [temp setObject:str atIndexedSubscript:1];
    [temp insertObject:str atIndex:5];
    [temp removeObjectAtIndex:5];
    [temp replaceObjectAtIndex:1 withObject:str];
    [temp removeObject:str inRange:NSMakeRange(0, 1)];
    [temp subarrayWithRange:NSMakeRange(8, 9)];
}

-(void)testDict{
    NSString *str = nil;
    NSDictionary *dict = @{
                           @"1":@"a",
                           @"2":str,
                           str:@"1",
                           };
}

-(void)testDictM{
    NSString *str = nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:@[@"a",@"b",@"c"] forKeys:@[@"1",@"2",@"3"]];
    [dict setObject:@"1" forKey:str];
    
    [dict removeObjectForKey:str];
}


-(void)testStr{

    NSString *str = @"Hello world!";
    
    [str characterAtIndex:100];
    [str substringFromIndex:1000];
    [str substringWithRange:NSMakeRange(100, 1)];
    [str substringToIndex:1000];
    NSString *temp = [str stringByReplacingOccurrencesOfString:nil withString:@"1" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
    [str stringByReplacingCharactersInRange:NSMakeRange(0, str.length) withString:nil];
}


-(void)testNSMutableString{
    NSMutableString *temp = [NSMutableString stringWithFormat:@"hello world!"];
    [temp replaceCharactersInRange:NSMakeRange(1000, 100) withString:@"123123"];
    [temp insertString:@"123" atIndex:1000];
    [temp deleteCharactersInRange:NSMakeRange(1000, 10)];
}

@end
