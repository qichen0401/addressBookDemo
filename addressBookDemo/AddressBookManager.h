//
//  AddressBookManager.h
//  addressBookDemo
//
//  Created by Qi Chen on 10/9/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookManager : NSObject

+ (id)sharedManager;

- (void)requestAccess;

@end
