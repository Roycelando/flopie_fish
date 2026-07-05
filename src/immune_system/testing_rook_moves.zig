const root = @import("flopie_fish");
const std = @import("std");

test "white rook can't capture white pieces"{
    var board:root.Board = root.Board.initBoardEmpty();

    board.wr_bb = 9295429630892703873; 
    // root.printAsciiBaord(board.getAsciiBoard());

    var expectedAttackBoard:u64 =  282578800148862;
    var actualAttackBoard:u64 =  root.generateRookAttakcBoard(board, 0,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    // root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 36170086419038334;
    actualAttackBoard = root.generateRookAttakcBoard(board, 7,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    //   root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 9079539427579068672; 
    actualAttackBoard = root.generateRookAttakcBoard(board, 56,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    //  root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 9115426935197958144; 
    actualAttackBoard = root.generateRookAttakcBoard(board, 63,.white);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    root.printU64Bits(actualAttackBoard);

    board = root.Board.initBoardEmpty();
    board.wn_bb = 576460752320200704;
    board.wr_bb = 134217728;
    expectedAttackBoard = 2260634394167304;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.white);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.wn_bb = 576460754450907136;
    expectedAttackBoard = 2260632263460872;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.white);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

}

test "black rooks cant capture black pieces"{
    var board:root.Board = root.Board.initBoardEmpty();
    board.br_bb = 9295429630892703873; 
    //root.printAsciiBaord(board.getAsciiBoard());

    var expectedAttackBoard:u64 =  282578800148862;
    var actualAttackBoard:u64 =  root.generateRookAttakcBoard(board, 0,.black);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    // root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 36170086419038334;
    actualAttackBoard = root.generateRookAttakcBoard(board, 7,.black);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    //root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 9079539427579068672; 
    actualAttackBoard = root.generateRookAttakcBoard(board, 56,.black);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    //  root.printU64Bits(actualAttackBoard);

    expectedAttackBoard = 9115426935197958144; 
    actualAttackBoard = root.generateRookAttakcBoard(board, 63,.black);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
    // root.printU64Bits(actualAttackBoard);

    board = root.Board.initBoardEmpty();
    board.bn_bb = 576460752320200704;
    board.br_bb = 134217728;
    expectedAttackBoard = 2260634394167304;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.black);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.bn_bb = 576460754450907136;
    expectedAttackBoard = 2260632263460872;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.black);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
}

test "white rooks can capture black pieces"{
    std.debug.print("White rooks attack\n",.{});
    var board:root.Board = root.Board.initBoardEmpty();
    board.br_bb = 72057594037928064;
    board.wr_bb = 1;
    //root.printAsciiBaord(board.getAsciiBoard());

    var expectedAttackBoard:u64 = 72340172838076926;
    var actualAttackBoard:u64 = root.generateRookAttakcBoard(board, 0,.white);
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.wr_bb = 9223372036854775808;
    expectedAttackBoard = 9187484529235886208;
    actualAttackBoard = root.generateRookAttakcBoard(board, 63,.white);
    root.printU64Bits(actualAttackBoard);
    // root.printAsciiBaord(board.getAsciiBoard());

    board.br_bb =9223372036854775809; // black rooks are on a1 and h8
    board.wr_bb = 128; // white rook is on h1
    //  root.printAsciiBaord(board.getAsciiBoard());
    expectedAttackBoard = 9259542123273814143;
    actualAttackBoard = root.generateRookAttakcBoard(board, 7,.white);
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.wr_bb = 72057594037927936; // white rook is on a8
    // root.printAsciiBaord(board.getAsciiBoard());
    expectedAttackBoard = 18302911464433844481;
    actualAttackBoard = root.generateRookAttakcBoard(board, 56,.white);
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board = root.Board.initBoardEmpty();
    board.bn_bb = 576460752320200704;
    board.wr_bb = 134217728;
    expectedAttackBoard = 578721386714368008;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.white);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.bn_bb = 576460754450907136;
    expectedAttackBoard = 578721386714368008;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.white);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
  
}


test "black rooks can capture white pieces"{
    std.debug.print("Black rooks attack\n",.{});
    var board:root.Board = root.Board.initBoardEmpty();
    board.wr_bb = 72057594037928064;
    board.br_bb = 1;
    //root.printAsciiBaord(board.getAsciiBoard());

    var expectedAttackBoard:u64 = 72340172838076926;
    var actualAttackBoard:u64 = root.generateRookAttakcBoard(board, 0,.black);
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.br_bb = 9223372036854775808;
    expectedAttackBoard = 9187484529235886208;
    actualAttackBoard = root.generateRookAttakcBoard(board, 63,.black);
    root.printU64Bits(actualAttackBoard);
    // root.printAsciiBaord(board.getAsciiBoard());

    board.wr_bb = 9223372036854775809; // white rooks are on a1 and h8
    board.br_bb = 128; // black rook is on h1
    // root.printAsciiBaord(board.getAsciiBoard());
    expectedAttackBoard = 9259542123273814143;
    actualAttackBoard = root.generateRookAttakcBoard(board, 7,.black);
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.br_bb = 72057594037927936; // black rook is on a8
    root.printAsciiBaord(board.getAsciiBoard());
    expectedAttackBoard = 18302911464433844481;
    actualAttackBoard = root.generateRookAttakcBoard(board, 56, .black);
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board = root.Board.initBoardEmpty();
    board.wn_bb = 576460752320200704;
    board.br_bb = 134217728;
    expectedAttackBoard = 578721386714368008;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.black);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);

    board.wn_bb = 576460754450907136;
    expectedAttackBoard = 578721386714368008;
    actualAttackBoard = root.generateRookAttakcBoard(board,27,.black);
    root.printAsciiBaord(board.getAsciiBoard());
    root.printU64Bits(actualAttackBoard);
    try std.testing.expectEqual(expectedAttackBoard, actualAttackBoard);
}

