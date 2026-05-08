const root = @import("flopie_fish");
const std = @import("std");

test "White pawn move two when legal"{
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

test "Black pawn move two when legal"{
    var b = root.Board{};
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 48, 32,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 49, 33,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 50, 34,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 51, 35,true));    
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 52, 36,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 53, 37,true));    
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 54, 38,true)); 
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 55, 39,true));    
}

test "White pawn can't move two if pieces is blocking its path"{
    var b = root.Board{.bp_bb = 65020719889121280};
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 11, 27,true)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 12, 28,true)); 
}

test "Black pawn can't move two if pieces is blocking its path"{

}

test "White pawn can't move backwards"{
    var b = root.Board{.wp_bb = 16842240};
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 24, 16, false));
}


test "Black pawn can't move backwards"{
    var b = root.Board{.bp_bb = 71494648379473920};
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 32, 40, false));
}






