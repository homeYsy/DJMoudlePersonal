//
//  APPResult.h
//  DJBase
//  请求结果
//  Created by CSS on 2019/5/13.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPResult : NSObject
/** 交互格式
{
  "success":true,//是否处理成功
  "code":800000,
  "total":0,
  "data":{},
  "msg":""
}
*/
@property (nonatomic, assign) id success;    //状态
@property (nonatomic, assign) id code;       //错误码
@property (nonatomic, strong) id total;      //总数
@property (nonatomic, strong) id data;       //数据
@property (nonatomic, strong) id msg;        //描述

@end
