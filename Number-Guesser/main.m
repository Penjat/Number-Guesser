//
//  main.m
//  Number-Guesser
//
//  Created by Spencer Symington on 2018-10-30.
//  Copyright © 2018 Spencer Symington. All rights reserved.
//

enum state {
    intro,
    gameType,
    playerGuessing,
    computerGuessing,
    wantToPlay,
    computerLose,
    playerLose,
    selectDificulty,
    goodbye
    
};
enum dificulty{
    easy,
    medium,
    hard
    
};

#import <Foundation/Foundation.h>
int setUpPlayerGuess(){
    printf("Alright!\n");
    printf("I am thinking of a number between 0 and 100\n");
    return arc4random_uniform(101);
}
BOOL checkIfAlreadyGuessed(int guess,NSMutableArray * pastGuesses){
    //returns YES if already guessed, NO if it is a new guess
    for (NSNumber * num in pastGuesses) {
        if([num intValue] == guess){
            return YES;
        }
        
    }
    return NO;
}
int getComputerGuess(enum dificulty computerDificulty, int higherThan, int lowerThan){
    
    
    
    if(computerDificulty == easy){
        NSLog(@"easy guess");
        return arc4random_uniform(101);
    }else if(computerDificulty == medium){
        NSLog(@"medium guess");
        return (arc4random_uniform(lowerThan - 1 - higherThan) + higherThan+1);
    }
    NSLog(@"hard guess");
    return ((lowerThan - higherThan)/2 + higherThan);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BOOL isPlaying = YES;
        enum state gameState = intro;
        enum dificulty computerDificulty;
        int guess;
        int answer;
        int guessesLeft = 5;
        int higherThan = -1;
        int lowerThan = 101;
        char keepPlaying;
        
        NSMutableArray * pastGuesses = [[NSMutableArray alloc] init];
        
        while(isPlaying){
            switch(gameState){
                case intro:
                    printf("Welcome to number guess.\n");
                    printf("I am your host Gumber Ness.\n");
                    printf("\n");
                    printf("do you want to play? (y/n) \n");
                    printf("\n");
                    gameState = wantToPlay;
                    break;
                    
                    
                case gameType:
                    [pastGuesses removeAllObjects];
                    printf("What type of game do you want to play?\n");
                    printf("\n");
                    printf("1) I'll guess\n" );
                    printf("2)Gumber should guess\n" );
                    printf("\n");
                    int option;
                    scanf(" %i",&option);
                    guessesLeft = 5;
                    if(option == 1){
                        gameState = playerGuessing;
                        answer = setUpPlayerGuess();
                        
                        
                    }else if(option == 2){
                        gameState = selectDificulty;
                        printf("ok, I'll do the guessing.\n");
                    }else{
                        printf("um...\n");
                        printf("\n");
                        printf("I think you might be confused...");
                        printf("let's try again...\n");
                        printf("\n");
                        
                    }
                    break;
                    
                case goodbye:
                    printf("*sigh* ok then...");
                    printf("Goodbye.");
                    isPlaying = NO;
                    break;
                    
                case wantToPlay:
                    
                    
                    scanf(" %c", &keepPlaying);
                    if(keepPlaying == 'y'){
                        gameState = gameType;
                        printf("Great!\n");
                    }else{
                        gameState = goodbye;
                    }
                    break;
                case playerLose:
                    printf("sorry dude...\n");
                    printf("you have no more guesses left.\n");
                    printf("the number I was thinking of was %i\n",answer);
                    printf("\n");
                    printf("do you want to play again? \n");
                    gameState = wantToPlay;
                    break;
                case playerGuessing:
                    //check if guessesLeft
                    if(guessesLeft <= 0){
                        gameState = playerLose;
                        break;
                    }
                    
                    
                    printf("you have %i guesses left.\n",guessesLeft);
                    printf("what do you guess?\n");
                    scanf(" %i",&guess);
                    
                    //check if already guessed that number
                    if(checkIfAlreadyGuessed(guess,pastGuesses)){
                        printf("you already guessed %i\n",guess);
                         printf("\n",guess);
                        break;
                    }
                    
                    //if not guessed add it to pastGuessed
                    [pastGuesses addObject:[[NSNumber alloc]initWithInt:guess]];
                    
                    if(guess == answer){
                        printf("You guessed it!!!\n");
                        printf("\n");
                        printf("do you want to play again? (y/n)\n");
                        gameState = wantToPlay;
                    }else if (guess < answer){
                        printf("too low.\n");
                        guessesLeft--;
                    }else if (guess > answer){
                        guessesLeft--;
                        printf("too high.\n");
                    }
                    //TODO check for repeat guesses
                    //TODO check for valid answer
                    break;
                    
                case selectDificulty:
                    printf("\n");
                    printf("how well should I play?\n");
                    printf("\n1.really dumb\n");
                    printf("2.just ok\n");
                    printf("3.really smart\n");
                    scanf(" %i",&option);
                    if(option == 1){
                        computerDificulty = easy;
                        
                    }else if(option == 2){
                        computerDificulty = medium;
                        
                    }
                    else if(option == 3){
                        computerDificulty = hard;
                        
                    }else{
                        printf("your answer doesn't make sense...\n");
                        printf("I'll ask you again...\n");
                        break;
                    }
                    higherThan = -1;
                    lowerThan = 101;
                    printf("\n");
                    printf("ok, think of a number between 0 and 100\n");
                    printf("a whole number mind you, no decimals\n");
                    printf("press ENTER when you are ready...");
                    printf("\n");
                    gameState = computerGuessing;
        
                    break;
                    
                    
                case computerLose:
                    
                    printf("awe rats, I am out of guesses\n");
                    printf("what was your number?\n");
                    scanf(" %i",&guess);
                    if(guess <= higherThan){
                        printf("but you said your number was higher than %i ?!?",higherThan);
                        printf("A HA, I win by default!!!");
                    }else if(guess >= lowerThan){
                        printf("but you said your number was lower than %i ?!?",higherThan);
                        printf("A HA, I win by default!!!");
                    }else{
                        printf("ahhh, %i I should have guessed...",guess);
                    }
                    
                    printf("would you like to play again?\n");
                    printf("( y/n ))\n");
                    gameState = wantToPlay;
                    break;
                    
                case computerGuessing:
                    if(guessesLeft <= 0){
                        gameState = computerLose;
                        break;
                    }
                    
                    printf("I have %i guesses left...",guessesLeft);
                    guess = getComputerGuess(computerDificulty,higherThan,lowerThan);
                    printf("is your number %i?\n",guess);
                    printf("\n");
                    printf("1. yes, my number was %i\n",guess);
                    printf("2. %i is too low \n",guess);
                    printf("3. %i is too high \n",guess);
                    printf("\n");
                    scanf(" %i",&option);
                    
                    if(option == 1){
                        printf("A HA!! I win again!\n");
                        printf("would you like to play again?\n");
                        printf("(y/n)\n");
                        gameState = wantToPlay;
                    }else if(option == 2){
                        higherThan = guess;
                        guessesLeft--;
                        printf("hmmm, too hlow... \n");
                    }
                    else if(option == 3){
                        lowerThan = guess;
                        guessesLeft--;
                        printf("hmmm, too high... \n");
                    }else{
                        
                    }
                    break;
                    
            }
        }
    }
    return 0;
}
