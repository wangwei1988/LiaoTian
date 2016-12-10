//
//  AppDelegate.h
//  聊天界面
//
//  Created by  王伟 on 2016/12/4.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "CustomerController.h"
#import "MessageCell.h"
#import "HCInputBar.h"
#import "MessageImageCell.h"
#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT     [UIScreen mainScreen].bounds.size.height
@interface CustomerController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) HCInputBar *inputBar;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *MessageArr;

@property (nonatomic,strong) UIView *inputView;
@property (nonatomic,strong) UITextView *inputTextView;
@property (nonatomic,strong) UIButton *sendBtn;

@property (nonatomic,strong) UIButton *statusBtn;

@property (nonatomic,assign) BOOL Temp;

@property (nonatomic,strong) UIImagePickerController *picker;

@end

@implementation CustomerController
static NSString *identifier = @"Cell";
static NSString *identifierMessageImageCell = @"MessageImageCell";
-(NSMutableArray *)MessageArr {
    if (!_MessageArr) {
        _MessageArr = [NSMutableArray array];
    }
    return _MessageArr;
}

- (HCInputBar *)inputBar {
    if (!_inputBar) {
        
        _inputBar = [[HCInputBar alloc]initWithStyle:DefaultInputBarStyle];
        
        _inputBar.keyboard.showAddBtn = NO;
        
        _inputBar.placeHolder = @"输入新消息";
        

    }
    return _inputBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"老大";
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.delegate = self;
    __block typeof(self) weakSelf = self;
    self.inputBar.chooseImages = ^{
        [weakSelf presentViewController:weakSelf.picker animated:YES completion:nil];
    };
    
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:identifier];
    [self.tableView registerClass:[MessageImageCell class] forCellReuseIdentifier:identifierMessageImageCell];
    
    [self.view addSubview:self.inputBar];
    [self.inputBar showInputViewContents:^(NSString *contents) {
        self.Temp = !self.Temp;
        Message *msg = [Message messageWihtContent:contents isRight:self.Temp];
        [self.MessageArr addObject:msg];
        [self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.MessageArr.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];

    
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
    MessageImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:identifierMessageImageCell];
    Message *msg = self.MessageArr[indexPath.row];
    
    if (msg.image != nil) {
        imageCell.message = msg;
        return imageCell;
    }
    cell.message = msg;
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


-(void)openKeyboard:(NSNotification*)notification{
    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSTimeInterval durition = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions option = [notification.userInfo [UIKeyboardAnimationCurveUserInfoKey]intValue];
    [UIView animateWithDuration:durition delay:0 options:option animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50 - frame.size.height);
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.MessageArr.count - 1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    } completion:nil];
}

-(void)closeKeyboard:(NSNotification*)notification{
    NSTimeInterval durition = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    UIViewAnimationOptions option = [notification.userInfo [UIKeyboardAnimationCurveUserInfoKey]intValue];
    [UIView animateWithDuration:durition delay:0 options:option animations:^{
        
        self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    } completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - UIImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    
    if (image != nil) {
        [self performSelector:@selector(SendImage:)  withObject:image afterDelay:0.5];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)SendImage:(UIImage *)image {
    self.Temp = !self.Temp;
    Message *msg = [Message messageWihtImage:image isRight:self.Temp];
    [self.MessageArr addObject:msg];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.MessageArr.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}




@end
