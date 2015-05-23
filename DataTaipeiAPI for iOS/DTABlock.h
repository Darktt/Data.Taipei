//
//  DTABlock.h
//  DataTaipei
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DTAQueryResultBlock) (NSString *__nullable resultString, NSError *__nullable error);
typedef void (^DTADownloadResultBlock) (BOOL success, NSError *__nullable error);

NS_ASSUME_NONNULL_END