pub const Piece = enum{
    pawn,
    rook,
    knight,
    bishop,
    queen,
    king
};

pub const Color = enum{
 white,
 black
};

pub fn pieceValue(piece:Piece) u8{
    switch (piece) {
        .pawn => return 1,
        .rook => return 5,
        .knight => return 3,
        .bishop => return 3,
        .queen => return 9,
        .king => return  200,
    }
}
