//
//  NSString+WHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "NSString+WHandler.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WHandler)



#pragma mark - 字符串长度、空、类型 判断
/**
 判断字符串是否为空

 @return 返回是否
 */
- (BOOL) isBlank;
{
    if (self &&
        self.length != 0 &&
        ![self isEqualToString:@"<null>"] &&
        ![self isEqualToString:@"(null)"] &&
        ![self isKindOfClass:[NSNull class]] &&
        ![self isEqual:[NSNull null]] &&
        ![self isEqual:NULL] &&
        [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] != 0){

        return NO;
    }
    else{

        return YES;
    }
}


/**
 判断是否为纯数字

 @return 返回结果
 */
- (BOOL) isPureInt;
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


/**
 中文字符串的长度，中文占1位

 @return 返回长度
 */
- (int) unicodeCount;
{
    int unicodeLength = 0;
    for(int i=0; i< [self length];i++){

        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){

            unicodeLength ++;
        }
    }

    return unicodeLength;
}


/**
 获取不包含中文的字符串长度

 @return 获取不包含中文的字符串长度
 */
- (int) asciiCount;
{
    int unicodeLength = 0;
    for(int i=0; i< [self length];i++){

        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){}
        else{

            unicodeLength ++;
        }
    }

    return unicodeLength;
}


/**
 字符串总长度,中文占1位

 @return 获取包含中文的字符串长度
 */
- (int) totalCount;
{
    int unicodeLength = 0;
    for(int i=0; i< [self length];i++){

        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){

            unicodeLength ++;
        }
        else{

            unicodeLength ++;
        }
    }

    return unicodeLength;
}

#pragma mark - 字符串加密

/**
 sha1编码

 @return 返回编码的字符串
 */
- (NSString *) SHA1;
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];

    NSData *data = [NSData dataWithBytes:cstr length:self.length];
        //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
        //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);

    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    return output;
}


/**
 md5编码

 @return 返回md5编码的字符串
 */
- (NSString *) MD5;
{
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [self UTF8String];

    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */

    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];

    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}


#pragma mark - 字符串过滤、截取
/**
 过滤html 字符串

 @return 过滤完成的字符串
 */
- (NSString *)escapeHTMLSpecialString;
{
    NSString *returnStr = [self stringByReplacingOccurrencesOfString:@"\r" withString:@"\n"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ge;" withString:@"—"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"®"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];

    // 如果还有别的特殊字符，请添加在这里

    return returnStr;
}


/**
 字符串截取

 @param index 开始位置（不指定就是从0开始）
 @param length 截取长度
 @return 返回截取后的字符串
 */
-(NSString *)getStringAtIndex:(int)index
                       length:(int)length;
{
    if (index+length < self.length) {

        NSString *str = [self substringFromIndex:index];
        return [str substringToIndex:length];
    }
    else{
        
        [self DEBUGWithTarget:self message:@"字符串索引越界"];
        return nil;
    }
}


- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex: 0];

    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;

        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);

    // Not surrogate pair (U+2100-27BF)
    }
    else {

        return (0x2100 <= high && high <= 0x27bf);
    }
}


/**
 字符串是否包含emoji表情

 @return 返回是否包含
 */
- (BOOL)containEmoji;
{
    BOOL __block result = NO;

    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];

    return result;
}


/**
 去除字符串的emoji表情字符

 @return 返回去除后的字符串
 */
- (instancetype)removeEmoji;
{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];

    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring isEmoji])? @"": substring];
                          }];

    return buffer;
}


/**
 获取字符串(或汉字)首字母

 @return 获取首字母
 */
- (NSString *)firstCharacter;
{
    NSMutableString *str = [NSMutableString stringWithString:self];

    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);

    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);

    NSString *pingyin = [str capitalizedString];

    return [pingyin substringToIndex:1];
}


#pragma mark - 字符串大小计算
/**
 获取字符串的尺寸

 @param font 要显示的字号
 @param maxSize 最大尺寸
 @return 返回字符串的
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


#pragma mark - 判断字符串
/**
 判断是否是手机号

 @return 是否是手机号
 */
- (BOOL) validMobile;
{
    [self stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (self.length != 11){

        return NO;
    }
    else{

        /**

         * 移动号段正则表达式

         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";

        /**

         * 联通号段正则表达式

         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";

        /**

         * 电信号段正则表达式

         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";

        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];

        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];

        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];

        if (isMatch1 || isMatch2 || isMatch3) {

            return YES;
        }else{

            return NO;
        }
    }
}


/**
 判断是否是邮箱

 @return 是否是邮箱
 */
- (BOOL) validEmail;
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


/**
 检查密码

 @return 密码是否包含数字和字母
 */
- (BOOL) validPassWord;
{
    //6-20位数字和字母组成(可根据情况修改)
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,12}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }
    else {
        return NO;
    }
}


/**
 检查身份证

 @return 身份证是否正确
 */
- (BOOL) validIDCard;
{
    NSMutableArray *IDArray = [NSMutableArray array];
        // 遍历身份证字符串,存入数组中
    for (int i = 0; i <18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        [IDArray addObject:subString];
    }
        // 系数数组
    NSArray *coefficientArray = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @"2"];
        // 余数数组
    NSArray *remainderArray = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i <17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
        // 这个和除以11的余数对应的数
    NSString *str = remainderArray[(sum % 11)];
        // 身份证号码最后一位
    NSString *string = [self substringFromIndex:17];
        // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    return [str isEqualToString:string];
}


/**
 判断密码是否过于简单

 @return 返回值
 */
- (BOOL) needChangePass;
{
    NSArray *array = @[@"123456",@"111111",@"654321",@"123123",@"222222"];
    if ([array containsObject:self]) {

        return YES;
    }
    return NO;
}

@end
