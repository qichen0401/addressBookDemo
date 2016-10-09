//
//  AddressBookManager.m
//  addressBookDemo
//
//  Created by Qi Chen on 10/9/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "AddressBookManager.h"

@implementation AddressBookManager

+ (void)requestAccess {
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSLog(@"authorized");
        }else{
            NSLog(@"denied");
        }
    });
}

+ (BOOL)isGranted {
    switch (ABAddressBookGetAuthorizationStatus()) {
//        case kABAuthorizationStatusNotDetermined:
//            
//        case kABAuthorizationStatusRestricted:
//            
//        case kABAuthorizationStatusDenied:
            
        case kABAuthorizationStatusAuthorized:
            return true;
            
        default:
            return false;
    }
}

+ (void) iterateAllRecordWith:(void (^)(ABRecordRef))block {
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    
    NSArray *allRecords = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    
    for (id r in allRecords){
        ABRecordRef record = (__bridge ABRecordRef)r;
        
        block(record);
    }
    
    CFRelease(addressBookRef);
}

+ (NSString*)getName:(ABRecordRef)record {
    return (__bridge NSString *)(ABRecordCopyCompositeName(record));
}

+ (NSArray*)getPhone:(ABRecordRef)record {
    ABMultiValueRef phoneProperty = ABRecordCopyValue(record, kABPersonPhoneProperty);
    NSMutableArray *phonePropertyArray = [NSMutableArray new];
    for(NSUInteger i = 0; i < ABMultiValueGetCount(phoneProperty); i++) {
        NSString *label =(__bridge_transfer NSString*)ABAddressBookCopyLocalizedLabel( ABMultiValueCopyLabelAtIndex(phoneProperty, i));
        NSString *value = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneProperty, i);
        
        [phonePropertyArray addObject:@[label, value]];
    }
    return phonePropertyArray;
}

+ (void) addRecordWithFirstName:(NSString*)firstName lastName:(NSString*)lastName phone:(NSString*)phone imageData:(NSData*)imageData {
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    ABRecordRef record = ABPersonCreate();
    
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)firstName, nil);
    ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFStringRef)lastName, nil);
    
    ABMutableMultiValueRef phones = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phones, (__bridge CFStringRef)phone, kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(record, kABPersonPhoneProperty, phones, nil);
    
    ABPersonSetImageData(record, (__bridge CFDataRef)imageData, nil);

    ABAddressBookAddRecord(addressBookRef, record, nil);
    
    ABAddressBookSave(addressBookRef, nil);
    
    CFRelease(addressBookRef);
}



@end
