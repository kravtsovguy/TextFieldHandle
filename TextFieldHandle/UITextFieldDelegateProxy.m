//
//  UITextFieldDelegateProxy.m
//  TextFieldHandle
//
//  Created by Matvey Kravtsov on 06/02/2019.
//  Copyright © 2019 Kravtsov. All rights reserved.
//

#import "UITextFieldDelegateProxy.h"


@interface UITextFieldDelegateProxy ()
{
	dispatch_queue_t _queue;
	SEL _selector;
	BOOL _respondsToSelector;
}

@end


@implementation UITextFieldDelegateProxy

- (instancetype)initWithObject:(id<UITextFieldDelegate>)delegateInstance
{
	_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
	_delegateInstance = delegateInstance;
	_selector = @selector(textField:shouldChangeCharactersInRange:replacementString:);
	_respondsToSelector = [delegateInstance respondsToSelector:_selector];
	
	return self;
}

+ (instancetype)decoratedInstanceOf:(id<UITextFieldDelegate>)delegateInstance
{
	return [[self alloc] initWithObject:delegateInstance];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
	if (!self.delegateInstance)
	{
		return [NSObject methodSignatureForSelector:selector];
	}
	
	return [(id)self.delegateInstance methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
	[invocation invokeWithTarget:self.delegateInstance];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
	if (aSelector == _selector)
	{
		return YES;
	}

	return [self.delegateInstance respondsToSelector:aSelector];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	dispatch_async(_queue, ^{
//		some stuff
//		NSLog(@"handled: %@", NSStringFromSelector(_cmd));
		NSLog(@"\nstring: %@\nrange: %@", string, NSStringFromRange(range));
	});
	
	if (_respondsToSelector)
	{
		return [self.delegateInstance textField:textField shouldChangeCharactersInRange:range replacementString:string];
	}
	
	return YES;
}

@end
