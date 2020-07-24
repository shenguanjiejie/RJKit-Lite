//
//  RJChooseVC.m
//  deyue
//
//  Created by ShenRuijie on 2017/6/20.
//  Copyright © 2017年 mikeshen. All rights reserved.
//

#import "RJChooseVC.h"
//#import "RJAFNTool.h"
#import "DoneTableCell.h"


@interface RJChooseVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    RJChooseCompletionBlock _completion;
}
@end

@implementation RJChooseVC

#pragma mark - Life Cycle

- (instancetype)init{
    return [self initWithCompletion:nil];
}

- (instancetype)initWithCompletion:(RJChooseCompletionBlock)completion
{
    self = [super init];
    if (self) {
        _shouldAdd = NO;
        _shouldMultiSelect = NO;
        _autoBack = YES;
        _completion = completion;
        _data = [NSArray array];
        _selects = [NSMutableArray array];
        _textColor = kBlackColor;
        _selectedTextColor = kGreenColor;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [self setNavigationBarViewWithBackMsg:nil backSelector:@selector(normalBack)];
        self.title = self.title.length?self.title:@"请选择";
    }
    if (self.backgroundColor) {
        self.view.backgroundColor = self.backgroundColor;
    }else{
        self.view.backgroundColor = kBackgroundColor;
    }
    
    //初始化参数
    [self variableInit];
    
    //设置Views
    [self setViews];
    
    //获取数据
    [self getData];
    
    if (self.viewDidLoadBlock) {
        self.viewDidLoadBlock();
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self.parentViewController isKindOfClass:[UINavigationController class]]) {
        self.navigationController.navigationBar.hidden = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)variableInit{
    
}

- (void)getData{
    
}

- (void)reloadData{
    
}

#pragma mark ----setViews

- (void)setViews{
#pragma mark <#headerView#>
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = 5;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:views]];
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [self.navigationBarView addBottomConstraintToView:_tableView constant:0];
        [self.view addBottomAlignConstraintToView:_tableView constant:0];
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_tableView]|" options:0 metrics:nil views:views]];
    }else{
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:views]];
    }
}

#pragma mark - Event Response


- (void)normalBack{
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)back{
    if (_completion) {
        _completion(self,_selects);
    }
    if ([self.parentViewController isKindOfClass:[UINavigationController class]] && _autoBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Private Methods
- (void)setData:(NSArray<RJChooseItem *> *)data{
    _data = data;
    
    for (RJChooseItem *model in data) {
        if (model.state == RJChooseItemStateSelected) {
            [_selects addObject:model];
        }
    }
}

#pragma mark - UITableViewDelegate & tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.shouldMultiSelect) {
        return self.data.count + 1;
    }
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.data.count) {
        return 74;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        return 5;
    }
    return 0.0000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RJChooseItem *model = self.data[indexPath.row];
    if (model.state == RJChooseItemStateSelected) {
        if (self.shouldMultiSelect) {
            if (self.selects.count > 1) {
                model.state = RJChooseItemStateNone;
                [_selects removeObject:model];
            }
        }else{
            [self back];
        }
    }else{
        model.state = RJChooseItemStateSelected;
        
        if (self.shouldAdd && model.ID == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
                textField.placeholder = @"请输入";
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirmlAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                model.text = [[alertController.textFields firstObject] text];
                if (self.shouldMultiSelect) {
                    [self.selects addObject:model];
                }else{
                    for (RJChooseItem *model in self.selects) {
                        model.state = RJChooseItemStateNone;
                    }
                    [self.selects removeAllObjects];
                    [self.selects addObject:model];
                    [self back];
                }
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:confirmlAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            if (self.shouldMultiSelect) {
                [_selects addObject:model];
            }else{
                for (RJChooseItem *model in _selects) {
                    model.state = RJChooseItemStateNone;
                }
                [_selects removeAllObjects];
                [_selects addObject:model];
                [self back];
            }
        }
    }
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.data.count) {
        static NSString *cellIdentifier = @"DoneCell";
        DoneTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[DoneTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.doneBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [cell.doneBtn setTitle:@"保存" forState:UIControlStateNormal];
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = kFontSize(13);
        
        UIImageView *rightIV = [[UIImageView alloc]init];
        rightIV.tag = 11;
        rightIV.translatesAutoresizingMaskIntoConstraints = NO;
        rightIV.contentMode = UIViewContentModeCenter;
        rightIV.image = kImageNamed(correct1);
        [cell.contentView addSubview:rightIV];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(rightIV);
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightIV(30)]-15-|" options:0 metrics:nil views:views]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightIV]|" options:0 metrics:nil views:views]];
    }
    
    UIImageView *rightIV = [cell.contentView viewWithTag:11];
    RJChooseItem *model = self.data[indexPath.row];
    cell.textLabel.text = model.text;
    
    if (model.state == RJChooseItemStateSelected || model.state == RJChooseItemStateFilterAndSelected) {
        rightIV.hidden = NO;
        cell.textLabel.textColor = self.selectedTextColor;
    }else{
        rightIV.hidden = YES;
        cell.textLabel.textColor = self.textColor;
    }
    
    return cell;
}


@end
