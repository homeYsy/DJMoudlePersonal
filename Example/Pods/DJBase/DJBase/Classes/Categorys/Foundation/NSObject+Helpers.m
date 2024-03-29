//
//  NSObject+Helpers.m
//  DJBase
//
//  Created by CSS on 2019/5/31.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "NSObject+Helpers.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (Helpers)

- (void)performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay {
    [self performSelector:sel withObject:nil afterDelay:delay];
}

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

- (void)setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

- (id)getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

+ (BOOL)isEmpty:(_Nullable id)obj{
    if (obj == nil || [obj isEqual:[NSNull null]] || [obj isKindOfClass:[NSNull class]]) {
        return YES;
    }else if ([obj isKindOfClass:[NSString class]]) {
        if ([@"" isEqualToString:obj]) {
            return YES;
        }
        return NO;
    }else if ([obj isKindOfClass:[NSArray class]]) {
        if (((NSArray *)obj).count == 0) {
            return YES;
        }
        return NO;
    }else if ([obj isKindOfClass:[NSDictionary class]]) {
        if (((NSDictionary *)obj).count == 0) {
            return YES;
        }
    }else if ([obj isKindOfClass:[NSSet class]]) {
        if (((NSSet *)obj).count == 0) {
            return YES;
        }
    }
    return NO;
}

@end
