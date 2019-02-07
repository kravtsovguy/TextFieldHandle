//
//  ViewController.m
//  TextFieldHandle
//
//  Created by Matvey Kravtsov on 06/02/2019.
//  Copyright © 2019 Kravtsov. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+HandleTextInput.h"


@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, weak, readonly) UITextField *textField;
@property (nonatomic, weak, readonly) UISwitch *switchView;

@end


@implementation ViewController

@synthesize textField = _textField;
@synthesize switchView = _switchView;

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.view.backgroundColor = UIColor.whiteColor;
	[self.view addSubview:self.textField];
	[self.view addSubview:self.switchView];
}

- (UISwitch *)switchView
{
	return _switchView = _switchView ?: ({
		CGFloat width = 50;
		CGFloat height = 50;
		CGFloat x = CGRectGetMidX(self.view.bounds) - width / 2;
		CGFloat y = CGRectGetHeight(self.view.bounds) / 3 + 100;
		UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(x, y, width, height)];
		switchView.on = NO;
		[switchView addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];
		switchView;
	});
}

- (void)switchStateChanged:(UISwitch *)switchView
{
	[self.textField trackingEnable:switchView.isOn];
}

- (UITextField *)textField
{
	return _textField = _textField ?: ({
		CGFloat width = CGRectGetWidth(self.view.bounds);
		CGFloat height = 50;
		CGFloat x = CGRectGetMidX(self.view.bounds) - width / 2;
		CGFloat y = CGRectGetHeight(self.view.bounds) / 3;
		UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x, y, width, height)];
		textField.placeholder = @"Type something";
		textField.textAlignment = NSTextAlignmentCenter;
//		textField.delegate = self;
//		[textField trackingEnable:YES];
		textField;
	});
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSLog(@"original handle input: %@", string);
	return YES;
}


@end
