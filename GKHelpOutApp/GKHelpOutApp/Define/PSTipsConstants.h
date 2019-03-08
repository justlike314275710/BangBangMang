//
//  PSTipsConstants.h
//  PrisonService
//
//  Created by calvin on 2018/4/2.
//  Copyright © 2018年 calvin. All rights reserved.
//
//typedef NS_ENUM(NSUInteger, PSLoginStatus) {
//    PSLoginNone=0,
//    PSLoginDenied=1,  //未认证
//    PSLoginPending=2, //待审核
//    PSLoginPassed=3   //已认证
//};
#define CopyRight @"国科政信科技（北京）股份有限公司\ncopyright@2006-2015.All right reserved"

#define ContactDetails @"地址：北京市海淀区西三旗昌临813号11号楼\n邮编：100086\n客服电话：010-82911287-5032"

#define ContactPhone @"010-82911287"

//#define UseHelp @"1、服刑人员每月可亲情电话次数不限。\n2、部分服刑人员不提供亲情电话服务。\n3、狱务通软件暂时只提供直系亲属进行亲情电话，请谅解。\n4、根据安全要求，您的通话信息可能会被记录。\n5、每次亲情电话需缴纳一定服务费用，收费方为国科政信科技(北京)股份有限公司。\n6、因监狱会见资源紧缺，一个家属一天只能会见一次。"

#define UseHelp @"1、按监狱管理规定，只有部分服刑人员提供远程视频会见，具体情况请向关押监狱咨询。\n2、狱务通软件只提供直系亲属远程视频会见，会见频率遵循关押监狱规定。\n3、远程视频会见全程录音录像，会见过程中请自觉遵守法律法规要求，禁止传播负能量信息，若有违法行为，本司将向有关部门提供音视频证据。\n4、每次会见须缴纳一定服务费用，收费方为国科政信科技(北京)股份有限公司。"


#define BuyCardTips @"一张电话卡可申请一次远程视频会见\n未使用可随时退，原路退回"

#define BuyCardStep1 @"第1步\n   进入首页 - 点击预约"

#define BuyCardStep2 @"选择会见日期"

#define BuyCardStep3 @"第3步\n   提交会见申请 - 等待审核"

#define NET_ERROR [NSObject judegeIsVietnamVersion]?@"Mạng của bạn không bình thường":@"哇哦，您的网络异常了"
#define CLICK_ADD [NSObject judegeIsVietnamVersion]?@"Nhấn vào đây để tải":@"点击加载"

#define EMPTY_CONTENT NSLocalizedString(@"暂没有内容", nil)
//@"暂没有内容"

#define RegisterFaceFailed @"您的用户头像图片检测不到人脸，请退出重新设置"

#define VerifyFaceFailed @"人脸识别失败，是否退出？"

#define LocalMeetingIntroduceOne @"1.服刑人员在服刑期间，除法定节假日外，按照规定均可会见亲属、监护人，家属可通过“预约”功能，选择预约日期后进行实地会见申请。"
#define VLocalMeetingIntroduceOne @"1. Trong thời gian thụ án, ngoài các ngày lễ theo luật định, tù nhân có thể gặp người thân và người giám hộ theo quy định. Các thành viên trong gia đình có thể sử dụng chức năng đặt phòng trên đường sắt để chọn ngày nộp đơn sau ngày hẹn."

#define LocalMeetingIntroduceTwo @"2.服刑人员会见一般每月1次，每次半小时至一小时。"
#define VLocalMeetingIntroduceTwo @"2. Người tù sẽ gặp gỡ chung một lần, nửa giờ đến một giờ mỗi lần."

#define LocalMeetingIntroduceThree @"3.实地会见时，必须携带身份证及其它能证明自己与罪犯关系的有效证明(户口簿、公安派出所证明、单位介绍信等)，并经过监狱负责会见的干警审查后方可会见。"

#define VLocalMeetingIntroduceThree @"3. Khi bạn gặp tại chỗ, bạn phải mang theo chứng minh nhân dân và các chứng chỉ hợp lệ khác (sổ hukou, chứng chỉ đồn cảnh sát, thư giới thiệu đơn vị, v.v.) có thể chứng minh mối quan hệ của bạn với bọn tội phạm và bạn có thể gặp cảnh sát phụ trách cuộc họp."

#pragma mark —————————————————— 提示语
#define Hmsg_Comingsoon @"敬请期待!"
//注册认证模块
#define Hmsg_user_existed          @"用户已存在";
#define Hmsg_user_pwd_notMatched   @"账号密码不匹配";
#define Hmsg_user_code_notMatched  @"验证码错误";
#define Hmsg_unauthorized          @"账号不存在";
#define Hmsg_user_group_NotMatched @"账号不属于该群组";
#define Hmsg_user_invalid_grant    @"账号已禁用";


#pragma mark ———————————————————————————————————————— 认证授权平台返回错误码
#define user_existed          @"user.Existed";                     //用户已存在
#define user_pwd_notMatched   @"user.password.NotMatched";         //账号密码不匹配
#define user_code_notMatched  @"sms.verification-code.NotMatched"; //验证码错误
#define user_unauthorized     @"unauthorized";                     //账号不存在
#define user_group_NotMatched @"user.group.NotMatched";            //账号不属于该群组
#define user_invalid_grant    @"invalid_grant";                    //账号已禁用



