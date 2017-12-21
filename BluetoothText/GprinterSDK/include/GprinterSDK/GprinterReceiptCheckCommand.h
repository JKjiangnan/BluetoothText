//
//  GprinterReceiptCheckCommand.h
//  GprinterSDK
//
//  Created by ShaoDan on 2017/9/16.
//  Copyright © 2017年 Gainscha. All rights reserved.
//
//（查询wifi+网口打印机的状态）

#import <Foundation/Foundation.h>

@interface GprinterReceiptCheckCommand : NSObject

//连接
-(instancetype)OpenPort:(NSString*)host port:(UInt16)port timeout:(NSTimeInterval)timeout;
//断开
- (void)ClosePort;

//查询机型
-(void)SearchTheModelNum;

//查询打印机状态
-(void)SearchPrinterStatus:(int)n;

//发送请求
- (void)SendToPrinter;

//接收打印机的数据
@property (nonatomic, strong) NSMutableData *sendrData;
//返回的机型号
@property(nonatomic,strong)NSString *ModeStr;


//判断
@property(assign,nonatomic)BOOL isSearchMode;
@property (assign,nonatomic)int numOfStatus;




@end
