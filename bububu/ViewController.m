//
//  ViewController.m
//  bububu
//
//  Created by MikamiKohei on 7/2/15.
//  Copyright (c) 2015 mikamikohei. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>



@interface ViewController ()

@end

@implementation ViewController {
    
    __weak IBOutlet UIButton *bububu;
    __weak IBOutlet UIButton *bububuThree;
    __weak IBOutlet UIButton *bububuFiveTime;
    SystemSoundID soundId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    soundId = kSystemSoundID_Vibrate;
}


- (IBAction)bububuTouch:(id)sender {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (IBAction)bububuThreeTime:(id)sender {
    char *isThree = "three";
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesAddSystemSoundCompletion(soundId,NULL,NULL,bububuBack,(void *)isThree);
}

- (IBAction)bububuFiveSecond:(id)sender {
    char *isFive = "fiveTime";
    AudioServicesAddSystemSoundCompletion(soundId,NULL,NULL,bububuBack,(void *)isFive);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerInfo:) userInfo:nil repeats:NO];
}


void bububuBack(SystemSoundID soundId, void *clientData) {
    
    char *receiveStr =(char*)clientData;
    if (strcmp(receiveStr, "three") == 0) {
        static int count = 0;
        count++;
        if (count < 3) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }else{
            AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
            count = 0;
        }
    }
    
    if (strcmp(receiveStr, "fiveTime") == 0) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}


-(void) timerInfo:(NSTimer *)timer {
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
