//
//  DTADataCollection.m
//  DataTaipei
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import "DTADataCollection.h"
#import "DataTaipei.h"

static NSString *const BaseURL = @"http://data.taipei/opendata/datalist/apiAccess?scope=datasetMetadataSearch";

#pragma mark - DTADataCollection

@interface DTADataCollection ()
{
    NSString *_sortKey;
    NSComparisonResult _order;
}

@end

@implementation DTADataCollection

+ (instancetype)defaultInstance
{
    DTADataCollection *collection = [DTADataCollection new];
    
    return [collection autorelease];
}

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    
    [self setLimit:0];
    [self setOffset:0];
    
    return self;
}

- (void)dealloc
{
    [self setSearchKeyword:nil];
    
    [_sortKey release];
    
    [super dealloc];
}

- (void)sortByKey:(NSString * __nonnull)key order:(NSComparisonResult)order
{
    if (_sortKey != nil) {
        [_sortKey release];
    }
    
    _sortKey = [[NSString alloc] initWithString:key];
    _order = order;
}

- (void)queryDataCollectionWithResultBlock:(DTAQueryResultBlock __nullable)result
{
    NSMutableString *URLString = [NSMutableString stringWithString:BaseURL];
    
    if (self.searchKeyword != nil) {
        NSString *encodingString = [self.searchKeyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [URLString appendFormat:@"&q=%@", encodingString];
    }
    
    NSString *orderString = [self _orderString];
    
    if (_sortKey != nil && orderString != nil) {
        [URLString appendFormat:@"&sort=%@ %@", _sortKey, orderString];
    }
    
    if (self.limit > 0) {
        [URLString appendFormat:@"&limit=%tu", self.limit];
    }
    
    if (self.offset > 0) {
        [URLString appendFormat:@"&offset=%tu", self.offset];
    }
    
    void (^completionHandler) (NSURLResponse *response, NSData *data, NSError *connectionError) = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            result(nil, connectionError);
            return;
        }
        
        NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        result(resultString, connectionError);
        [resultString release];
    };
    
    NSURL *queryURL = [NSURL URLWithString:URLString];
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:queryURL];
    
    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:URLRequest queue:operationQueue completionHandler:completionHandler];
}

#pragma mark - Private Method

- (NSString *)_orderString
{
    if (_order == NSOrderedAscending) {
        return @"asce";
    }
    
    if (_order == NSOrderedDescending) {
        return @"desc";
    }
    
    return nil;
}

@end
