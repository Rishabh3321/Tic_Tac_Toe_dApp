# Requirements
## Create a simple dapp
    This should simulate tic tac toe game on which participating players can bet using
    ether/erc20 token.
## Specs
    1. Player 1 creates a new game specifying & depositing bet in ether or erc20 token
    2. Player 2 accepts the challenge & deposits matching amount
    3. The game begins once Player 2 makes first move
    4. Once winner is decided, move locked funds to winner's address. Normal tic tac toe rules apply.

# Solution

## Workflow of game
    1. Both Players first place their bets, before that game couldn't be start.
    2. Then we intialise the game by providing both the adresses.
    3. Now onwards only these players can take their moves one by one. 
    4. In case one of them wins the game, total prize is transfered to the winner. 
    5. In case of draw, their respective ammount is transfered back to them.

## Video Explainations and Demo
1. `Code Explaination ` [Click here](https://drive.google.com/file/d/1AJVDzhMdEPTL4hvXGHwPx_DsAHN7rw_t/view?usp=sharing)
2. `Deployement Demo using Remix IDE ` [Click here](https://drive.google.com/file/d/1chxRC41sPeElv3v2fE_cslAMQWFnU7BH/view?usp=sharing) 

## Tech stack and IDEs
- Truffle
- Remix IDE
- Solidity
- Ganache