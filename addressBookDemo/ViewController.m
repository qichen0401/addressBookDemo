//
//  ViewController.m
//  addressBookDemo
//
//  Created by Qi Chen on 10/9/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "ViewController.h"

#import "AddressBookManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAccess:(id)sender {
    [AddressBookManager requestAccess];
}

- (IBAction)iterateAllRecord:(id)sender {
    [AddressBookManager iterateAllRecordWith:^(ABRecordRef record){
        
        NSLog(@"%@", [AddressBookManager getName:record]);
        
        for (NSArray *test in [AddressBookManager getPhone:record]) {
            for (NSString *testString in test) {
                NSLog(@"%@", testString);
            }
        }
        
        NSLog(@"**********");
    }];
}

- (IBAction)addRecord:(id)sender {
    [AddressBookManager addRecordWithFirstName:@"first" lastName:@"last" phone:@"123456" imageData:UIImagePNGRepresentation([UIImage imageNamed:@"contactImage.png"])];
}



@end
