//
//  GprinterReceiptCommand.h
//  GprinterSDK
//
//  Created by ShaoDan on 2017/8/14.
//  Copyright © 2017年 Gainscha. All rights reserved.
//查询蓝牙机型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GprinterReceiptCommand : NSObject




//对齐方式
typedef enum :UInt8 {
    LeftAlignment = 0x30,
    MiddleAlignment = 0x31,
    RightAlignment = 0x32,
}AlignmentType;

//页模式下打印区域方向
typedef enum  {
    LeftToRight = 0x30,
    DownToUP    = 0x31,
    RightToLeft = 0x32,
    UpToDown    = 0x33,
}PrintOrientation;

//字符放大倍数
typedef enum: UInt8 {
    scale_1 = 0x00,
    scale_2 = 0x11,
    scale_3 = 0x22,
    scale_4 = 0x33,
    scale_5 = 0x44,
    scale_6 = 0x55,
    scale_7 = 0x66,
    scale_8 = 0x77,
}CharScale;

//选择字体
typedef enum: UInt8 {
    standardFont = 0x30,
    smallerFont = 0x31,
}CharFont;

//切纸模式
typedef enum :UInt8 {
    fullCut = 0x30,
    halfCut = 0x31,
    feedPaperHalfCut = 0x42,
}CutPaperModel;

//code128
typedef NS_ENUM (NSUInteger,CODE128Type) {
    
    codeA = 1,
    codeB = 2,
    codeC = 3,
    
     
};



//打印数据(文字图片信息)
@property (nonatomic, strong) NSMutableData *sendRData;






//连接
-(instancetype)OpenPort:(NSString*)host port:(UInt16)port timeout:(NSTimeInterval)timeout;
//断开
- (void)ClosePort;
//基础设置(包括初始化，设置标准模式，横纵向异动单位，默认行距，设置字号)
- (void)basicSetting;
//打印文字
- (void)addText:(NSString *)text;
//打印一维码
-(void)addBarCodeWithWidth:(int)w Height:(int)h Position:(int)p Type:(int)type String:(NSString*)string Alignment:(AlignmentType)alignment;
//code128
-(void)addCode128WithWidth:(int)w Height:(int)h Position:(int)p CodeType:(CODE128Type)type String:(NSString*)string Alignment:(AlignmentType)alignment;
//UPC-E
-(void)addUPC_EWithWidth:(int)w Height:(int)h Position:(int)p String:(NSString*)string Alignment:(AlignmentType)alignment;
//图片
- (void)addPicture:(UIImage *)image Alignment:(AlignmentType)alignment maxWidth:(CGFloat)maxWidth;
//二维码
- (void)addQRCodeWithInfo:(NSString *)info size:(NSInteger)size alignment:(AlignmentType)alignment;
//如果打印机不支持指令打印二维码，可用图片的方式打印
-(void)addQRcodeAsImage:(NSString*)str alignment:(AlignmentType)alignment;

//打开钱箱
- (void)OpenCashDrawerOne;
- (void)OpenCashDrawerTwo;
//切纸
-(void)addCut;
//样本一
-(void)PrintSampleOne;
//样本二
-(void)PrintSampleTwo;
//发送数据
- (void)SendToThePrinter;
//查询机型
-(void)SearchTheModelNum;
////查询打印机状态
-(void)SearchPrinterStatus:(int)n;

//型号
@property(nonatomic,strong)NSString *ModeStr;

//判断
@property(assign,nonatomic)BOOL isSearchMode;
@property (assign,nonatomic)int numOfStatus;



@end
