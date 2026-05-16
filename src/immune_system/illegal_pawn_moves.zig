const root = @import("flopie_fish");
const std = @import("std");

test "White pawn can move two when legal"{
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

test "Black can pawn move two when legal"{
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
    //std.debug.print("\nWhite pawn can't move two if pieces is blocking its path\n",.{});
    var b = root.Board{.bp_bb = 16711680}; //black pawns are on the 3rd rank
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 8, 24,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 9, 25,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 10, 26,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 11, 27,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 12, 28,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 13, 29,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 14, 30,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 15, 31,false)); 

    b = root.Board{.bp_bb = 4278190080}; //black pawns are on the 4th rank
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 8, 24,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 9, 25,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 10, 26,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 11, 27,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 12, 28,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 13, 29,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 14, 30,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 15, 31,false)); 
}

test "Black pawn can't move two if pieces is blocking its path"{
    //std.debug.print("\nBlack pawn can't move two if pieces is blocking its path\n",.{});
    std.debug.print("\n",.{});
    var b = root.Board{.wp_bb = 280375465082880}; // white pawns are on the 6th rank, blocking push two
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 48, 32,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 49, 33,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 50, 34,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 51, 35,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 52, 36,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 53, 37,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 54, 38,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 55, 39,false)); 

    b = root.Board{.wp_bb = 1095216660480}; // white pawns are on the 5th rank, blocking push two
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 48, 32,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 49, 33,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 50, 34,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 51, 35,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 52, 36,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 53, 37,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 54, 38,false)); 
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 55, 39,false));

}

test "White pawn can't move backwards"{
    var b = root.Board{.wp_bb=4278190080}; // white pawns starting on the 4th rank
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 24, 16, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 25, 17, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 26, 18, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 27, 19, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 28, 20, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 29, 21, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 30, 22, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 31, 23, false));

}

test "Black pawn can't move backwards"{
    var b = root.Board{.bp_bb = 280375465082880}; // black pawns on the 6th rank
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 47, 55, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 48, 56, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 49, 57, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 50, 58, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 51, 59, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 52, 60, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 53, 61, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 54, 62, false));
}


test "White pawn can capture right or left if black piece are on the diagonal"{
    var b = root.Board{.wp_bb = 4278190080, .bp_bb = 4294967296, .br_bb = 25769803776,.bn_bb = 103079215104, .bb_bb = 412316860416,.bq_bb = 549755813888}; // black pawns on the 6th rank root.printAsciiBaord(b.getAsciiBoard());

    // white pawns trying to capture right legally
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 24, 33, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 25, 34, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 26, 35, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 27, 36, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 28, 37, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 29, 38, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 30, 39, false));

    // white pawns trying to capture left legally
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 25, 32, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 26, 33, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 27, 34, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 28, 35, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 29, 36, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 30, 37, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 31, 38, false));
    
    b = root.Board{.wp_bb = 4278190080};                                                                
    //root.printAsciiBaord(b.getAsciiBoard());

    // white pawns trying to capture right illegally
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 24, 33, true));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 25, 34, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 26, 35, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 27, 36, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 28, 37, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 29, 38, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 30, 39, false));

    // white pawns trying to capture left illegally
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 25, 32, true));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 26, 33, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 27, 34, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 28, 35, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 29, 36, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 30, 37, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .white, 31, 38, false));

    // white pawns trying to capture left enpassant legally
    b = root.Board{.wp_bb = 730144440320};                                                                
    try b.makeMove(.pawn, .black, 48, 32);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 33, 40, false));
    try b.makeMove(.pawn, .black, 50, 34);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 35, 42, false));
    try b.makeMove(.pawn, .black, 52, 36);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 37, 44, false));
    try b.makeMove(.pawn, .black, 54, 38);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 39, 46, false));

    b = root.Board{.wp_bb = 365072220160};                                                                
    try b.makeMove(.pawn, .black, 49, 33);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 34, 41, false));
    try b.makeMove(.pawn, .black, 51, 35);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 36, 43, false));
    try b.makeMove(.pawn, .black, 53, 37);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 38, 45, false));
    try b.makeMove(.pawn, .black, 55, 39);
    root.printAsciiBaord(b.getAsciiBoard());

    // white pawns trying to capture right enpassant legally
    b = root.Board{.wp_bb = 730144440320};                                                                
    try b.makeMove(.pawn, .black, 48, 32);
    try b.makeMove(.pawn, .black, 50, 34);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 33, 42, false));
    try b.makeMove(.pawn, .black, 52, 36);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 35, 44, false));
    try b.makeMove(.pawn, .black, 54, 38);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 37, 46, false));

    b = root.Board{.wp_bb = 365072220160};                                                                
    try b.makeMove(.pawn, .black, 49, 33);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 32, 41, false));
    try b.makeMove(.pawn, .black, 51, 35);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 34, 43, false));
    try b.makeMove(.pawn, .black, 53, 37);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 36, 45, false));
    try b.makeMove(.pawn, .black, 55, 39);
    try std.testing.expect(root.isLegalPawnMove(&b, .white, 38, 47, false));

}


test "Black pawn can capture right or left if black piece are on the diagonal"{
    var b = root.Board{.bp_bb = 1095216660480,.wr_bb = 50331648,.wn_bb = 201326592, .wb_bb = 805306368,.wq_bb = 1073741824,.wp_bb = 2147483648}; // black pawns on the 6th rank root.printAsciiBaord(b.getAsciiBoard());
    // root.printAsciiBaord(b.getAsciiBoard());

    // black pawns trying to capture right legally
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 33, 24, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 34, 25, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 35, 26, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 36, 27, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 37, 28, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 38, 29, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 39, 30, false));

    // black pawns trying to capture left legally
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 32, 25, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 33, 26, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 34, 27, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 35, 28, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 36, 29, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 37, 30, false));
    try std.testing.expect(root.isLegalPawnMove(&b, .black, 38, 31, false));
    
    b = root.Board{.bp_bb = 1095216660480};                                                                
    //root.printAsciiBaord(b.getAsciiBoard());

    // black pawns trying to capture right illegally
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 33, 24, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 34, 25, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 35, 26, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 36, 27, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 37, 28, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 38, 29, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 39, 30, false));

    // black pawns trying to capture left illegally
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 32, 25, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 33, 26, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 34, 27, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 35, 28, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 36, 29, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 37, 30, false));
    try std.testing.expect(!root.isLegalPawnMove(&b, .black, 38, 31, false));

}



