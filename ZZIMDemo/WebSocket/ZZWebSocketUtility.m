//
//  ZZWebSocketUtility.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/4.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWebSocketUtility.h"
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#define WeakSelf(ws) __weak __typeof(&*self)weakSelf = self

NSString * const kNeedPayOrderNote               = @"kNeedPayOrderNote";
NSString * const kWebSocketDidOpenNote           = @"kWebSocketdidReceiveMessageNote";
NSString * const kWebSocketDidCloseNote          = @"kWebSocketDidCloseNote";
NSString * const kWebSocketdidReceiveMessageNote = @"kWebSocketdidReceiveMessageNote";

static  NSString * Khost = @"127.0.0.1";
static const uint16_t Kport = 6969;

@interface ZZWebSocketUtility ()<SRWebSocketDelegate>
{
    NSTimeInterval reConnectTime;// 重连时间
}
@property (nonatomic, strong) NSTimer * heartBeat;// 心跳计时
@property (nonatomic, strong) SRWebSocket * webSocket;

@end
@implementation ZZWebSocketUtility

+ (instancetype)shareInstance{
    static ZZWebSocketUtility * socket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (socket == nil) {
            socket = [[ZZWebSocketUtility alloc]init];
            [socket initSocket];
        }
    });
    return socket;
}
#pragma mark -- 初始化websocket
- (void)initSocket{
    if (self.webSocket) {
        return;
    }
    self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"ws://%@:%d",Khost,Kport]]];
    self.webSocket.delegate = self;
    
    // 设置代理线程
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;
    [self.webSocket setDelegateOperationQueue:queue];
    [self.webSocket open];
    
}
#pragma mark -- 连接socket
- (void)connectWebSocket{
    
    [self initSocket];
    reConnectTime = 0;
    
}
#pragma mark --  断开socket
- (void)disConnectWebSocket{
    if (self.webSocket) {
        [self.webSocket close];
        self.webSocket = nil;
        //断开连接时销毁心跳
    }
}
#pragma mark -- 初始化心跳
- (void)initHeartBeat
{
    dispatch_main_async_safe(^{
        [self destoryHeartBeat];
        //心跳设置为3分钟，NAT超时一般为5分钟
        self.heartBeat = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(sentheart) userInfo:nil repeats:YES];
        //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
        [[NSRunLoop currentRunLoop] addTimer:self.heartBeat forMode:NSRunLoopCommonModes];
    })
}
#pragma mark -- 发送心跳
-(void)sentheart{
    //发送心跳 和后台可以约定发送什么内容  一般可以调用ping  我这里根据后台的要求 发送了data给他
    [self sendData:@"heart"];
}
#pragma mark --  pingPong
- (void)ping{
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket sendPing:nil];
    }
}
#pragma mark -- 信息发送
- (void)sendMessageData:(id)data{
    [self sendData:data];
}
- (void)sendData:(id)data {
    NSLog(@"socketSendData --------------- %@",data);
    
    WeakSelf(ws);
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        if (weakSelf.webSocket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                [weakSelf.webSocket send:data];    // 发送数据
                
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                [self reConnect];
                
            } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                
                NSLog(@"重连");
                
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
            NSLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
        }
    });
}
#pragma mark -- 重连机制
- (void)reConnect
{
    [self disConnectWebSocket];
    
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        //您的网络状况不是很好，请检查网络后重试
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.webSocket = nil;
        [self disConnectWebSocket];
        NSLog(@"重连");
    });
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
}

#pragma mark -- 取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (self.heartBeat) {
            if ([self.heartBeat respondsToSelector:@selector(isValid)]){
                if ([self.heartBeat isValid]){
                    [self.heartBeat invalidate];
                    self.heartBeat = nil;
                }
            }
        }
    })
}
#pragma mark - socket delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    //开启心跳
    [self initHeartBeat];
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket 连接成功************************** ");
        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketDidOpenNote object:nil];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket 连接失败************************** ");
        webSocket = nil;
        //连接失败就重连
        [self reConnect];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket连接断开************************** ");
        NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",(long)code,reason,wasClean);
        [self disConnectWebSocket];
        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketDidCloseNote object:nil];
    }
}

/*该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}
#pragma mark -- 收到服务端 数据
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message  {
    
    if (webSocket == self.webSocket) {
        NSLog(@"************************** socket收到数据了************************** ");
        NSLog(@"我这后台约定的 message 是 json 格式数据收到数据，就按格式解析吧，然后把数据发给调用层");
        NSLog(@"message:%@",message);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketdidReceiveMessageNote object:message];
    }
}

#pragma mark - **************** setter getter
- (SRReadyState)socketReadyState{
    return self.webSocket.readyState;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
