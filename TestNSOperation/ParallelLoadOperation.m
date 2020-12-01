//
//  ParallelLoadOperation.m
//  TestNSOperation
//
//  Created by baidu on 2020/7/27.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ParallelLoadOperation.h"

@interface ParallelLoadOperation () {
    BOOL _isFinished;
    BOOL _isExecuting;
}

@end

@implementation ParallelLoadOperation

//- (void)main {
//    sleep(3);
//    NSLog(@"qy6 main0 url = %@ | thread = %@", self.urlStr, [NSThread currentThread]);
//    sleep(3);
//    NSLog(@"qy6 main1 url = %@ | thread = %@", self.urlStr, [NSThread currentThread]);
//}
    
- (void)start {

    if ([self isCancelled]) {
        return;
    }
    [self parallelStart];
    sleep(3);
    NSLog(@"qy6 run1 url2 = %@ ", self.urlStr);
    sleep(3);
    [self parallelFinish];

}

- (void)parallelStart {
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    NSLog(@"qy6 started url = %@ | thread = %@", self.urlStr, [NSThread currentThread]);

}

- (void)parallelFinish {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    _isFinished = YES;
    _isExecuting = NO;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
    NSLog(@"qy6 finished url = %@ ", self.urlStr);

}

- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}

- (void)dealloc {
    NSLog(@"qy6 dealloc in Operation url = %@", self.urlStr);
}

@end
