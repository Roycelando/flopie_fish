const root = @import("flopie_fish");
const std = @import("std");

test "Pawn move two when legal"{
    var b = root.Board{};
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 8, 24,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 9, 25,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 10, 26,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 11, 27,true));    
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 12, 28,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 13, 29,true));    
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 14, 30,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 15, 31,true));    
}


