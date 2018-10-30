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
    return 5;//TODO get a random number
}
int getComputerGuess(){
    
    return 8;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        BOOL isPlaying = YES;
        enum state gameState = intro;
        enum dificulty computerDificulty;
        int guess;
        int answer;
        int guessesLeft = 5;
        char keepPlaying;
        
        
        
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
                    
                    printf("What type of game do you want to play?\n");
                    printf("\n");
                    printf("1) I'll guess 2)Gumber should guess\n" );
                    int option;
                    scanf(" %i",&option);
                    if(option == 1){
                        gameState = playerGuessing;
                        answer = setUpPlayerGuess();
                        guessesLeft = 5;
                        
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
                        computerDificulty = medium;
                        
                    }else{
                        printf("your answer doesn't make sense...\n");
                        printf("I'll ask you again...\n");
                        break;
                    }
                    printf("\n");
                    printf("ok, think of a number between 0 and 100\n");
                    printf("a whole number mind you, no decimals\n");
                    printf("press any key when you are ready...\n");
                    printf("\n");
                    gameState = computerGuessing;
                    scanf("");
                    break;
                case computerGuessing:
                    printf("I have %i guesses left...",guessesLeft);
                    guess = getComputerGuess();
                    printf("is your number 5?\n");
                    printf("1. yes, my number was %i\n",guess);
                    printf("2. too low %i\n",guess);
                    printf("3. too high %i\n",guess);
                    printf("\n");
                    scanf(" %c",&keepPlaying);
                    if(keepPlaying == 'y'){
                        printf("A HA!! I win again!\n");
                        printf("would you like to play again?\n");
                        gameState = wantToPlay;
                    }
                    break;
                    
            }
        }
    }
    return 0;
}
