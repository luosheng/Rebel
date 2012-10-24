//
//  NSWindow+RBLKeyWindowAdditions.m
//  Rebel
//
//  Created by Luo Sheng on 12-10-24.
//  Copyright (c) 2012 GitHub. All rights reserved.
//

#import "NSWindow+RBLKeyWindowAdditions.h"
#import "RBLPopover.h"
#import <objc/runtime.h>

static BOOL (*originalIsKeyWindow)(id, SEL);

static BOOL rbl_isKeyWindow (NSWindow *self, SEL _cmd) {
	__block BOOL isKey = (*originalIsKeyWindow)(self, _cmd);
	if (!isKey) {
		[self.childWindows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			if ([obj isKindOfClass:RBLPopoverWindow.class]) {
				isKey = [NSApp isActive];
				*stop = YES;
			}
		}];
	}
	return isKey;
}

@implementation NSWindow (RBLKeyWindowAdditions)

+ (void)load {
	Method isKeyWindow = class_getInstanceMethod(self, @selector(isKeyWindow));
	originalIsKeyWindow = (BOOL (*)(id, SEL))method_getImplementation(isKeyWindow);
	
	method_setImplementation(isKeyWindow, (IMP)&rbl_isKeyWindow);
}


@end
