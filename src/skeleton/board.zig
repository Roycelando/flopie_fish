const std = @import("std");

const Board = struct {
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

};

pub fn printU64Bits(value:u64) void{
    var i: i7 = 7;
    while(i>=0):(i -= 1){
        std.debug.print("{b:0>8}\n",.{(value >> @as(u6,@intCast(8*i))) & 0b11111111});
    }
    std.debug.print("\n",.{});
}


pub fn main() !void{
    const board = Board{};

    printU64Bits(board.bp_bp | board.br_bp | board.bb_bp | board.bn_bp | board.bq_bp | board.bk_bp);
    printU64Bits(board.wp_bp | board.wr_bp | board.wb_bp | board.wn_bp | board.wq_bp | board.wk_bp);

}
