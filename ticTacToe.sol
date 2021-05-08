pragma solidity ^0.4.24;

contract TicTacToe {
    
    enum user { OTHER , PLAYER1 , PLAYER2 }
    
    mapping( address => uint256 ) bets;
    address public player1;
    address public player2;
    uint8 public numberOfMoves;
    bool public gameRunning;
    user[3][3] public board;
    user public lastPlayed;
    user public winner;
    
    // Helper functions and modifiers 
    modifier validateUser() {
        require( userType() != user.OTHER , "You are not allowed" );
        _;
    }
    
    function userType() private view returns(user){
        if(msg.sender==player1)
            return user.PLAYER1;
        else if(msg.sender==player2)
            return user.PLAYER2;
        else
            return user.OTHER;
    }
    
    function refreshBoardAndStats() private {
        
        for(uint8 i=0;i<3;i++){
            for(uint8 j=0;j<3;j++){
                board[i][j] = user.OTHER;
            }
        }
        
        lastPlayed = user.PLAYER2;
        gameRunning = true;
        winner = user.OTHER;
        numberOfMoves = 0;
    }


    // Game workflow related functions.
    function placeBets() public payable {
        bets[msg.sender] = msg.value;
    }
    
    function initialiseGame(address _player1,address _player2) public {
        player1 = _player1;
        player2 = _player2;
        refreshBoardAndStats();
    }
    
    function move(uint8 _x,uint8 _y) validateUser public {
        require(bets[player1]!=0 && bets[player2]!=0 ,"Please place bets first." );
        require(userType()!=lastPlayed, "Wait for your move.");
        require(board[_x][_y] == user.OTHER, "Spot already filled, choose another one.");
        require(gameRunning,"Game is over,Initialise a new game.");
        
        lastPlayed = board[_x][_y] = userType();
        numberOfMoves++;
        if(isWinner(userType())){
           gameRunning = false;
           winner = userType();
           msg.sender.transfer(address(this).balance);
        } else if (numberOfMoves == 9) {
            gameRunning = false;
            player1.transfer(bets[player1]);
            player2.transfer(bets[player2]);
        }
    }
    
    
    function isWinner(user player) private view returns(bool) {
        // Check Rows
        for(uint i=0;i<3;i++){
            if( (board[i][0] == player) && (board[i][1] == player) && (board[i][2] == player) )
                return true;
        }
        
        // Check Columns
        for(uint j=0;j<3;j++){
            if(( board[0][j] == player) && (board[1][j] == player) && (board[2][j] == player) )
                return true;
        }
        
        // Check Diagonals
        if( (board[0][0]==player) && (board[1][1]==player) && (board[2][2]==player) )
            return true;
        if( (board[2][0]==player) && (board[1][1]==player) && (board[0][2]==player) )
            return true;

        return false;
    }
}