#  NSOperation

## 背景
NSOperation 与 NSOperationQueue 的官方文档由于时效性问题，存在一些不准确的地方，特写此 Demo 用来验证其用法、误区；


## 官方文档
NSOperation: https://developer.apple.com/documentation/foundation/nsoperation
NSOperationQueue: https://developer.apple.com/documentation/foundation/nsoperationqueue

## 问题
1 NSOperation 的实现方式有两种，使用 start 和 main，这两种方式的区别
线程管理不同，start 需要手动释放线程，main执行完后自动释放线程

2 使用 main 时，需要注意什么？
只需要 overwrite main 即可，不要对 - (BOOL)isExecuting；和 - (BOOL)isFinished 进行了 overwrite ，因为 overwrite 后，NSOperation 无法被自动释放，需要手动修改一下 isFinished 和  isExecuting 来释放线程。

3 使用 start 时，需要注意什么？
需要 overwrite start、isExecuting、isFinished 方法，在合适时机手动释放请求

4 如何选择使用 start 或 main？
如果不需要长期持有线程，可以使用 main 方式，如果需要持有当前线程，使用 start 方式；

5 线程释放后，内存会释放吗？
当存在外部强引用当前 operation 时，不会释放，否则会释放内存


