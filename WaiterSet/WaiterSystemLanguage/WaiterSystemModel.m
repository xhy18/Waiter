//
//  WaiterSystemModel.m
//  waiter
//
//  Created by renxin on 2019/4/11.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "WaiterSystemModel.h"

@implementation WaiterSystemModel
//初始化
-(void) initLanguageArray
{
    //获取当前的系统语言设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];

    if([defaults objectForKey:@"the_userDefaultLanguage"]){
        //为英文或其他
        NSLog(@"defaults:%@",[defaults objectForKey:@"the_userDefaultLanguage"]);
        NSLog(@"已经设置过了");
    }else{
        if([languages[0] containsString:@"zh-Hans"]){
            [defaults setObject:@"zh-Hans" forKey:@"the_userDefaultLanguage"];
        }else if([languages[0] containsString:@"fr"]){
            [defaults setObject:@"fr" forKey:@"the_userDefaultLanguage"];
        }else{
            [defaults setObject:@"en" forKey:@"the_userDefaultLanguage"];
        }
    }
    self.languageArray = [[NSMutableArray<SetLanguage *> alloc]init];
    for(int i=0 ;i<self.typeArray.count ;i++){
        SetLanguage * language = [[SetLanguage alloc]init];
        language.languageName = self.NameArray[i];
        language.languageType = self.typeArray[i];
        language.languageSmallName = self.SmallNameArray[i];
        language.wetherChoosed = NO;
        [self.languageArray addObject:language];
    }
    NSLog(@"currentLanguage:%@",[defaults objectForKey:@"the_userDefaultLanguage"]);
    if([[defaults objectForKey:@"the_userDefaultLanguage"] containsString:@"zh-Hans"]){
        NSLog(@" choose chinese");
        self.languageArray[2].wetherChoosed = YES;
    }else if ([[defaults objectForKey:@"the_userDefaultLanguage"] containsString:@"fr"]){
        NSLog(@"choose fr");
        self.languageArray[0].wetherChoosed = YES;
    }else{
        NSLog(@" choose eng");
        self.languageArray[1].wetherChoosed = YES;
    }
}
//根据点击的值，更新数组
-(void)SelectIndex:(NSUInteger)index HaveChangeLanguageArray:(LanguageArray)array{
    for(int i = 0; i < self.languageArray.count ;i++){
        //BOOL is = self.languageArray[i].wetherChoosed;
        //NSLog(@"is value:%@",is?@"yes":@"no");
        self.languageArray[i].wetherChoosed = NO;
        //s = self.languageArray[i].wetherChoosed;
        //NSLog(@"is newvalue:%@",is?@"yes":@"no");
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([self.languageArray[index].languageType containsString:@"zh-Hans"]){//系统默认语言为中文
        [defaults setObject:@"zh-Hans" forKey:@"the_userDefaultLanguage"];
        NSLog(@"reload chinese");
    }else if([self.languageArray[index].languageType containsString:@"fr"]){//为法文
        [defaults setObject:@"fr" forKey:@"the_userDefaultLanguage"];
        NSLog(@"reload fr");
    }else{//为英文或其他
        [defaults setObject:@"en" forKey:@"the_userDefaultLanguage"];
        NSLog(@"reload en");
    }
    self.languageArray[index].wetherChoosed = true;
    //设置多语言的值
    //回调改变后的值
    //NSLog(@"array：%@",_languageArray[index].languageName);
    array(self.languageArray);
}
@end
@implementation SetLanguage

@end
