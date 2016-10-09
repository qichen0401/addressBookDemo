//
//  AddressBookManager.h
//  addressBookDemo
//
//  Created by Qi Chen on 10/9/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@import AddressBook;

@protocol AddressBookManagerDelegate <NSObject>

- (void)didRequestAccess:(BOOL)isGranted;

@end

@interface AddressBookManager : NSObject

@property (nonatomic, weak) id <AddressBookManagerDelegate> delegate;

+ (id)sharedManager;
+ (BOOL)isGranted;
+ (void) iterateAllRecordWith:(void (^)(ABRecordRef))block;
+ (NSString*)getName:(ABRecordRef)record;
+ (NSArray*)getPhone:(ABRecordRef)record;
+ (void) addRecordWithFirstName:(NSString*)firstName lastName:(NSString*)lastName phone:(NSString*)phone imageData:(NSData*)imageData;

- (void)requestAccess;

@end
