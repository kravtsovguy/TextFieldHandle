//
//  UITextFieldDelegateProxy.h
//  TextFieldHandle
//
//  Created by Matvey Kravtsov on 06/02/2019.
//  Copyright © 2019 Kravtsov. All rights reserved.
//

@import UIKit;


NS_ASSUME_NONNULL_BEGIN


@interface UITextFieldDelegateProxy : NSProxy <UITextFieldDelegate>

@property (nonatomic, weak, readonly) id<UITextFieldDelegate> delegateInstance;

+ (instancetype)decoratedInstanceOf:(nullable id<UITextFieldDelegate>)delegateInstance;

@end


NS_ASSUME_NONNULL_END
