const root = @import("../root.zig");
const std = @import("std");

test "Pawn move two"{
    var b = root.Board{};
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 8, 24,true)); 
}
