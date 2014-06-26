//
//  LTUserDefaultSettingStore.m
//  LTUserDefaultSettingStore
//
//  Created by Jiejing Zhang on 14-6-26.
//  Copyright (c) 2014年 LifeTech. All rights reserved.
//

#import "LTUserSetting.h"

@interface LTUserSetting()
{
    NSMutableDictionary *_localCache;
}

@property (nonatomic, strong) NSUserDefaults *currentDefault;
@property (nonatomic, strong) NSMutableDictionary *localCache;

@end

@implementation LTUserSetting

+(id) sharedStore {
    static dispatch_once_t onceToken;
    static LTUserSetting  *setting;
    
    dispatch_once(&onceToken, ^{
        setting = [[LTUserSetting alloc] init];
        setting.currentDefault = [NSUserDefaults standardUserDefaults];
        setting.localCache = [[NSMutableDictionary alloc] init];
    });
    
    return setting;
}

// consider this was a specialized version.
- (NSString *) getStringValue: (NSString *) key {
    @synchronized(self) {
        id cacheValue = [self.localCache objectForKey:key];
        if (cacheValue != nil)
            return cacheValue;
        // if not found, fallback to default, and cahce the value.
        NSString *value = [self.currentDefault stringForKey:key];
        if (value != nil)
            [self.localCache setObject:value forKey:key];
        return value;
    }
}

- (NSInteger) getIntValue: (NSString *) key {
    @synchronized(self) {
        NSNumber *cacheValue = [self.localCache objectForKey:key];
        if (cacheValue != nil)
            return [cacheValue integerValue];
        // if not found, fallback to default, and cahce the value.
        NSNumber *value = [self.currentDefault objectForKey:key];
        if (value != nil)
            [self.localCache setObject:value forKey:key];
        
        NSAssert([value respondsToSelector:@selector(integerValue)], @"mis use");
        
        return [value integerValue];
    }
}

// store key, value in current object.
// but if isStore == NO, don't store to NSDefault, maybe useful in test case.
- (void)  setKey: (NSString *) key value: (id<NSCopying>) value isStore: (BOOL) isStore {
    @synchronized(self) {
        [self.localCache setObject: value forKey:key];
        if (isStore) {
            // yes, the cache needs deep copy.
            [self.currentDefault setObject:[value copyWithZone:NSDefaultMallocZone()] forKey:key];
        }
    }
}

- (void) setKey: (NSString *) key int: (NSInteger) number isStore: (BOOL) isStore {
    @synchronized(self) {
        NSNumber *num = [NSNumber numberWithInteger:number];
        [self.localCache setObject: num forKey: key];
        
        if (isStore) {
            [self.currentDefault setObject: num forKey:key];
        }
    }
}


@end
