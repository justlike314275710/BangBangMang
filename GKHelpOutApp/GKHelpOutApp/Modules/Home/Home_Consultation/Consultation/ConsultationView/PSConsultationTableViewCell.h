//
//  PSConsultationTableViewCell.h
//  PrisonService
//
//  Created by 狂生烈徒 on 2018/10/29.
//  Copyright © 2018年 calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "LLImagePickerView.h"


@interface PSConsultationTableViewCell : UICollectionViewCell
@property (nonatomic , strong) UIButton *choseButton;
@property (nonatomic , strong) UITextView *contentTextView;
@property (nonatomic , strong) UITextField *contentTextField;
@property (nonatomic , strong) UIButton *albumButton;
@property (nonatomic , strong) UIButton *cameraButton;
@property (nonatomic , strong) UIButton *fileButton;
//@property (nonatomic , strong) LLImagePickerView *pickerV ;
@end
