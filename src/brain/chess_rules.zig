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

pub fn canPawnMoveTwo(board:Board, colour:Color, square:u6) bool{
    const wpStartingPosition:u64 = 65280;
    const bpStartingPosition:u64 = 71776119061217280;
    const wp_bb = board.wp_bb;
    const bp_bb = board.bp_bb;
    const allPiecesOccupancy = board.getCopyOfAllPieceOccupancy();

    // can move to if piece is on its starting square and if the two squares infront of the pawn are free
    if(colour == .white and ((wp_bb&wpStartingPosition)>>square)&1 == 1 and (allPiecesOccupancy>>(square+8))&1 != 1 and (allPiecesOccupancy>>(square+16))&1 != 1){
        return true;
    }

    if(colour == .black and ((bp_bb&bpStartingPosition)>>square)&1 == 1 and (allPiecesOccupancy>>(square-8))&1 != 1 and (allPiecesOccupancy>>(square-16))&1 != 1){
        return true;
    }
    
    return false;
}

pub fn isPawnMoveLegalOld(board:*Board, colour:Color, from:u6, to:u6) bool{
    const pawnBoard = if(colour == .white) board.wp_bb else board.bp_bb; // pawns of the current colour
    const delta:i7 = @intCast(@as(i7,to) - @as(i7,from));                                                                   
    const allOppPieces = 
        if(colour == .white) 
            board.bp_bb | board.br_bb | board.bn_bb | board.bb_bb | board.bq_bb | board.bk_bb // piece occupancy board of the opposing colour
        else 
            board.wp_bb | board.wr_bb | board.wn_bb | board.wb_bb | board.wq_bb | board.wk_bb;

    const allPieces = board.getCopyOfAllPieceOccupancy();
    const freeSapces = ~allPieces;
    const oppKing = 
        if(colour == .white) 
            board.bk_bb
        else
            board.wk_bb;

   
    // check if theres a pawn on the square you want to move from
    if((pawnBoard >> from)&1 != 1 ){
        std.debug.print("No {} pawn on square {}. Illegal move.\n",.{colour, from});
        return false;
    }

    // check if pawn is moving forward
    // check pawns is only moving up one square or up one square and one square to the left or up one square and one square to the right
    // if enpassant move, its okay
    // if distance is gonna be greater than 9 than it better be 16 and pawn should be able to move 2
    // any values less than 7 don aren't pawn moves
    if(colour == .white and (delta <= 0 or (delta>9 and (delta != 16 or !canPawnMoveTwo(board.*, colour, from))) or (delta < 7))){
        std.debug.print("White pawns can't move in this manner\n",.{});
        return false;
    }
    else if (colour == .black and (delta > 0 or (delta < -9 and (delta != -16 or !canPawnMoveTwo(board.*, colour, from))) or delta > -7)){
        std.debug.print("Black pawns can't move in this manner\n",.{});
        return false;
    }

    //check if were not being blocked by any piece so we can push the pawn up one square 
    if(colour == .white and delta == 8 and (freeSapces >> to) & 1 != 1){
        return false;
    }
    else if(colour == .black and delta == -8 and (freeSapces >> to) & 1 != 1){
        return false;
    }

    //check if we can capture a piece diagonally to the left 
    //check that piece you're trying to capture is not a king
    if(colour == .white and delta == 7 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to) or (oppKing >> to) & 1 == 1){

        std.debug.print("{} pawn trying to capture left\n",.{colour});
        return false;
    }
    else if(colour == .black and delta == -7 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to) or (oppKing >> to) & 1 == 1){

        std.debug.print("{} pawn trying to capture left\n",.{colour});
        return false;
    }
    
    //check if we can capture a piece diagonally to the right
    if(colour == .white and delta == 9 and (((allOppPieces >> to) & 1 != 1 and board.en_passant != to) or (oppKing >> to) & 1 == 1)){

        std.debug.print("{} pawn trying to capture right\n",.{colour});
        return false;
    }
    else if(colour == .black and delta == -9 and (((allOppPieces >> to) & 1 != 1) and board.en_passant != to) or (oppKing >> to) & 1 == 1){

        std.debug.print("{} pawn trying to capture right\n",.{colour});
        return false;
    }

    return true; 
}

pub fn isPawnMoveLegal(board:*Board, comptime colour:Color, comptime from:u6, comptime to:u6,comptime showMsg:bool) bool{
    const pawnBoard = if(colour == .white) board.wp_bb else board.bp_bb; // pawns of the current colour
    const delta:i7 = @intCast(@as(i7,to) - @as(i7,from));                                                                   
    const allPieces = board.getCopyOfAllPieceOccupancy();
    const freeSapces = ~allPieces;
    const allOppPieces = root.getOccupancyOfColourU64Bits(board.*, colour,true);
        

    // check if theres a pawn on the square you want to move from
    if((pawnBoard >> from)&1 != 1 ){
        if(showMsg)
            std.debug.print("No {} pawn on square {}. Illegal move.\n",.{colour,from});
        
        return false;
    }

    //check that the pawn is moving forward
    if(colour == .white and delta <= 0){
        if(showMsg)
            std.debug.print("[White] Pawns can't move backwards\n",.{});
        return false;
    }
    else if (colour == .black and delta >= 0){
        if(showMsg)
            std.debug.print("[Black] Pawns can't move backwards\n",.{});
        return false;
    }

    // check if the pawn can move 2
    if(colour == .white and delta == 16 and !canPawnMoveTwo(board.*, colour, from)){
        if(showMsg)
            std.debug.print("[White] The pawn can't move two. May not be on its starting square or path is blocked\n",.{});
        return false;
    }
    else if(colour == .black and delta == -16 and !canPawnMoveTwo(board.*, colour, from)){
        if(showMsg)
            std.debug.print("[Black] The pawn can't move two. May not be on its starting square or path is blocked\n",.{});
        return false;
    }

    // check if pawn is moving up to the left one square, up one square, up to the right one square, or up two. Else not a legal move
    if(colour == .white and (delta != 7 and delta != 8 and delta != 9 and delta != 16)){
         if(showMsg)
            std.debug.print("[White] The pawn can't manuver in this manner\n",.{});
         return false;
    }
    else if(colour == .black and (delta != -7 and delta != -8 and delta != -9 and delta != -16)){
         if(showMsg)
            std.debug.print("[Black] The pawn can't manuver in this manner\n",.{});
         return false;
    }

    //check if were not being blocked by any piece so we can push the pawn up one square 
    if(colour == .white and delta == 8 and (freeSapces >> to) & 1 == 0){
       if(showMsg)
            std.debug.print("[White] The pawn can't move up a square since its blocked by a piece \n",.{});
        return false;
    }
    else if(colour == .black and delta == -8 and (freeSapces >> to) & 1 == 0){
        if(showMsg)
            std.debug.print("[Black] The pawn can't move up a square since its blocked by a piece \n",.{});
        return false;
    }

    if(colour == .white and delta == 7 and (((allOppPieces >> to) & 1 == 0) and board.en_passant != to)){
        if(showMsg)
            std.debug.print("White pawn cant capture left. No black piece on that square nor is enpassant available\n",.{});
        return false;
    }
    else if(colour == .black and delta == -7 and (((allOppPieces >> to) & 1 == 0) and board.en_passant != to)){
        if(showMsg)
            std.debug.print("Black pawn cant capture left. No white piece on that square nor is enpassant available\n",.{});
        return false;
    }

    if(colour == .white and delta == 9 and (((allOppPieces >> to) & 1 == 0 and board.en_passant != to))){
        if(showMsg)
            std.debug.print("White pawn cant capture right. No black piece on that square nor is enpassant available\n",.{});        
            return false;
    }
    else if(colour == .black and delta == -9 and (((allOppPieces >> to) & 1 == 0) and board.en_passant != to)){
        if(showMsg)
            std.debug.print("Black pawn cant capture right. No white piece on that square nor is enpassant available\n",.{});
        return false;
    }

    return true;
}

pub fn isKnightMoveLegal(board: *Board, comptime colour:Color, comptime from:u6, comptime to:u6,comptime showMsg:bool) bool{
    const delta:i7 = @intCast(@as(i7,to) - @as(i7,from));                                                                   
    const absDelta:i7 = @abs(delta);
    const allYourPieces:u64 = root.getOccupancyOfColourU64Bits(board.*, colour,false);

    if(absDelta != 6  and absDelta != 10 and absDelta != 15 and absDelta != 17 ){ // check that knight moves in an L shape
        if(showMsg)                                                                          
            std.debug.print("How does the Knight Move? Not like... delta is {}\n", .{delta});
        return false;
    }

    if(allYourPieces >> to & 1 == 1 ){
        if(showMsg)
            std.debug.print("The knight on square {} is being blocked by its ally on square {}\n",.{from, to});
        return false;
    }

    return true;
 }



