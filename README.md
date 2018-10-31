# Number-Guesser
Command line game.  Guesses the computer's number or have the computer guess yours.

The game has two modes: Player guess and Computer Guess

When the player guesses, the computer secretly chooses a number between 0 and 100.  The player has 5 guesses to find the correct number.  The computer will respond with too low, or too high for each guess.  The program keeps track of the player's guesses and if the player guesses the same number more than once, it will not count as a guess and the player will be asked to choose again.

When the computer guesses. there are 3 difficulty levels, "really dumb", "just ok", and "really smart".

On "really dumb", the computer simply randomly guesses numbers between 0 and 100 regaurdless if you tell it to high or too low.

On "just ok", the computer will pay attention to your too low/too high answers and pick a random number between the current too-highest and too-lowest.

For really smart the computer basically uses your too low/too high responses to perform a binary sort, choosing the mid point of the possibilites every time.

For the computer guesses game mode, the play is asked to choose a number but not to enter it into the program.  After the computer is out of guesses, the player is prompted to enter their number.  If it turns out the player was dishonest about their number (for example: their number was 33 but they said it was higher than 50) the computer will call them out and pronounce themself winner by default.

