//
//  TextFieldHandleTests.m
//  TextFieldHandleTests
//
//  Created by Matvey Kravtsov on 06/02/2019.
//  Copyright © 2019 Kravtsov. All rights reserved.
//

@import XCTest;
#import "UITextField+HandleTextInput.h"


@interface TextFieldHandleTests : XCTestCase

@property (nonatomic, strong) UITextField *textField;

@end


@implementation TextFieldHandleTests

- (void)setUp
{
	self.textField = [UITextField new];
}

- (void)tearDown
{
	self.textField = nil;
}

- (void)testPerformanceTrackingDisabled
{
	[self.textField trackingEnable:NO];

	UITextField *textField = self.textField;
	NSRange range = {0,0};
	NSString *string = @"a";
	dispatch_block_t block = [self defaultBlockWithTextField:textField range:range string:string];

	[self measureBlock:block];
}

- (void)testPerformanceTrackingEnabled
{
	[self.textField trackingEnable:YES];

	UITextField *textField = self.textField;
	NSRange range = {0,0};
	NSString *string = @"a";
	dispatch_block_t block = [self defaultBlockWithTextField:textField range:range string:string];

	[self measureBlock:block];
}

- (dispatch_block_t)defaultBlockWithTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string
{
	return ^{
		for (int i = 0; i < 100000; ++i)
		{
			if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
			{
				[textField.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
			}
		}
	};
}

@end
