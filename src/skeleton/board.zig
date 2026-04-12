const std = @import("std");
const root = @import("../root.zig");
const Color = root.Color;


pub const MoveError = error{
    IlegealMove,
    InvalidSquare,
};

pub const Board = struct {
    wp_bp:u64 = 65280,
    wr_bp:u64 = 129,
    wn_bp:u64 = 66,
    wb_bp:u64 = 36,
    wq_bp:u64 = 8,
    wk_bp:u64 = 16,


    bp_bp:u64 = 71776119061217280,
    br_bp:u64 = 9295429630892703744,
    bn_bp:u64 = 4755801206503243776,
    bb_bp:u64 = 2594073385365405696,
    bq_bp:u64 = 576460752303423488,
    bk_bp:u64 = 1152921504606846976,

    fn initBoardFromU64Array() void{
        return;
    }

    fn initBoardFromU64() void{
        return;
    }

    fn makeMove(self:*Board,color:Color,from:u6, to:u6) MoveError!void{
        _ = self;
        _ = color;
        _ = from;
        _ = to;

        return MoveError.IlegealMove;
    }

};

pub fn printU64Bits(value:u64) void{
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
    printU64Bits(board.bp_bp);
    std.debug.print("Printing black's rooks occupation\n",.{});
    printU64Bits(board.br_bp);
    std.debug.print("Printing black's bishops occupation\n",.{});
    printU64Bits(board.bb_bp);
    std.debug.print("Printing black's knights occupation\n",.{});
    printU64Bits(board.bn_bp);
    std.debug.print("Printing black's queens occupation\n",.{});
    printU64Bits(board.bq_bp);
    std.debug.print("Printing black's kings occupation\n",.{});
    printU64Bits(board.bk_bp);

    std.debug.print("Printing white's pawns occupation\n",.{});
    printU64Bits(board.wp_bp);
    std.debug.print("Printing white's rooks occupation\n",.{});
    printU64Bits(board.wr_bp);
    std.debug.print("Printing white's bishops occupation\n",.{});
    printU64Bits(board.wb_bp);
    std.debug.print("Printing white's knights occupation\n",.{});
    printU64Bits(board.wn_bp);
    std.debug.print("Printing white's queens occupation\n",.{});
    printU64Bits(board.wq_bp);
    std.debug.print("Printing white's kings occupation\n",.{});
    printU64Bits(board.wk_bp);

}


