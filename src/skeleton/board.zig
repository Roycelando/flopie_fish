const std = @import("std");
const root = @import("../root.zig");
const Color = root.Color;
const Piece = root.Piece;


//TODO: Please create test cases to ensure the board is working correctly
//TODO: Make getArryOfU64Boards private later


pub const MoveError = error{
    IlegalMove,
    InvalidSquare,
};

pub const Board = struct {
    wp_bb:u64 = 65280,
    wr_bb:u64 = 129,
    wn_bb:u64 = 66,
    wb_bb:u64 = 36,
    wq_bb:u64 = 8,
    wk_bb:u64 = 16,


    bp_bb:u64 = 71776119061217280,
    br_bb:u64 = 9295429630892703744,
    bn_bb:u64 = 4755801206503243776,
    bb_bb:u64 = 2594073385365405696,
    bq_bb:u64 = 576460752303423488,
    bk_bb:u64 = 1152921504606846976,

    fn initBoardFromU64Array() void{
        return;
    }

    fn initBoardFromU64() void{
        return;
    }

    pub fn getArryOfU64Boards(self:*Board)[12] *u64{
        return [12]*u64{&self.wp_bb,&self.wr_bb,&self.wn_bb,&self.wb_bb,&self.wq_bb,&self.wk_bb,&self.bp_bb,&self.br_bb,&self.bn_bb,&self.bb_bb,&self.bq_bb,&self.bk_bb};
    }

    fn getBoardFromPiece(self:*Board,piece:Piece,color:Color) *u64{
        switch (piece) {
            Piece.pawn=>{
                if(color == .white){
                    return &self.wp_bb;
                }
                return &self.bp_bb;
            },
            Piece.rook=>{
                if(color == .white){
                    return &self.wr_bb;
                }
                return &self.br_bb;
            },
            Piece.knight=>{
                if(color == .white){
                    return &self.wn_bb;
                }
                return &self.bn_bb;
            },
            Piece.bishop=>{
                if(color == .white){
                    return &self.wb_bb;
                }
                return &self.bb_bb;
            },
            Piece.queen=>{
                if(color == .white){
                    return &self.wq_bb;
                }
                return &self.bq_bb;
            },
            Piece.king=>{
                if(color == .white){
                    return &self.wk_bb;
                }
                return &self.bk_bb;
            },
        }
    }

    pub fn makeMove(self:*Board,piece:Piece, color:Color,from:u6, to:u6) MoveError!void{
        const allU64BitBoards = getArryOfU64Boards(self);

        const pieceFromBoard = getBoardFromPiece(self, piece, color);

        // Ensures the piece you're moving is present on the from square
        if((pieceFromBoard.* >> from) & 1 != 1){
                std.debug.print("There is no {} {} on this square to move\n",.{color,piece});
                return MoveError.IlegalMove;
        }
        
        for(0..allU64BitBoards.len)|i|{
            if((allU64BitBoards[i].* >> to) & 1 == 1){
                std.debug.print("The board {} contians a piece on the square you want to move to\n",.{i});
                //for testing value before printU64Bits(allU64BitBoards[i].*);
                const toMask:u64 = @as(u64,1)<<to;
                allU64BitBoards[i].* ^= toMask;
                //for testing value after printU64Bits(allU64BitBoards[i].*);
            }
        }
    
        std.debug.print("The squre you're moving to is empty, moving piece to square\n",.{});
        const mask:u64 = @as(u64,1)<<from | @as(u64,1)<<to;
        //for testing mask printU64Bits(mask);
        pieceFromBoard.* ^= mask; // the mask will remove the piece from old position and put it to new position
        //for testing the move made printU64Bits(pieceFromBoard.*);
        return;
    }

};

pub fn printU64Bits(value:u64) void {
    var i: i7 = 7; // needs to be i7 since while loop will make value negative and 8*7 is 56 which is greater than the 32 in an i6 
    var j: u4 = 0; // needs to be u4 since the while loop will increment value to number 8
    var rank:u8 = undefined;

    while(i>=0):(i -= 1){
        rank = @intCast((value >> @as(u6,@intCast(i*8))) & 0xFF); // getting all the ranks starting with the h rank
        while(j<8):(j += 1){
            std.debug.print("{b}",.{(rank >> @intCast(j)) & 0b1}); // printing bits from left to right so board looks normal
        }
        j =0;
        std.debug.print("\n", .{});
    }
        std.debug.print("\n", .{});
}

pub fn printAllU64BitBoards(board:Board)void{
    std.debug.print("Printing black's pawns occupation\n",.{});
    printU64Bits(board.bp_bb);
    std.debug.print("Printing black's rooks occupation\n",.{});
    printU64Bits(board.br_bb);
    std.debug.print("Printing black's bishops occupation\n",.{});
    printU64Bits(board.bb_bb);
    std.debug.print("Printing black's knights occupation\n",.{});
    printU64Bits(board.bn_bb);
    std.debug.print("Printing black's queens occupation\n",.{});
    printU64Bits(board.bq_bb);
    std.debug.print("Printing black's kings occupation\n",.{});
    printU64Bits(board.bk_bb);

    std.debug.print("Printing white's pawns occupation\n",.{});
    printU64Bits(board.wp_bb);
    std.debug.print("Printing white's rooks occupation\n",.{});
    printU64Bits(board.wr_bb);
    std.debug.print("Printing white's bishops occupation\n",.{});
    printU64Bits(board.wb_bb);
    std.debug.print("Printing white's knights occupation\n",.{});
    printU64Bits(board.wn_bb);
    std.debug.print("Printing white's queens occupation\n",.{});
    printU64Bits(board.wq_bb);
    std.debug.print("Printing white's kings occupation\n",.{});
    printU64Bits(board.wk_bb);

}


