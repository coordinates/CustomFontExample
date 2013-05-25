//
//  ViewController.m
//  CustomFontExample
//
//  Created by Masayoshi Ukida on 5/24/13.
//  Copyright (c) 2013 Masayoshi Ukida. All rights reserved.
//
#import <CoreText/CoreText.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // systemfont
    UIFont *systemFont = [UIFont systemFontOfSize:24.0f];
    UILabel *systemLabel = [[UILabel alloc] init];
    systemLabel.font = systemFont;
    systemLabel.text = @"abcdefあいうえお(system)";
    [self.view addSubview:systemLabel];
    [systemLabel sizeToFit];
    
    // UIAppFonts registered font
    UIFont *iapgFont = [UIFont fontWithName:@"IPAGothic" size:24.0f];
    UILabel *ipagLabel = [[UILabel alloc] init];
    ipagLabel.font = iapgFont;
    ipagLabel.text = @"abcdefあいうえお(IPAGothic)";
    CGRect ipagFrame = ipagLabel.frame;
    ipagFrame.origin.y = CGRectGetMaxY(systemLabel.frame);
    ipagLabel.frame = ipagFrame;
    [self.view addSubview:ipagLabel];
    [ipagLabel sizeToFit];
    
    // UIAppFonts no registered font
    // register the font dynamically
    NSString *ipamFilepath = [[NSBundle mainBundle] pathForResource:@"ipam" ofType:@"ttf"];
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithFilename([ipamFilepath UTF8String]);
    CGFontRef customFont = CGFontCreateWithDataProvider(fontDataProvider);
    CFErrorRef error = nil;
    CTFontManagerRegisterGraphicsFont(customFont, &error);  
    CGFontRelease(customFont);
    CGDataProviderRelease(fontDataProvider);
    
    UIFont *ipamFont = [UIFont fontWithName:@"IPAMincho" size:24.0f];
    UILabel *ipamLabel = [[UILabel alloc] init];
    ipamLabel.font = ipamFont;
    ipamLabel.text = @"abcdefあいうえお(IPAMincho)";
    CGRect ipamFrame = ipamLabel.frame;
    ipamFrame.origin.y = CGRectGetMaxY(ipagLabel.frame);
    ipamLabel.frame = ipamFrame;
    [self.view addSubview:ipamLabel];
    [ipamLabel sizeToFit];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
