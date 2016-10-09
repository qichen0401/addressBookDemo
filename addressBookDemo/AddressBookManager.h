//
//  AddressBookManager.h
//  addressBookDemo
//
//  Created by Qi Chen on 10/9/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AddressBook;

@interface AddressBookManager : NSObject

+ (void)requestAccess;
+ (BOOL)isGranted;
+ (void) iterateAllRecordWith:(void (^)(ABRecordRef))block;
+ (NSString*)getName:(ABRecordRef)record;
+ (NSArray*)getPhone:(ABRecordRef)record;
+ (void) addRecordWithFirstName:(NSString*)firstName lastName:(NSString*)lastName phone:(NSString*)phone imageData:(NSData*)imageData;


// add delegate to notifi authorized done




@end
