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
                                                                               
    b = root.Board{.wn_bb = 137573171200};
    root.printAsciiBaord(b.getAsciiBoard());
    try std.testing.expect(root.isKnightMoveLegal(&b, .white, 37, 52, true)); 


}
