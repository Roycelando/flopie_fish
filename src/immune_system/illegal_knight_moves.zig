const root = @import("flopie_fish");
const std = @import("std");

test "[White] Knight can only move in an L shape"{
    var b = root.Board{};

    // white knight jump to free spaces
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 1, 16, false));
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 1, 18, false));

    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 6, 21, false));
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 6, 23, false));



     // trying to move an a non L shape, all these should fail
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 1, 19, false)); // square 11 has a pawn
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 1, 8, false));

}

test "[White] Knight can't jump to squares that are occupied by its allies"{
    var b = root.Board{};
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 1, 11, false)); // square 11 has an ally pawn
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 6, 12, false)); // square 11 has an ally pawn
                                                                               
    b = root.Board{.wn_bb = 137573171200}; // white knights on d4 and f5

    root.printAsciiBaord(b.getAsciiBoard());
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 52, true)); // white knight on f5 attacking black pawn on g7
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 54, true)); // white knight on f5 attacking black pawn on e7 
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 47, true)); // white knight on f5 jumping to h6
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 31, true)); // white knight on f5 jumping to h4
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 20, true)); // white knight on f5 jumping to e3
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 22, true)); // white knight on f5 jumping to g3 
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 37, 27, true)); // white knight on f5 blocked by jumping to d4 due to ally knight on d4
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 43, true)); // white knight on f5 jumpoing to d6
                                                                              
}


test "[Black] Knight can't jump to squares that are occupied by its allies"{
    var b = root.Board{};
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 1, 11, false)); // square 11 has an ally pawn
    try std.testing.expect(!root.isKnightMoveLegal(&b, .white, 6, 12, false)); // square 11 has an ally pawn
                                                                               
    b = root.Board{.bn_bb = 34896609280}; // black knights on d5 and f4

    root.printAsciiBaord(b.getAsciiBoard());
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 44, true)); // black knight on f4 attacking black pawn on e6
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 46, true)); // black knight on f4 attacking black pawn on g6
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 23, true)); // black knight on f4 jumping to h3
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 39, true)); // black knight on f4 jumping to h5
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 12, true)); // black knight on f4 attacking white pawn e2
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 14, true)); // black knight on f5 attackign white pawn  g2
     try std.testing.expect(root.isKnightMoveLegal(&b, .black, 29, 19, false)); // black knight on f5 jumping to d3
     try std.testing.expect(!root.isKnightMoveLegal(&b, .black, 29, 35, false)); // black knight on f5 blocked from jumping to d5 d5 do to ally knight on d5
                                                                              
}
