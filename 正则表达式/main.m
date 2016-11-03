//
//  main.m
//  正则表达式
//
//  Created by zhangyongjun on 15/8/6.
//  Copyright (c) 2015年 张永俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

//普通做法
void test() {
    NSString *str = @"234353t4";
    BOOL flag = YES;
    //检查是否是纯数字
    for (int i = 0; i < str.length; i ++) {
        unichar c = [str characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            continue;
        }else {
            flag = NO;
        }
    }
    if (flag) {
        NSLog(@"纯数字");
    }else {
        NSLog(@"包含非数字");
    }
}

//正则表达式
/**
 使用步骤：
 1.创建一个正则表达式对象：定义规则
 2.利用正则表达式对象来测试相应字符串
 
          详细使用，上百度!!!
 */
void test2 () {
    NSString *str = @"#呵呵呵#[偷笑] http://foo.com/blah_blah #解放军#//http://foo.com/blah_blah @Ring花椰菜:就#范德萨发生的#舍不得打[test] 就惯#急急急#着他吧[挖鼻屎]//@崔西狮:小拳头举起又放下了 说点啥好呢…… //@toto97:@崔西狮 蹦米咋不揍他#哈哈哈# http://foo.com/blah_blah";
    
//    表1.常用的元字符
//    代码	说明
//    .	匹配除换行符以外的任意字符
//    \w	匹配字母或数字或下划线或汉字
//    \s	匹配任意的空白符
//    \d	匹配数字
//    \b	匹配单词的开始或结束
//    ^	匹配字符串的开始
//    $	匹配字符串的结束
    
    //NSString *pattern = @"[0-9]";//[]表示满足里面的某一个要求就算满足
    //NSString *pattern = @"[0-9][0-9]";//表示两个挨着的数字
    //NSString *pattern = @"123";//连着的123
    //NSString *pattern = @"\\d[0-9]";//两个连着的数字
    //NSString *pattern = @"\\d{3}";//三个连着的数字
    //NSString *pattern = @"[a-z]";//包含小写字母
    //NSString *pattern = @"[a-zA-Z]";//包含字母
    //NSString *pattern = @"\\d{2,4}";//包含2~4个数字
    //NSString *pattern = @"ab7";//包含连续的ab7
    
    //NSString *pattern = @"\\d?";//? 表示0个或者一个
    //NSString *pattern = @"\\d+";//至少一个
    //NSString *pattern = @"\\d*";//0个或者多个
    //NSString *pattern = @"^\\d";//^表示以什么开头
    //NSString *pattern = @"\\d$";//$表示以什么结尾
   // NSString *pattern = @"^\\d{2,4}.*[a-zA-Z]$";//以2-4个数字开头，以字母结尾，中间任意多个(*)的任意字符.
    
   // NSString *pattern = @"^\\d{2,4}$";//重头到尾只有2~4个数字
    //匹配表情[...]
    NSString *pattern = @"\\[[\\u4e00-\\u9fa50-9a-zA-Z]+\\]";
    //匹配引用@...:
    NSString *pattern2 = @"@[\\u4e00-\\u9fa50-9a-zA-Z]+:";
    //#话题#
    NSString *pattern3 = @"#[\\u4e00-\\u9fa50-9a-zA-Z]+#";
    //url匹配
    NSString *pattern4 = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern5 = [NSString stringWithFormat:@"%@|%@|%@|%@",pattern,pattern2,pattern3,pattern4];
    NSRegularExpression *regex = [[NSRegularExpression alloc]initWithPattern:pattern4 options:0 error:nil];
    
    NSArray *results = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    //查看结果
    for (NSTextCheckingResult *result in results) {
        NSLog(@"%@,%@",NSStringFromRange(result.range),[str substringWithRange:result.range]);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //test();
        //test2();
        //过滤
        //filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"北京"];
        
        NSString *str = @"#呵呵呵#[偷笑] http://foo.com/blah_blah #解放军#//http://foo.com/blah_blah @Ring花椰菜:就#范德萨发生的#舍不得打[test] 就惯#急急急#着他吧[挖鼻屎]//@崔西狮:小拳头举起又放下了 说点啥好呢…… //@toto97:@崔西狮: 蹦米咋不揍他#哈哈哈# http://foo.com/blah_blah";
        //匹配表情[...]
        NSString *pattern = @"\\[[\\u4e00-\\u9fa50-9a-zA-Z]+\\]";
        //匹配引用@...:
        NSString *pattern2 = @"@[\\u4e00-\\u9fa50-9a-zA-Z]+:";
        //#话题#
        NSString *pattern3 = @"#[\\u4e00-\\u9fa50-9a-zA-Z]+#";
        //url匹配
        NSString *pattern4 = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
        NSString *pattern5 = [NSString stringWithFormat:@"%@|%@|%@|%@",pattern,pattern2,pattern3,pattern4];
        
        //按照正则表达式直接拿到字符串
        //NSArray *results = [str componentsMatchedByRegex:pattern5];
        //NSLog(@"%@",results);
        
        //按照正则表达式遍历更详细信息
//        [str enumerateStringsMatchedByRegex:pattern5 usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//            NSLog(@"%@,%@",*capturedStrings,NSStringFromRange(*capturedRanges));
//        }];
        
        //将正则表达式作为分隔符
//        [str enumerateStringsSeparatedByRegex:pattern5 usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//            NSLog(@"%@,%@",*capturedStrings,NSStringFromRange(*capturedRanges));
//        }];
        
        //利用正则表达式捕捉字符串
        NSString *re = [str stringByMatching:@"(说点啥)好呢" capture:YES];
        NSLog(@"%@",re);
    }
    return 0;
}

