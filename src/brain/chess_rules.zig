//TODO: Add a debug mode where if it is on, error messages print if its off they don't print

// Imports
const std = @import("std");
const root = @import("../root.zig");

// Types
const Piece = root.Piece;
const Color = root.Color;
const Board = root.Board;
const MoveError = root.MoveError;

pub fn isMoveLegal(board:*const Board, piece:Piece, from:u6, to:u6)void {
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
    const delta:i7 = @intCast(@as(i7,to) - @as(i7,from));                                                                   
    const allOppPieces = 
        if(color == .white) 
            board.bp_bb | board.br_bb | board.bn_bb | board.bb_bb | board.bq_bb | board.bk_bb // piece occupancy board of the opposing colour
        else 
            board.wp_bb | board.wr_bb | board.wn_bb | board.wb_bb | board.wq_bb | board.wk_bb;

    const allPieces = board.getCopyOfAllPieceOccupancy();
    const freeSapces = ~allPieces;
    const oppKing = 
        if(color == .white) 
            board.bk_bb
        else
            board.wk_bb;

   
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
    if(color == .white and (delta <= 0 or (delta>9 and (delta != 16 or !canPawnMoveTwo(board.*, color, from))) or (delta < 7))){
        std.debug.print("White pawns can't move in this manner\n",.{});
        return false;
    }
    else if (color == .black and (delta > 0 or (delta < -9 and (delta != -16 or !canPawnMoveTwo(board.*, color, from))) or delta > -7)){
        std.debug.print("Black pawns can't move in this manner\n",.{});
        return false;
    }

    //check if were not being blocked by any piece so we can push the pawn up one square 
    if(color == .white and delta == 8 and (freeSapces >> to) & 1 != 1){
        return false;
    }
    else if(color == .black and delta == -8 and (freeSapces >> to) & 1 != 1){
        return false;
    }

    //check if we can capture a piece diagonally to the left 
    //check that piece you're trying to capture is not a king
    if(color == .white and delta == 7 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to) or (oppKing >> to) & 1 == 1){

        std.debug.print("{} pawn trying to capture left\n",.{color});
        return false;
    }
    else if(color == .black and delta == -7 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to) or (oppKing >> to) & 1 == 1){

        std.debug.print("{} pawn trying to capture left\n",.{color});
        return false;
    }
    
    //check if we can capture a piece diagonally to the right
    if(color == .white and delta == 9 and (((allOppPieces >> to) & 1 != 1 and board.en_passant != to) or (oppKing >> to) & 1 == 1)){

        std.debug.print("{} pawn trying to capture right\n",.{color});
        return false;
    }
    else if(color == .black and delta == -9 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to) or (oppKing >> to) & 1 == 1){

        std.debug.print("{} pawn trying to capture right\n",.{color});
        return false;
    }

    return true; 
}

pub fn isPawnMoveLegalRefactor(board:*Board, color:Color, from:u6, to:u6,showError:bool) bool{
    const pawnBoard = if(color == .white) board.wp_bb else board.bp_bb; // pawns of the current colour
    const delta:i7 = @intCast(@as(i7,to) - @as(i7,from));                                                                   
    const allPieces = board.getCopyOfAllPieceOccupancy();
    const freeSapces = ~allPieces;
    const allOppPieces = 
        if(color == .white) 
            board.bp_bb | board.br_bb | board.bn_bb | board.bb_bb | board.bq_bb | board.bk_bb // piece occupancy board of the opposing colour
        else 
            board.wp_bb | board.wr_bb | board.wn_bb | board.wb_bb | board.wq_bb | board.wk_bb;

    // check if theres a pawn on the square you want to move from
    if((pawnBoard >> from)&1 != 1 ){
        if(showError)
            std.debug.print("No pawn on square {}. Illegal move.\n",.{from});
        
        return false;
    }

    //check that the pawn is moving forward
    if(color == .white and delta <= 0){
        if(showError)
            std.debug.print("White pawns can't move backwards\n",.{});
        return false;
    }
    else if (color == .black and delta >= 0){
        if(showError)
            std.debug.print("Black pawns can't move backwards\n",.{});
        return false;
    }

    // check if the pawn can move 2
    if(color == .white and delta == 16 and !canPawnMoveTwo(board.*, color, from)){
        if(showError)
            std.debug.print("The white pawn can't move two anymore\n",.{});
        return false;
    }
    else if(color == .black and delta == -16 and !canPawnMoveTwo(board.*, color, from)){
        if(showError)
            std.debug.print("The black pawn can't move two anymore\n",.{});
        return false;
    }

    // check if pawn is moving up to the left one square, up one square, up to the right one square, or up two. Else not a legal move
    if(color == .white and (delta != 7 or delta != 8 or delta != 9 or delta != 16)){
         if(showError)
            std.debug.print("The white pawn can't manuver in this manner\n",.{});
    }
    else if(color == .black and (delta != -7 or delta != -8 or delta != -9 or delta != 16)){
         if(showError)
            std.debug.print("The black pawn can't manuver in this manner\n",.{});
    }

    //check if were not being blocked by any piece so we can push the pawn up one square 
    if(color == .white and delta == 8 and (freeSapces >> to) & 1 == 0){
       if(showError)
            std.debug.print("The white pawn can't move up a square since its blocked by a piece \n",.{});
        return false;
    }
    else if(color == .black and delta == -8 and (freeSapces >> to) & 1 == 0){
        if(showError)
            std.debug.print("The black pawn can't move up a square since its blocked by a piece \n",.{});
        return false;
    }

    if(color == .white and delta == 7 and (((allOppPieces >> to) & 1 == 0) and board.en_passant != to)){
        if(showError)
            std.debug.print("White pawn cant capture left. No black piece on that square nor is enpassant available\n",.{});
        return false;
    }
    else if(color == .black and delta == -7 and (((allOppPieces >> to) & 1 == 0) and board.en_passant != to)){
        if(showError)
            std.debug.print("Black pawn cant capture left. No white piece on that square nor is enpassant available\n",.{});
        return false;
    }

    if(color == .white and delta == 9 and (((allOppPieces >> to) & 1 == 0 and board.en_passant != to))){
        if(showError)
            std.debug.print("White pawn cant capture right. No black piece on that square nor is enpassant available\n",.{});        
            return false;
    }
    else if(color == .black and delta == -9 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to)){
        if(showError)
            std.debug.print("Black pawn cant capture right. No black piece on that square nor is enpassant available\n",.{});
        return false;
    }

    return true;
}



