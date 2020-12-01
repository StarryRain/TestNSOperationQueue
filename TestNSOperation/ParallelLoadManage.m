//
//  ParallelLoadManage.m
//  TestNSOperation
//
//  Created by baidu on 2020/7/27.
//  Copyright © 2020 baidu. All rights reserved.
//

#import "ParallelLoadManage.h"

@interface ParallelLoadManage ()

@property (strong, nonatomic) NSOperationQueue *operationQueue;
@property (strong, nonatomic) NSLock *lock;
@property (nonatomic, strong) NSMutableDictionary <NSString *, ParallelLoadOperation *> *taskDict;

@end

@implementation ParallelLoadManage

+ (instancetype)shared {
    static ParallelLoadManage *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ParallelLoadManage alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 3;
        _lock = [[NSLock alloc] init];
        _taskDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addParallelLoadTaskWithUrlStr:(NSString *)urlStr {
    ParallelLoadOperation *newOperation = [[ParallelLoadOperation alloc] init];
    newOperation.urlStr = urlStr;
    [self.lock lock];
    [self.operationQueue addOperation:newOperation];
    NSLog(@"qy6 add to queue url = %@ ", urlStr);
    [self.lock unlock];
}

- (void)addParallelLoadTaskWithUrlArray:(NSMutableArray<NSString *> *)urlArray {
    
    NSInteger count = urlArray.count;
    NSMutableArray<ParallelLoadOperation *> *operations = [NSMutableArray arrayWithCapacity:count];

    
    for (NSString *urlStr in urlArray) {
        ParallelLoadOperation *newOperation = [[ParallelLoadOperation alloc] init];
        newOperation.urlStr = urlStr;
        [operations addObject:newOperation];
        [self addTask:newOperation];       
    }
    [self.lock lock];
    [self.operationQueue addOperations:operations waitUntilFinished:NO];
    [self.lock unlock];
    
    sleep(50);
    for (ParallelLoadOperation *operation in operations) {
        [self removeTask:operation];
    }
}

- (void)addTask:(ParallelLoadOperation *)task {
    @synchronized (_taskDict) {
        [_taskDict setObject:task forKey:task.urlStr];
    }
}

- (void)removeTask:(ParallelLoadOperation *)task {
    @synchronized (_taskDict) {
        [_taskDict removeObjectForKey:task.urlStr];
    }
}

- (void)dealloc {
    NSLog(@"qy6 dealloc in manager");
}

@end
