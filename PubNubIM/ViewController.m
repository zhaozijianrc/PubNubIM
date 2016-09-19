//
//  ViewController.m
//  PubNubIM
//
//  Created by rc on 16/8/29.
//  Copyright © 2016年 rc. All rights reserved.
//

#import "ViewController.h"
#import "chatMessage.h"
#import "MessageTableViewCell.h"
#import "ZZJ_SqliteManager.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,PNObjectEventListener>

@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (weak, nonatomic) IBOutlet UITextField *mesageText;
@property (nonatomic,strong) chatMessage *chatMessage;
@end

@implementation ViewController{
    NSMutableArray *_messageArr;

}

- (void)awakeFromNib{

    [super awakeFromNib];
    _messageArr = [[NSMutableArray alloc]init];

}

-(chatMessage *)message{
    if (_chatMessage) {
        
        _chatMessage = [[chatMessage alloc]init];
    }
    return _chatMessage;

}

-(PubNub *)client{

    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] client] ;
}

- (NSString *)userId{

    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] userId];

}

-(void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"刚才设置的");
    NSLog(@"希望你检测出来");
    NSLog(@"nizhege zhazha");
    
    
    NSLog(@"控制器里的uuid%@",self.userId);
    _messageArr = [[ZZJ_SqliteManager shareManager]getAllChatMsgWithTargetUserId:@"hehe"];

    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
   
    [self.chatTableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"IN"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKey)];
    
    [self.chatTableView addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recevieMatchOrLikePush:) name:@"RESAVEMESSAGE" object:nil];
}

- (void)recevieMatchOrLikePush:(NSNotification *)noti{

    if ([noti.object[@"userID"]  isEqual: self.userId]) {
        chatMessage *meg = [[chatMessage alloc]init];
        
        NSString *megContent = noti.object[@"text"];
        NSLog(@"很难为我%@",megContent);
        
        [meg setValue:megContent forKey:@"megText"];
        [meg setValue:@(Outgoing)forKey:@"direction"];
        
        [_messageArr addObject:meg];
        
        [[ZZJ_SqliteManager shareManager] addMessage:meg];
        
        [self.chatTableView reloadData];
        self.mesageText.text = nil;
        
    }else {
        chatMessage *meg = [[chatMessage alloc]init];
        
        NSString *megContent = noti.object[@"text"];
        NSLog(@"很难为我%@",megContent);
        
        [meg setValue:megContent forKey:@"megText"];
        [meg setValue:@(Incoming)forKey:@"direction"];
        
        [_messageArr addObject:meg];
        
        [[ZZJ_SqliteManager shareManager] addMessage:meg];
        
        [self.chatTableView reloadData];
        self.mesageText.text = nil;
    }

}

- (void)closeKey{

    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{

    NSLog(@"模型个数%zd",_messageArr.count);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


//    return self.messageArr.count;
    return _messageArr.count;

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    _chatMessage = _messageArr[indexPath.row];
    MessageTableViewCell *cell = [self dequeOrLoadMessageTableViewCell:_chatMessage.direction];
    
    cell.textLable.text = _chatMessage.megText;
    
    return cell;
        
}

- (MessageTableViewCell *)dequeOrLoadMessageTableViewCell:(MessageDirection)direction {
    NSString *identifier =
    [NSString stringWithFormat:@"%@", (Outgoing == direction) ? @"OutGoingCellTableViewCell" : @"IncomingTableViewCell"];
    //    Incoming  OutGoingCellTableViewCell
    MessageTableViewCell *cell = [self.chatTableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil][0];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}


- (IBAction)sendAction:(id)sender {
    NSLog(@"模型个数%zd",_messageArr.count);
//    self.RorO = NO;
    chatMessage *meg = [[chatMessage alloc]init];
    
    
    [meg setValue:self.mesageText.text forKey:@"megText"];
    [meg setValue:@(Outgoing)forKey:@"direction"];
    //    NSDictionary *dict = @{@"text" : self.mesageText.text ,@"direction" : @(Outgoing)};
    
    //    [_messageArr addObject:meg];

    //    [self.chatTableView reloadData];
    
    //    [[ZZJ_SqliteManager shareManager] addMessage:meg];
    
    //    self.mesageText.text = nil;

    NSDictionary *dict = @{@"text" : self.mesageText.text ,@"userID" : self.userId};
    
    NSLog(@"模型个数%zd",_messageArr.count);
    

    [self.client publish:dict toChannel:@"my_channel12" withCompletion:^(PNPublishStatus * _Nonnull status) {
        NSLog(@"hahah");
        
}];
    
        NSLog(@"模型个数%zd",_messageArr.count);

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
