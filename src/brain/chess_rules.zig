// Imports
const std = @import("std");
const root = @import("../root.zig");

// Types
const Piece = root.Piece;
const Color = root.Color;
const Board = root.Board;
const MoveError = root.MoveError;

pub fn isLegalMove(board:*const Board, piece:Piece, from:u6, to:u6)void {
    _= board;
    _= from;
    _= to;
   
    switch(piece){
        .pawn=>{
        },
        .rook=>{
            return;
        },
        .knight=>{
        },
        .bishop=>{
        },
        .queen=>{
        },
        .king=>{
        }
    }
    return;
}

pub fn isPawnMoveLegal(board:*Board, color:Color, from:u6, to:u6) MoveError!u64{
    const pawnBoard = if(color == .white) board.wp_bb else board.bp_bb;
    const allPieces:u64 = 0;
    const allBoards = 
        board.wp_bb | board.wr_bb | board.wn_bb | board.wb_bb | board.wq_bb | board.wk_bb | 
        board.bp_bb | board.br_bb | board.bn_bb | board.bb_bb | board.bq_bb | board.bk_bb;
    
    _ = to;
    _ = allBoards;
    _ = allPieces;
   
    // check if there a pawn on the square we want to move from
    if((pawnBoard >> from)&1 != 1 ){
        std.debug.print("No pawn on square {}. Illegal move.\n",.{from});
        return MoveError.IlegalMove;
    }

    // 

    return 0; 
}

