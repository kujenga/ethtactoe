pragma solidity 0.4.23;


contract TicTacToe {
    struct Game {
        // Players in the game.
        address creator;
        address partner;
        // Board of addresses for who has gone so far.
        address[3*3] board;
        // The last player to make a move.
        address last;
    }

    // A dynamically sized array of games.
    Game[] public games;

    // Starts a game between the sender and the indicated address. The return
    // value is the identifier of the game.
    function startGame(address partner) public returns (uint) {
        return games.push(Game({
            creator: msg.sender,
            partner: partner,
            board: [address(0), 0, 0, 0, 0, 0, 0, 0, 0],
            last: address(0)
        })) - 1;
    }

    // make a move within an existing game.
    function move(uint gameIdx, uint x, uint y) public {
        Game storage game = games[gameIdx];

        bool isCreator = msg.sender == game.creator;
        bool isPartner = msg.sender == game.partner;
        require(isCreator || isPartner, "Only the game creator and partner can make moves.");

        // Ensure the player's move is valid.
        require(x < 3, "X index must be in range.");
        require(y < 3, "Y index must be in range.");

        set(game, x, y);
    }

    function get(Game game, uint x, uint y) internal pure returns (address) {
        return game.board[3*x+y];
    }

    function set(Game game, uint x, uint y) internal returns (address) {
        require(msg.sender != game.last, "Wait for the other player to take their turn.");
        require(get(game, x, y) == address(0), "Tile has already been used.");

        game.board[3*x+y] = msg.sender;
        game.last = msg.sender;
    }
}
