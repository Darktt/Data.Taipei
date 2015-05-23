//
//  DTADataCollection.h
//  DataTaipei
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTABlock.h"

NS_ASSUME_NONNULL_BEGIN
@interface DTADataCollection : NSObject

/** The keyword for search specific data collection. */
@property (retain, nonatomic, nullable) NSString *searchKeyword;

@property (assign) NSUInteger limit;
@property (assign) NSUInteger offset;

+ (instancetype)defaultInstance;

/** Sort query data.
 *  key Sorting by this key.
 *  order The sort order, value can be NSOrderedAscending or NSOrderedDescending, will ignore NSOrderedSame setting.
 */
- (void)sortByKey:(NSString *)key order:(NSComparisonResult)order;

- (void)queryDataCollectionWithResultBlock:(DTAQueryResultBlock __nullable)result;

@end
NS_ASSUME_NONNULL_END
