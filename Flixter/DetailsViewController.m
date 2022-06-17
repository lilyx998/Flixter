//
//  DetailsViewController.m
//  Flixter
//
//  Created by Lily Yang on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropImage;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Title
    self.titleLabel.text = self.data[@"title"];
    
    // Synopsis
    self.synopsisLabel.text = self.data[@"overview"];
    
    // Backdrop
    NSString *backdropURLPrefix = @"https://image.tmdb.org/t/p/w500";
    NSString *backdropURLSuffix = self.data[@"backdrop_path"];
    NSString *backdropURLString = [backdropURLPrefix stringByAppendingString:backdropURLSuffix];
    
    NSURL *backdropURL = [NSURL URLWithString:backdropURLString];
    [self.backdropImage setImageWithURL:backdropURL];
    
    
    // Poster
    NSString *posterURLPrefix = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLSuffix = self.data[@"poster_path"];
    NSString *posterURLString = [posterURLPrefix stringByAppendingString:posterURLSuffix];
    
    NSURL *posterURL = [NSURL URLWithString:posterURLString];
    [self.posterImage setImageWithURL:posterURL];
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
