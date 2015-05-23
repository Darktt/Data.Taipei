//
//  DTADataResource.h
//  DataTaipei
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTABlock.h"

NS_ASSUME_NONNULL_BEGIN
extern NSString *DTAResponsFormatJson;
extern NSString *DTAResponsFormatXml;
extern NSString *DTAResponsFormatCSV;

@interface DTADataResource : NSObject

/// The format for response data, default is DTAResponsFormatJson.
@property (retain, nonatomic) NSString *responseFormat;

@property (assign) NSUInteger limit;
@property (assign) NSUInteger offset;

+ (instancetype)defaultInstance;

- (void)queryResourceDataWithResultBlock:(DTAQueryResultBlock __nullable)result;
- (void)downloadResourceDataForSavePath:(NSString *)savePath  withResult:(DTADownloadResultBlock __nullable)result;
- (void)downloadResourceDataForSaveURL:(NSURL *)saveURL  withResult:(DTADownloadResultBlock __nullable)result;

@end
NS_ASSUME_NONNULL_END
