//
//  LiveRoomSettingSeparationView.m
//  YxzChatFramework
//
//  Created by 颜学宙 on 2020/7/31.
//  Copyright © 2020 颜学宙. All rights reserved.
//

#import "LiveRoomSettingSeparationView.h"
#import "YXZConstant.h"
#import <Masonry/Masonry.h>
@interface LiveRoomSettingSeparationView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)UITableView *tableView;
@end


@implementation LiveRoomSettingSeparationView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.userInteractionEnabled=YES;
    self.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.tableView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
//        make.height.equalTo(self.mas_height).multipliedBy(0.45);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.containerView);
    }];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}
-(void)setPlayerModel:(YxzPlayerModel *)playerModel{
    _playerModel=playerModel;
    NSMutableArray *array=[NSMutableArray array];
    for (SuperPlayerUrl *pu in _playerModel.multiVideoURLs) {
        RoomSeparationModel *m=[RoomSeparationModel new];
        m.title=pu.title;
        m.videoUrl=pu.url;
        if ([_playerModel.playingDefinition isEqualToString:pu.title]) {
            m.isCheck=YES;
        }else{
            m.isCheck=NO;
        }
        [array addObject:m];
    }
    self.dataSouce=array;
    [self.tableView reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataSouce) {
        return self.dataSouce.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveRoomSeparationCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LiveRoomSeparationCell"];
    RoomSeparationModel *model=self.dataSouce[indexPath.row];
    cell.model=model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   RoomSeparationModel *model=self.dataSouce[indexPath.row];
    if (self.block) {
        self.block(model.title, model.videoUrl);
    }
}
-(UITableView *)tableView{
    if (!_tableView) {
       _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollEnabled=YES;
        //_tableView.estimatedRowHeight = 40;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive|UIScrollViewKeyboardDismissModeOnDrag;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.sectionFooterHeight = 0;
//        _tableView.sectionHeaderHeight = 0;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[LiveRoomSeparationCell class] forCellReuseIdentifier:@"LiveRoomSeparationCell"];
    
    }
    return _tableView;
}

-(UIView *)containerView{
    if (!_containerView) {
        _containerView=[[UIView alloc]init];
        _containerView.backgroundColor=[UIColor whiteColor];
        _containerView.userInteractionEnabled=YES;
    }
    return _containerView;
}
@end
@interface LiveRoomSeparationCell()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *checkImage;
@end
@implementation LiveRoomSeparationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
     self.selectionStyle  = UITableViewCellSelectionStyleNone;
    [self addSubview:self.titleLabel];
    [self addSubview:self.checkImage];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    [self.checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.height.mas_equalTo(25);
    }];
}
-(void)setModel:(RoomSeparationModel *)model{
    _model=model;
    self.titleLabel.text=_model.title;
    if (model.isCheck) {
        self.checkImage.image=YxzSuperPlayerImage(@"xuanze");
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.textColor=[UIColor blackColor];
    }else{
        self.checkImage.image=nil;
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.textColor=RGBA_OF(0x999999);
    }
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:14];
        _titleLabel.textColor=RGBA_OF(0x999999);
    }
    return _titleLabel;
}
- (UIImageView *)checkImage{
    if (!_checkImage) {
        _checkImage=[[UIImageView alloc]init];
    }
    return _checkImage;
}
@end
@implementation RoomSeparationModel

@end
