//
//  ParallelLoadManage.h
//  TestNSOperation
//
//  Created by baidu on 2020/7/27.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ParallelLoadOperation.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParallelLoadManage : NSObject

+ (instancetype)shared;

- (void)addParallelLoadTaskWithUrlStr:(NSString *)urlStr;

- (void)addParallelLoadTaskWithUrlArray:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
