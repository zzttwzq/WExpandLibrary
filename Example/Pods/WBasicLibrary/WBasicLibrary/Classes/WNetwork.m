//
//  WNetwork.m
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import "WNetwork.h"

@implementation WNetwork

#pragma mark - NSMutitablehttpRequest
/**
 利用NSMutableURLRequest 实现的http请求

 @param urlString 请求的url或者action
 @param params post数据
 @param setHttpHeaderfield 设置http请求头
 @param success 成功回调
 @param faild 失败回调
 */
+(void)netWorkWithURL:(NSString *_Nullable)urlString
            urlMethod:(NSString *_Nullable)urlMethod
               params:(id _Nullable)params
   setHttpHeaderfield:(httpHeaderField _Nullable )setHttpHeaderfield
              success:(requestSuccessBlock _Nullable )success
                faild:(requestFaildBlock _Nullable )faild;
{
    //1.url地址编码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    urlString = [urlString filterHTMLSpecialString];
//    urlString = [urlString filterEmoji];


    //2.使用设置来创建一个sesson
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];


    //3.创建request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.HTTPMethod = urlMethod;


    //4.设置数据
    if ([params isKindOfClass:[NSString class]]) {

        request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if ([params isKindOfClass:[NSDictionary class]]) {

        NSDictionary *postDic = params;

        if (postDic) {

            NSString *string = @"";
            for (NSString *key in postDic) {

                string = [string stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,postDic[key]]];
            }
            string = [string substringToIndex:string.length-1];
            string = [string stringByAppendingString:@"&type=JSON"];

            request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
        }
    }


    //5.设置类型
    if (setHttpHeaderfield) {
        setHttpHeaderfield(request);
    }
    [request setValue:@"application/json;text/html;" forHTTPHeaderField:@"Content-Type"];


    //6.由于要先对request先行处理,我们通过request初始化task
    NSURLSessionTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                                            if (error) {
                                                faild(error);
                                            }
                                            else{

                                                if (data) {

                                                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

                                                    dispatch_async(dispatch_get_main_queue(), ^(){

                                                        if (success) {
                                                            success(dic);
                                                        }
                                                    });
                                                }
                                                else{

                                                    NSError *emptyError = [NSError errorWithDomain:@"返回的数据为空！！！" code:0 userInfo:nil];
                                                    faild(emptyError);
                                                }
                                            }
                                        }];
    //7.启动任务
    [task resume];
}


/**
 nsurl实现的http get请求

 @param urlString 访问的url
 @param params post数据
 @param setHttpHeaderfield 设置http请求头
 @param success 成功回调
 @param faild 失败回调
 */
+(void)getTaskWithURL:(NSString *_Nullable)urlString
               params:(id _Nullable)params
   setHttpHeaderfield:(httpHeaderField _Nullable )setHttpHeaderfield
              success:(requestSuccessBlock _Nullable )success
                faild:(requestFaildBlock _Nullable )faild;
{
    [self netWorkWithURL:urlString urlMethod:GET_METHOD params:params setHttpHeaderfield:setHttpHeaderfield success:success faild:faild];
}


/**
 nsurl实现的http post请求

 @param urlString 访问的url
 @param params post数据
 @param setHttpHeaderfield 设置http请求头
 @param success 成功回调
 @param faild 失败回调
 */
+(void)postTaskWithURL:(NSString *_Nullable)urlString
                params:(id _Nullable)params
    setHttpHeaderfield:(httpHeaderField _Nullable )setHttpHeaderfield
               success:(requestSuccessBlock _Nullable )success
                 faild:(requestFaildBlock _Nullable )faild;
{
    [self netWorkWithURL:urlString urlMethod:POST_METHOD params:params setHttpHeaderfield:setHttpHeaderfield success:success faild:faild];
}


#pragma mark - afnetworking封装的方法
/**
 创建一个单利

 @param HeaderfieldBlock 添加http请求头
 @return 返回单利
 */
+(AFHTTPSessionManager *_Nullable)sharedManagerWithHeaderfieldBlock:(AFHttpHeaderField _Nullable )HeaderfieldBlock;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //1.设置请求类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/xml",@"text/plain", nil];


    //2.最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 10;

    // 请求格式
    // AFHTTPRequestSerializer            二进制格式
    // AFJSONRequestSerializer            JSON
    // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式


    //3.超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;


    //4.设置接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];

    // 返回格式
    // AFHTTPResponseSerializer           二进制格式
    // AFJSONResponseSerializer           JSON
    // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer   PList
    // AFImageResponseSerializer          Image
    // AFCompoundResponseSerializer       组合


    //5.设置返回Content-type 返回格式 JSON
    manager.responseSerializer = [AFJSONResponseSerializer serializer];


    //6.设置请求头
    if (HeaderfieldBlock) {
        HeaderfieldBlock(manager.requestSerializer);
    }
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];

    return manager;
}


/**
 afn封装的get方法

 @param urlString 请求地址
 @param params 发送数据
 @param setHttpHeaderfield 设置http请求头
 @param progress 下载进度
 @param success 成功回调
 @param faild 失败回调
 */
+(void)getRequestWithURL:(NSString *_Nullable)urlString
                  params:(NSDictionary *_Nullable)params
      setHttpHeaderfield:(AFHttpHeaderField _Nullable )setHttpHeaderfield
                progress:(progressBlock _Nullable)progress
                 success:(requestSuccessBlock _Nullable )success
                   faild:(requestFaildBlock _Nullable )faild;
{
    //1.创建一个manager。
    [[WNetwork sharedManagerWithHeaderfieldBlock:setHttpHeaderfield]
     GET:urlString
     parameters:params
     progress:^(NSProgress * _Nonnull downloadProgress) {

        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (responseObject != nil) {

            if (success) {
                success(responseObject);
            }
        }else{

            NSError *emptyError = [NSError errorWithDomain:@"返回的数据为空！！！" code:0 userInfo:nil];
            if (faild) {
                faild(emptyError);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (faild) {
            faild(error);
        }
    }];
}


/**
 afn封装的post方法

 @param urlString 请求地址
 @param params 发送数据
 @param setHttpHeaderfield 设置http请求头
 @param progress 下载进度
 @param success 成功回调
 @param faild 失败回调
 */
+(void)postRequestWithURL:(NSString *_Nullable)urlString
                   params:(NSDictionary *_Nullable)params
       setHttpHeaderfield:(AFHttpHeaderField _Nullable )setHttpHeaderfield
                 progress:(progressBlock _Nullable)progress
                  success:(requestSuccessBlock _Nullable )success
                    faild:(requestFaildBlock _Nullable )faild;
{
    //1.创建一个manager。
    [[WNetwork sharedManagerWithHeaderfieldBlock:setHttpHeaderfield]
     POST:urlString
     parameters:params
     progress:^(NSProgress * _Nonnull downloadProgress) {

         if (progress) {
             progress(downloadProgress);
         }
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

         if (responseObject != nil) {

             if (success) {
                 success(responseObject);
             }
         }else{

             NSError *emptyError = [NSError errorWithDomain:@"返回的数据为空！！！" code:0 userInfo:nil];
             if (faild) {
                 faild(emptyError);
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

         if (faild) {
             faild(error);
         }
     }];
}
@end
