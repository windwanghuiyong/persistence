//
//  ViewController.m
//  Persistence
//
//  Created by wanghuiyong on 27/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;

@end

@implementation ViewController

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [self dataFilePath];
    NSLog(@"View Did Load, file at: %@", filePath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // 读取文件到标签
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        for (int i = 0; i < 4; i++) {
            UITextField *theField = self.lineFields[i];
            theField.text = array[i];
        }
        NSLog(@"display");
    } else {
        NSLog(@"file not exists");
    }
    // 应用在进入后台前保存数据
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)applicationWillResignActive: (NSNotification *) notification {
    // 从标签中读取数据到文件
    NSString *filePath = [self dataFilePath];
    NSArray *array = [self.lineFields valueForKey:@"text"];	// 迭代
    [array writeToFile:filePath atomically:YES];
    NSLog(@"Will Resign Active");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
