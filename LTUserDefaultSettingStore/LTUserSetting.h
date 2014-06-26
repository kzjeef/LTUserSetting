//
//  LTUserDefaultSettingStore.h
//  LTUserDefaultSettingStore
//
//  Created by Jiejing Zhang on 14-6-26.
//  Copyright (c) 2014 LifeTech. All rights reserved.
//

#import <Foundation/Foundation.h>

// This lib was intent to use NSDefault as setting store,
// which provide default setup function and get and set function for thoese settings.
@interface LTUserSetting : NSObject

+ (id) sharedStore;

- (NSString *) getStringValue: (NSString *) key;

- (NSInteger) getIntValue: (NSString *) key;

// store key, value in current object.
// but if isStore == NO, don't store to NSDefault, maybe useful in test case.
- (void)  setKey: (NSString *) key value: (id<NSCopying>) value isStore: (BOOL) isStore;

- (void) setKey: (NSString *) key int: (NSInteger) number isStore: (BOOL) isStore;

@end
