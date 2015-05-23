//
//  DTADataResource.m
//  DataTaipei
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import "DTADataResource.h"
#import "DataTaipei.h"

#pragma mark - DataTaipei Category

@interface DataTaipei (Private)

@property (readonly, nonatomic) NSString *_RIDKey;

+ (instancetype)_shareData;

@end

#pragma mark - DTADataResource

NSString *DTAResponsFormatJson = @"json";
NSString *DTAResponsFormatXml = @"xml";
NSString *DTAResponsFormatCSV = @"csv";

static NSString *const BaseURL = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=";

@interface DTADataResource ()

@end

@implementation DTADataResource

+ (instancetype)defaultInstance
{
    DTADataResource *resource = [DTADataResource new];
    
    return resource;
}

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    
    [self setResponseFormat:DTAResponsFormatJson];
    [self setLimit:0];
    [self setOffset:0];
    
    return self;
}

- (void)queryResourceDataWithResultBlock:(DTAQueryResultBlock __nullable)result
{
    void (^completionHandler) (NSURLResponse *response, NSData *data, NSError *connectionError) = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            result(nil, connectionError);
            return;
        }
        
        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        result(resultString, connectionError);
        [resultString release];
    };
    
    NSURLRequest *URLRequest = [self _URLRequest];
    
    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:URLRequest queue:operationQueue completionHandler:completionHandler];
}

- (void)downloadResourceDataForSavePath:(NSString * __nonnull)savePath withResult:(DTADownloadResultBlock __nullable)result
{
    void (^completionHandler) (NSURLResponse *response, NSData *data, NSError *connectionError) = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            result(NO, connectionError);
            return;
        }
        
        BOOL success = [data writeToFile:savePath atomically:YES];
        
        result(success, connectionError);
    };
    
    NSURLRequest *URLRequest = [self _URLRequest];
    
    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:URLRequest queue:operationQueue completionHandler:completionHandler];
}

- (void)downloadResourceDataForSaveURL:(NSURL * __nonnull)saveURL withResult:(DTADownloadResultBlock __nullable)result
{
    NSAssert([saveURL isFileURL], @"Save URL format error, is not file URL.");
    
    NSString *savePath = [saveURL path];
    
    [self downloadResourceDataForSavePath:savePath withResult:result];
}

#pragma mark - Private Method

- (NSURLRequest *)_URLRequest
{
    NSString *RIDKey = [[DataTaipei _shareData] _RIDKey];
    
    NSAssert(RIDKey != nil, @"RID not set, please use -setRIDKey: in DataTaipei class set the RID key.");
    
    NSMutableString *URLString = [NSMutableString stringWithFormat:@"%@%@", BaseURL, RIDKey];
    
    if (![self.responseFormat isEqualToString:DTAResponsFormatJson]) {
        [URLString appendFormat:@"&format=%@", self.responseFormat];
    }
    
    if (self.limit > 0) {
        [URLString appendFormat:@"&limit=%tu", self.limit];
    }
    
    if (self.offset > 0) {
        [URLString appendFormat:@"&offset=%tu", self.offset];
    }
    
    NSURL *queryURL = [NSURL URLWithString:URLString];
    
    return [NSURLRequest requestWithURL:queryURL];
}

@end
