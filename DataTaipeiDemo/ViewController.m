//
//  ViewController.m
//  DataTaipeiDemo
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import "ViewController.h"
#import "DataTaipei.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /// MARK : Uncomment under thoes code to test.
//    [self queryDataCollectionWithKeyword:<#keyword#>];
//    [self queryDataResource];
//    [self saveDataResourceToFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)queryDataCollectionWithKeyword:(NSString *)keyword
{
    DTAQueryResultBlock resultBlock = ^(NSString *resultString, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            
            return;
        }
        
        NSLog(@"%@", resultString);
    };
    
    DTADataCollection *dataCollection = [DTADataCollection defaultInstance];
    [dataCollection setSearchKeyword:keyword];
    [dataCollection queryDataCollectionWithResultBlock:resultBlock];
}

- (void)queryDataResource
{
    DTAQueryResultBlock resultBlock = ^(NSString *resultString, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            
            return;
        }
        
        NSLog(@"%@", resultString);
    };
    
    DTADataResource *dataResouce = [DTADataResource defaultInstance];
    [dataResouce queryResourceDataWithResultBlock:resultBlock];
}

- (void)saveDataResourceToFile
{
    NSString *savePath = [self documentPathWithFileName:@"saveFile.json"];
    
    DTADownloadResultBlock resultBlock = ^(BOOL success, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", error);
            
            return;
        }
        
        NSLog(@"Save Path: %@", savePath);
    };
    
    DTADataResource *dataResouce = [DTADataResource defaultInstance];
    [dataResouce downloadResourceDataForSavePath:savePath withResult:resultBlock];
}

- (NSString *)documentPathWithFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentPath = [paths objectAtIndex:0];
    
    return [documentPath stringByAppendingPathComponent:fileName];
}

@end
