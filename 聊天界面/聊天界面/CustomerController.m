//
//  CustomerController.m
//  融云测试
//
//  Created by  王伟 on 2016/12/3.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "CustomerController.h"
#import "MessageCell.h"
#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT     [UIScreen mainScreen].bounds.size.height
@interface CustomerController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *MessageArr;
@property (nonatomic,strong) UIView *inputView;
@property (nonatomic,strong) UITextView *inputTextView;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,assign) BOOL Temp;
@end

@implementation CustomerController
static NSString *identifier = @"Cell";
-(NSMutableArray *)MessageArr {
    if (!_MessageArr) {
        _MessageArr = [NSMutableArray array];
    }
    return _MessageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"客服一";
    //构造消息对象请用+ (instancetype) messageWihtContent:(NSString *)content isRight:(BOOL)isRight
    Message *msg = [Message messageWihtContent:@"你这死基佬！喊老子干嘛？死了都不能安生！" isRight:NO];
    [self.MessageArr addObject:msg];
    
    Message *msg1 = [Message messageWihtContent:@"大哥！他们欺负俺。。。怎么做都各种不满意啊、来回被轮了几遍了" isRight:YES];

    [self.MessageArr addObject:msg1];
    
    Message *msg2 = [Message messageWihtContent:@"法克！这点屁事也来烦我！他们哪里混的啊？迈阿密？看我不抽死他！" isRight:NO];

    [self.MessageArr addObject:msg2];

    Message *msg3 = [Message messageWihtContent:@"不系啊。。。大中华！深圳华强北。。。" isRight:YES];

    [self.MessageArr addObject:msg3];

    Message *msg4 = [Message messageWihtContent:@"我去！老子已经挂了。。。有事烧纸" isRight:NO];
    [self.MessageArr addObject:msg4];

    Message *msg5 = [Message messageWihtContent:@"..." isRight:YES];
    [self.MessageArr addObject:msg5];
    [self.MessageArr addObject:msg5];
    [self.MessageArr addObject:msg5];
    [self.MessageArr addObject:msg5];
    [self.MessageArr addObject:msg5];
    [self.MessageArr addObject:msg5];
    [self.MessageArr addObject:msg5];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:identifier];
    
    self.inputView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 50,SCREENWIDTH , 50)];
    self.inputView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    self.inputView.layer.borderColor = [UIColor grayColor].CGColor;
    self.inputView.layer.borderWidth = 0.5;
    self.inputView.layer.masksToBounds = YES;
    [self.view addSubview:self.inputView];
    
    
    self.inputTextView = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, SCREENWIDTH - 100, 30)];
    self.inputTextView.layer.cornerRadius = 6;
    self.inputTextView.layer.borderWidth = 0.5;
    self.inputTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.inputTextView.layer.masksToBounds = YES;
    [self.inputView addSubview:self.inputTextView];
    
    self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 70, 10, 60, 30)];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.sendBtn.layer.cornerRadius = 4;
    self.sendBtn.layer.borderWidth = 0.5;
    self.sendBtn.backgroundColor = [UIColor whiteColor];
    self.sendBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.sendBtn.layer.masksToBounds = YES;
    [self.sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    self.sendBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.sendBtn.enabled = NO;
    [self.sendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.inputView addSubview:self.sendBtn];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.MessageArr.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.MessageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.message = self.MessageArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Message *msg = self.MessageArr[indexPath.row];
    return msg.bounds.size.height;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void) sendMessage {
    self.Temp = !self.Temp;
    Message *msg = [Message messageWihtContent:self.inputTextView.text isRight:self.Temp];
    [self.MessageArr addObject:msg];
    [self.tableView reloadData];
    self.inputTextView.text = @"";
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.MessageArr.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.sendBtn.enabled = NO;
    [self.sendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
}

-(void)openKeyboard:(NSNotification*)notification{
    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSTimeInterval durition = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions option = [notification.userInfo [UIKeyboardAnimationCurveUserInfoKey]intValue];
    [UIView animateWithDuration:durition delay:0 options:option animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50 - frame.size.height);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.MessageArr.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        self.inputView.frame = CGRectMake(0, SCREENHEIGHT - 50 - frame.size.height,SCREENWIDTH , 50);
    } completion:nil];
}

-(void)closeKeyboard:(NSNotification*)notification{
    NSTimeInterval durition = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions option = [notification.userInfo [UIKeyboardAnimationCurveUserInfoKey]intValue];
    [UIView animateWithDuration:durition delay:0 options:option animations:^{
        self.inputView.frame = CGRectMake(0, SCREENHEIGHT - 50 ,SCREENWIDTH , 50);
        self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    } completion:nil];
}

-(void)textViewDidChange:(NSNotification*)notification{
    if (self.inputTextView.text.length > 0) {
        self.sendBtn.enabled = YES;
        [self.sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    } else {
        self.sendBtn.enabled = NO;
        [self.sendBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



@end
