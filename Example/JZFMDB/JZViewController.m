//
//  JZViewController.m
//  JZFMDB
//
//  Created by jason8zhang on 06/12/2019.
//  Copyright (c) 2019 jason8zhang. All rights reserved.
//

#import "JZViewController.h"
#import "JZFMDBHelper.h"
#import "JZFMDB-Prefix.pch"
#import "BookModel.h"
#import <YYKit/YYKit.h>
#define LIBRARY_FOLDER(fileName) [[NSHomeDirectory() stringByAppendingPathComponent:@"Library"]stringByAppendingPathComponent:fileName]
@interface JZViewController ()

@end

@implementation JZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // 1.模拟返回的 json
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bookmodel" ofType:@"json"]];
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    

    BookModel *bookModel = [BookModel modelWithJSON:json];
    

    [JZFMDBTools setDebugEnable:YES];
//    [JZFMDBTools syncSaveModel:json inTable:nil];
//    [JZFMDBTools syncSaveDic:json inTable:nil];
    [JZFMDBTools syncSaveArray:bookModel.result.authornovels];
//    [JZFMDBTools initTable:NSStringFromClass([BookModel class]) withModel:bookModel.result.authornovels];
    
//    [JZFMDBTools syncUpdateTable:@"AuthornovelsClass" model:nil where:<#(nonnull NSString *)#>]
//    [JZFMDBTools asyncUpdateTable:@"AuthornovelsClass" class:NSClassFromString(@"AuthornovelsClass") where:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"cbid"),@"9735328300524203"]];
    
    
//    [JZFMDBTools syncInsertModel:[self getBookModel] inTable:@"AuthornovelsClass"];
//    AuthornovelsClass *model = [self getBookModel];
//
//    [JZFMDBTools syncUpdateTable:@"AuthornovelsClass" model:[self getBookModel] where:[NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"cbid"),@"14020079200208004"]];
    
//    [JZFMDBTools asyncUpdateTable:<#(NSString * _Nullable)#> class:<#(nonnull Class)#> keyvalues:<#(nonnull NSString *), ...#>]
//    [JZFMDBTools syncUpdateTable:@"AuthornovelsClass" model:[self getBookModel] keyvalues:@"cbid",@"14020079200208004"];
    
//    NSLog(@"---> %@",[JZFMDBTools]);
//    NSLog(@"----> %@",[JZFMDBTools syncQueryTable:@"AuthornovelsClass" class:[AuthornovelsClass class] keyvalues:@"novelid",@"0001"]);
//    [JZFMDBTools syncDeleteItemInTable:@"AuthornovelsClass" keyValues:@"novelid",@"0001"];
//    NSLog(@"---> pageNo = 0 pageSize =3 ---> %@",[JZFMDBTools syncQueryTable:@"AuthornovelsClass"
//                                                                       class:[AuthornovelsClass class]
//                                                                       range:NSMakeRange(1, 3)
//                                                                     orderBy:nil
//                                                                        desc:YES]);
//                                                                            :
//                                                                             class:
//                                                                           pageNum:1
//                                                                          pageSize:3
//                                                                           orderBy:nil
//                                                                              desc:YES]);
    
//   NSLog(@"---> %@", [JZFMDBTools syncQueryTable:@"AuthornovelsClass" class:[AuthornovelsClass class] byKey:@"cbid" value:@"14020079200208004"]);
//    [JZFMDBTools syncDeleteItemInTable:@"AuthornovelsClass" keyValues:@"cbid",@"14020079200208004"];
//    NSLog(@"-----> %@",[JZFMDBTools syncQueryTable:@"AuthornovelsClass" class:[AuthornovelsClass class] keyvalues:@"cbid",@"14020079200208004"]);
    NSLog(@"----> %@",LIBRARY_FOLDER(@""));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AuthornovelsClass *)getBookModel {
    NSData *data1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newbook" ofType:@"json"]];
    NSDictionary * jsonnewBookdic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    return [AuthornovelsClass modelWithJSON:jsonnewBookdic];
}

@end
