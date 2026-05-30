const root = @import("flopie_fish");
const std = @import("std");

test "white rook moves on an empty board"{
    var board:root.Board = root.Board.initBoardEmpty();

    board.wr_bb = 9295429630892703873; 
//  root.printAsciiBaord(board.getAsciiBoard());


    var expectedAttackBoard:u64 =  282578800148862;
    var actualAttackBoard:u64 =  root.generateRookAttakcBoard(board, 0,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
//    root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 36170086419038334;
    actualAttackBoard = root.generateRookAttakcBoard(board, 7,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
 //   root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 9079539427579068672; 
    actualAttackBoard = root.generateRookAttakcBoard(board, 56,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
//    root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 9115426935197958144; 
    actualAttackBoard = root.generateRookAttakcBoard(board, 63,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
//    root.printU64Bits(actualAttackBoard);
}
