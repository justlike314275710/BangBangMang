//
//  LegalAdviceCell.h
//  GKHelpOutApp
//
//  Created by kky on 2019/2/26.
//  Copyright © 2019年 kky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSConsultation.h"
@interface LegalAdviceCell : UITableViewCell

@property (nonatomic,assign)BOOL noRead;
-(void)fillWithModel:(PSConsultation*)model;
@end


