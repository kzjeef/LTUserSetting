//
//  LTUserDefaultSettingStoreTests.m
//  LTUserDefaultSettingStoreTests
//
//  Created by Jiejing Zhang on 14-6-26.
//  Copyright (c) 2014年 LifeTech. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LTUserSetting.h"

@interface LTUserDefaultSettingStoreTests : XCTestCase

@end

@implementation LTUserDefaultSettingStoreTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSetAndGet
{
   LTUserSetting *setting = [LTUserSetting sharedStore];
    
    NSString *str = @"some value";
    NSString *strcpy = [str copy];
    [setting setKey:@"testKey" value:str isStore:NO];
    str = @"some other value";
    XCTAssert(![str isEqualToString:[setting getStringValue:@"testKey"]], @"should copy the value");
    
    NSLog(@"fetched value: %@", [setting getStringValue:@"testKey"]);
    XCTAssert([strcpy isEqualToString:[setting getStringValue:@"testKey"]], @"should get corrent value");
    
    NSNumber *num = @1;
    NSNumber *numcpy = [num copy];
    
    [setting setKey:@"testNum" value:num isStore:YES];
    
    num = @2;
    
    XCTAssert(numcpy.integerValue == [setting getIntValue:@"testNum"], "should equal");
    XCTAssert(num.integerValue != [setting getIntValue:@"testNum"], "should not equal");
    
    NSNumber *n2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"testNum"];

    XCTAssert(n2.integerValue == numcpy.integerValue, @"should equal");
}

@end
