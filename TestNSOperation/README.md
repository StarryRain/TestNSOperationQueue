#  NSOperation

## 背景
用来测试


## 相关链接
NSOperation: https://developer.apple.com/documentation/foundation/nsoperation
NSOperationQueue: https://developer.apple.com/documentation/foundation/nsoperationqueue

## 问题
1 使用main时，只执行并发的任务个数，多余任务不执行？
因为NSOperation没有被释放掉，原因是对 - (BOOL)isExecuting；和 - (BOOL)isFinished 进行了 overwrite后却没有手动修改一下 _isFinished 和  _isExecuting 进行停止任务，修改方式为删除overwrite或手动更改任务状态；

2 使用main时，是否执行完main函数后，释放当前线程
是，释放后用来执行其他任务。可以通过两种方式手动释放1）对 - (BOOL)isExecuting；和 - (BOOL)isFinished 进行了 overwrite 后手动修改一下 _isFinished 和  _isExecuting 进行停止任务；

3 使用main时，是否执行完main函数后，释放当前内存
外部强引用当前operation时，不会释放

4 使用 start 和 main 的区别
线程的使用，start 需要手动释放线程，main执行完后自动释放线程
