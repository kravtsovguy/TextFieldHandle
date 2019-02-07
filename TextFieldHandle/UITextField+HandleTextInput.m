//
//  UITextField+HandleTextInput.m
//  TextFieldHandle
//
//  Created by Matvey Kravtsov on 06/02/2019.
//  Copyright © 2019 Kravtsov. All rights reserved.
//

#import "UITextField+HandleTextInput.h"
#import "UITextFieldDelegateProxy.h"
@import ObjectiveC.runtime;


@interface UITextField (HandleTextInput_Private)

@property (nonatomic, strong, nullable) UITextFieldDelegateProxy *decoratedDelegate;

@end


@implementation UITextField (HandleTextInput_Private)

@dynamic decoratedDelegate;

- (UITextFieldDelegateProxy *)decoratedDelegate
{
	return objc_getAssociatedObject(self, @selector(decoratedDelegate));
}

- (void)setDecoratedDelegate:(UITextFieldDelegateProxy *)decoratedDelegate
{
	objc_setAssociatedObject(self, @selector(decoratedDelegate), decoratedDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UITextField (HandleTextInput)

- (void)trackingEnable:(BOOL)enable
{
	BOOL wasEnabled = self.decoratedDelegate != nil;
	if (enable == wasEnabled)
	{
		return;
	}
	
	id<UITextFieldDelegate> delegate;
	
	if (enable)
	{
		NSLog(@"tracking enabled");
		delegate = self.delegate;
	}
	else
	{
		NSLog(@"tracking disabled");
		delegate = self.decoratedDelegate.delegateInstance;
		self.decoratedDelegate = nil;
	}
	
	Class class = [self class];
	
	SEL originalSelector = @selector(setDelegate:);
	SEL swizzledSelector = @selector(hti_setDelegate:);
	
	Method originalMethod = class_getInstanceMethod(class, originalSelector);
	Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
	
	method_exchangeImplementations(originalMethod, swizzledMethod);
	
	self.delegate = delegate;
}


#pragma mark - Method Swizzling

- (void)hti_setDelegate:(id<UITextFieldDelegate>)delegate
{
//	NSLog(@"handled: %@", NSStringFromSelector(_cmd));
	
	self.decoratedDelegate = [UITextFieldDelegateProxy decoratedInstanceOf:delegate];
	[self hti_setDelegate:self.decoratedDelegate];
}

@end
