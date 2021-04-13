//
//  DSYAdViewController.m
//  Budejie
//
//  Created by opooc on 2021/4/14.
//

#import "DSYAdViewController.h"

@interface DSYAdViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;

@end

@implementation DSYAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch ((int)DSYScreenH) {
        case iphone6P://8
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
            break;
        case iphone6://6
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
            break;
        case iphone5://5
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
            break;
        case iphone4:
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage"];
            break;
        default:
            self.LaunchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
            break;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
