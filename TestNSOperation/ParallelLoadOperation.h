//
//  ParallelLoadOperation.h
//  TestNSOperation
//
//  Created by baidu on 2020/7/27.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ParallelLoadManage.h"

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ParallelLoadOperation : NSOperation

@property (copy, nonatomic) NSString *urlStr;


@end

NS_ASSUME_NONNULL_END
