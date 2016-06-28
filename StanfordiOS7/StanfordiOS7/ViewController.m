//
//  ViewController.m
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic,strong) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UISwitch *myswitch;

@end

@implementation ViewController

- (IBAction)cardClicked:(UIButton *)sender {
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}
- (IBAction)switchValueChanged:(UISwitch *)sender {
    
    if (sender.on == YES) {
        self.game.matchingCount = 3;
    }else{
        self.game.matchingCount = 2;
    }
}


- (IBAction)rePlay:(UIButton *)sender {
    [self.game rePlay];
    [self updateUI];
}



- (void)updateUI
{
    for (UIButton *cardButon in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:cardButon];
        Card *card = [self.game cardAtIndex:index];
        if (card.isMatched) {
            cardButon.enabled = NO;
        }else{
            cardButon.enabled = YES;
        }
        [cardButon setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButon setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        
        [_score setText:[NSString stringWithFormat:@"Score:%d",[self.game score]]];
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardBack"];
}




- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCount:[_cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
