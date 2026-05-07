const root = @import("flopie_fish");
const std = @import("std");

test "Pawn move two when legal"{
    var b = root.Board{};
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 8, 24,true)); 
}
