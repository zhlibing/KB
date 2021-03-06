//
//  AES_SecurityUtil.h
//  AES加解密(后台使用AES+CBC+NoPadding模式)
//
//  Created by 一介布衣 on 2017/5/5.
//  Copyright © 2017年 HUAMANLOU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES_SecurityUtil : NSObject


/**
 加密

 @param plaintext 明文
 @return 返回密文是十六进制的字符串
 */
+ (NSString *)aes128EncryptWithContent:(NSString *)plaintext;



/**
 解密

 @param ciphertext 密文
 @return 返回明文的十六进制的字符串
 */
+ (NSString *)aes128DencryptWithContent:(NSString *)ciphertext;


@end
