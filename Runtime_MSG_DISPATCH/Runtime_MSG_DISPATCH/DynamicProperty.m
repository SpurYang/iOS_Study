//
//  DynamicProperty.m
//  Runtime_MSG_DISPATCH
//
//  Created by SpurYang on 16/3/17.
//  Copyright © 2016年 SpurYang. All rights reserved.
//

#import "DynamicProperty.h"
#import <objc/runtime.h>

@interface DynamicProperty ()

@property(nonatomic,strong)NSMutableDictionary* backingStore;

@end


@implementation DynamicProperty

@dynamic name;


- (id) init{
    if(self = [super init]){
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)selector{
    NSString *selectorString = NSStringFromSelector(selector);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self,selector,(IMP)autoDictionarySetter,"v@:@");
    }else{
        class_addMethod(self, selector, (IMP)autoDictionaryGetter, "@@:");
    }
    
    
    return YES;
}


id autoDictionaryGetter(id self,SEL cmd){
    DynamicProperty* typedSelf = (DynamicProperty*) self;
    
    NSString *key = NSStringFromSelector(cmd);
    
    return [typedSelf.backingStore objectForKey:key];
    
    
}


void autoDictionarySetter(id self,SEL cmd,id value){
    DynamicProperty* typedSelf = (DynamicProperty*)self;
    NSString *selectorString = NSStringFromSelector(cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    [key deleteCharactersInRange:NSMakeRange(key.length - 1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowerCaseKey = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowerCaseKey];
    
    if (value) {
        [typedSelf.backingStore setObject:value forKey:key];
    }else{
        [typedSelf.backingStore removeObjectForKey:key];
    }
    
}

@end
