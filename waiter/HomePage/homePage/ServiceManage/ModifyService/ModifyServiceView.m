//
//  ModifyServiceView.m
//  waiter
//
//  Created by renxin on 2019/7/19.
//  Copyright © 2019年 renxin. All rights reserved.
//

#import "ModifyServiceView.h"
#import "Header.h"
#import "MyUtils.h"
#import "waiterTable.h"
@implementation ModifyServiceView

-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSDictionary *)dataArray{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI:@""];
        self.tableInfoDS = @[].mutableCopy;
        self.tableInfoDS = dataArray.mutableCopy;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame DataArry:(NSDictionary *)waiterArray waiterName:(NSString *)WaiterName{
    self = [super initWithFrame:frame];
    if(self){
        [self initUI:WaiterName];
        self.tableInfoDS = @[].mutableCopy;
        self.tableInfoDS = waiterArray.mutableCopy;
    }
    return self;
}

-(void)initUI:(NSString *)waiterName{
//    NSLog(@"modify");
    self.WaiterName = [[UILabel alloc]init];
    _WaiterName.text = [MyUtils GETCurrentLangeStrWithKey:@"serverManage_addName"];
    _WaiterName.backgroundColor = GRAYCOLOR;
    _WaiterName.font = [UIFont systemFontOfSize:14];
    [self addSubview:_WaiterName];
    
    self.waiterNameText = [[UITextField alloc]init];
    _waiterNameText.backgroundColor = GRAYCOLOR;
    if([waiterName isEqualToString:@""]){
    }
    else{
        _waiterNameText.text = waiterName;
        _oldName = waiterName;
    }
//    _waiterNameText.text = waiterName;
    _waiterNameText.font = [UIFont systemFontOfSize:14];
    [self addSubview:_waiterNameText];
    
    self.chooseTable = [[UILabel alloc]init];
    _chooseTable.text = [MyUtils GETCurrentLangeStrWithKey:@"serverManage_addTable"];
    _chooseTable.font = [UIFont systemFontOfSize:14];
    [self addSubview:_chooseTable];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(SCREENWIDTH/6.2, 55);
    self.tableView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"tableCell"];
    [self addSubview:_tableView];
    
    
    self.submitBtn = [[UIButton alloc]init];
    _submitBtn.backgroundColor = [UIColor colorWithRed:183.0/255.0 green:226.0/255.0 blue:255.0/255.0 alpha:1];
    _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _submitBtn.layer.cornerRadius = 30.0f;
    [_submitBtn setTitle:[MyUtils GETCurrentLangeStrWithKey:@"serverManage_addConfirm"] forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_submitBtn];
    [_submitBtn addTarget:self action:@selector(submitWaiter) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)layoutSubviews{

    self.WaiterName.frame = CGRectMake(15, 0, 60, 50);
    self.waiterNameText.frame = CGRectMake(75, 0, SCREENWIDTH-90, 50);
    self.chooseTable.frame = CGRectMake(15, _WaiterName.frame.origin.y + 50 +10, 100, 50);
    self.submitBtn.frame = CGRectMake(SCREENWIDTH/6, SCREENHEIGHT - 150, SCREENWIDTH*2/3, 60);
    self.tableView.frame = CGRectMake(15, _chooseTable.frame.origin.y + 50, SCREENWIDTH-30, SCREENHEIGHT - _chooseTable.frame.origin.y - 50);
}
-(void)submitWaiter{
    self.submitArray = [[NSMutableArray<NSDictionary *> alloc]init];
    for(NSInteger i = 0;i<_tableInfoDS.count;i++){
        if([_tableInfoDS[i].nowSelected isEqualToString:@"1"]){
            self.submitData = [[NSDictionary alloc]initWithObjectsAndKeys:_tableInfoDS[i].tableId,@"tableId",_tableInfoDS[i].tableName,@"tableName",nil];
            [self.submitArray addObject:self.submitData];
        }
    }
    
    if([self.waiterNameText.text isEqualToString:_oldName]){
        [_modifyWaiterDelegate addServerData:self.submitArray waiterName:self.waiterNameText.text type:@"0"];
    }
    else{
        [_modifyWaiterDelegate addServerData:self.submitArray waiterName:self.waiterNameText.text type:@"1"];
    }
}

//有多少个分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tableInfoDS.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tableCell" forIndexPath:indexPath];
    cell.backgroundColor = GRAYCOLOR;
    cell.layer.cornerRadius = 6.0f;
    UILabel * tableName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH/6.2, 55)];
    tableName.text = self.tableInfoDS[indexPath.row].tableName;
    tableName.textAlignment = NSTextAlignmentCenter;
    tableName.font = [UIFont systemFontOfSize:14];
    [cell addSubview:tableName];
    if([self.tableInfoDS[indexPath.row].currentSelected isEqualToString:@"1"]){
        cell.backgroundColor = MAINBLUECOLOR;
        cell.tag = 1;
        self.tableInfoDS[indexPath.row].nowSelected = @"1";
    }
    else{
        if([self.tableInfoDS[indexPath.row].selectedTable isEqualToString:@"1"]){
            cell.backgroundColor = [UIColor whiteColor];
            tableName.textColor = [UIColor colorWithRed:214.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1];
        }
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if([self.tableInfoDS[indexPath.row].selectedTable isEqualToString:@"0"] ||([self.tableInfoDS[indexPath.row].selectedTable isEqualToString:@"1"]&&[self.tableInfoDS[indexPath.row].currentSelected isEqualToString:@"1"])){
        if(cell.tag == 1){
            cell.backgroundColor = GRAYCOLOR;
            self.tableInfoDS[indexPath.row].nowSelected = @"0";
            cell.tag = 0;
        }
        else{
            cell.backgroundColor = MAINBLUECOLOR;
            self.tableInfoDS[indexPath.row].nowSelected = @"1";
            cell.tag = 1;
        }
        
    }
   

   
}
//调节item边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //    [self.mobileTF resignFirstResponder];
    //    [self.passwordTF resignFirstResponder];
    [self endEditing:YES];
}

@end
