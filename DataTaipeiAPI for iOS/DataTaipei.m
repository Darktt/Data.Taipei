//
//  DataTaipei.m
//  DataTaipei
//
//  Created by Darktt on 15/05/23.
//  Copyright (c) 2015 Darktt. All rights reserved.
//

#import "DataTaipei.h"

static DataTaipei *singletion = nil;

@interface DataTaipei ()

@property (retain, nonatomic) NSString *_RIDKey;

+ (instancetype)_shareData;

@end

@implementation DataTaipei

+ (void)load
{
    [DataTaipei _shareData];
}

+ (void)setRIDKey:(NSString * __nonnull)RIDKey
{
    DataTaipei *dataTaipei = [DataTaipei _shareData];
    [dataTaipei set_RIDKey:RIDKey];
}

+ (instancetype)_shareData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletion = [DataTaipei new];
    });
    
    return singletion;
}

@end
