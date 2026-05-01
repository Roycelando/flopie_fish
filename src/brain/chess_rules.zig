//TODO: Add a debug mode where if it is on, error messages print if its off they don't print

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

pub fn canPawnMoveTwo(board:Board, color:Color, square:u6) bool{
    const wpStartingPosition:u64 = 65280;
    const bpStartingPosition:u64 = 71776119061217280;
    const wp_bb = board.wp_bb;
    const bp_bb = board.bp_bb;
    const allPiecesOccupancy = board.getCopyOfAllPieceOccupancy();

    // can move to if piece is on its starting square and if the two squares infront of the pawn are free
    if(color == .white and ((wp_bb&wpStartingPosition)>>square)&1 == 1 and (allPiecesOccupancy>>(square+8))&1 != 1 and (allPiecesOccupancy>>(square+16))&1 != 1){
        return true;
    }

    if(color == .black and ((bp_bb&bpStartingPosition)>>square)&1 == 1 and (allPiecesOccupancy>>(square-8))&1 != 1 and (allPiecesOccupancy>>(square-16))&1 != 1){
        return true;
    }
    
    return false;
}

pub fn isPawnMoveLegal(board:*Board, color:Color, from:u6, to:u6) bool{
    const pawnBoard = if(color == .white) board.wp_bb else board.bp_bb; // pawns of the current colour
    const allOppPieces = 
        if(color == .white) 
            board.bp_bb | board.br_bb | board.bn_bb | board.bb_bb | board.bq_bb | board.bk_bb // piece occupancy board of the opposing colour
        else 
            board.wp_bb | board.wr_bb | board.wn_bb | board.wb_bb | board.wq_bb | board.wk_bb;

    const allPieces:u64 = 0;
    const allBoards = 
        board.wp_bb | board.wr_bb | board.wn_bb | board.wb_bb | board.wq_bb | board.wk_bb | 
        board.bp_bb | board.br_bb | board.bn_bb | board.bb_bb | board.bq_bb | board.bk_bb;

    std.debug.print("Printing all boards\n",.{});
    const freeSapces = ~allBoards;
    root.printU64Bits(freeSapces);

    std.debug.print("Printing all free spaces\n",.{});
    root.printU64Bits(freeSapces);
    _ = allPieces;
   
    // check if theres a pawn on the square you want to move from
    if((pawnBoard >> from)&1 != 1 ){
        std.debug.print("No pawn on square {}. Illegal move.\n",.{from});
        return false;
    }

    // check if pawn is moving forward
    // check pawns is only moving up one square or up one square and one square to the left or up one square and one square to the right
    // if enpassant move, its okay
    // if distance is gonna be greater than 9 than it better be 16 and pawn should be able to move 2
    // any values less than 7 don aren't pawn moves
    if(color == .white and ((to-from) <= 0 or (to-from>9 and ((to - from) != 16 or !canPawnMoveTwo(board.*, color, from))) or ((to - from) < 7))){
        std.debug.print("Pawns can't move in this manner\n",.{});
        return false;
    }
    else if (color == .black and ((to-from) > 0 or ((to-from) < -9 and ((to-from) != -16 or !canPawnMoveTwo(board.*, color, from))) or to-from > -7)){
        std.debug.print("Pawns can't move in this manner\n",.{});
        return false;
    }

    //check if were not being blocked by any piece so we can push the pawn up one square 
    if(color == .white and (to - from) == 8 and (freeSapces >> to) & 1 != 1){
        return false;
    }
    else if(color == .black and (to - from) == -8 and (freeSapces >> to) & 1 != 1){
        return false;
    }

    //check if we can capture a piece diagonally to the left 
    if(color == .white and (to - from) == 7 and (allOppPieces >> to) & 1 != 1){
        return false;
    }
    else if(color == .black and (to - from) == -7 and (allOppPieces >> to) & 1 != 1){
        return false;
    }
    
    //check if we can capture a piece diagonally to the right
    if(color == .white and (to - from) == 9 and (allOppPieces >> to) & 1 != 1){
        return false;
    }
    else if(color == .black and (to - from) == -9 and (allOppPieces >> to) & 1 != 1){
        return false;
    }

    return true; 
}

