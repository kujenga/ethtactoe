const TicTacToe = artifacts.require('../contracts/TicTacToe.sol');

contract('TicTacToe', accounts => {
  it('should play a TicTacToe game properly', async () => {
    const inst = await TicTacToe.deployed();

    // Two players for a single game.
    const p1 = accounts[0];
    const p2 = accounts[1];

    const game = await inst.startGame.call(p2, { from: p1 });
  });
});
