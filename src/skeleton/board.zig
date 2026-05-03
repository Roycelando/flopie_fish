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

    en_passant:?u6 = null, 
    flag_enpassant:bool = true,
    capture_enpassant:bool = true,


    fn initBoardFromU64Array() void{
        return;
    }

    fn initBoardFromU64() void{
        return;
    }

    pub fn getCopyOfAllPieceOccupancy(self:Board) u64{
        return (self.wp_bb | self.wr_bb | self.wn_bb | self.wb_bb | self.wq_bb | self.wk_bb | self.bp_bb | self.br_bb | self.bn_bb | self.bb_bb | self.bq_bb | self.bk_bb);
    }

    pub fn getArrayOfU64Boards(self:*Board)[12] *u64{
        return [12]*u64{&self.wp_bb,&self.wr_bb,&self.wn_bb,&self.wb_bb,&self.wq_bb,&self.wk_bb,&self.bp_bb,&self.br_bb,&self.bn_bb,&self.bb_bb,&self.bq_bb,&self.bk_bb};
    }

    pub fn getAsciiBoard(self:*Board) [64]u8{
        const pieceEnumLength = @typeInfo(Piece).@"enum".fields.len;
        const colorEnumLength = @typeInfo(Color).@"enum".fields.len; 

        var charBoard:[64]u8 = [_]u8{'.'} ** 64;

        for(0..colorEnumLength)|c|{
            for(0..pieceEnumLength)|p|{
                const currBoard = getBoardFromPiece(self, @enumFromInt(p), @enumFromInt(c)).*;

                for(0..64)|i|{
                    if((currBoard >> @as(u6,@intCast(i))) & 1 == 1){
                        charBoard[i] = getPieceChar(@enumFromInt(@as(u8,@intCast(p))), @enumFromInt(@as(u8,@intCast(c))));
                    }
                    
                }

            }
        }
        
        return charBoard;
    }

    fn getPieceChar(piece:Piece,color:Color)u8{
        switch (piece) {
                    Piece.pawn=>{
                        if(color == .white){
                            return 'p';
                        }
                        return 'P';
                    },
                    Piece.rook=>{
                        if(color == .white){
                            return 'r';
                        }
                            return 'R';
                    },
                    Piece.knight=>{
                        if(color == .white){
                            return 'n';
                        }
                            return 'N';
                    },
                    Piece.bishop=>{
                        if(color == .white){
                            return 'b';
                        }
                            return 'B';
                    },
                    Piece.queen=>{
                        if(color == .white){
                            return 'q';
                        }
                            return 'Q';
                    },
                    Piece.king=>{
                        if(color == .white){
                            return 'k';
                        }
                            return 'K';
                    },
                }

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

    fn checkThenSetEnpassant(self:*Board ,piece:Piece, color:Color, from:u6, to:u6) bool{

        const pawnStartingPosition:u64 = if(color == .white) 65280 else 71776119061217280;
        const delta:i7 = @as(i7,to) - @as(i7,from);

        if(piece != .pawn){
            return false;
        }
        // enpassant requires move two
        if(color == .white and delta != 16){
            return false;
        }

        // enpassant requires move two
        if(color == .black and delta != -16){
            return false;
        }

        if(((pawnStartingPosition >> from) & 1) == 1){
            if(color == .white){
                self.en_passant = to - 8; 
            }else{
                self.en_passant = to + 8; 
            }
           return true;
        }

        return false;
    }

    fn captureEnpassant(self:*Board, piece:Piece, color:Color, from:u6, to:u6) bool{
       _ = from;
        if(piece != .pawn){
            return false;
        }

        if(to != self.en_passant){
            return false;
        }


        if(color == .white){
             const captureMask:u64 = @as(u64, 1) << (to - 8);
             self.bp_bb ^= captureMask;
             return true;
        }
        else{
             const captureMask:u64 = @as(u64, 1) << (to + 8);
             self.wp_bb ^= captureMask;
             return true;
        }

        return false;
    }

    pub fn makeMove(self:*Board,piece:Piece, color:Color,from:u6, to:u6) MoveError!void{
        std.debug.print("can capture enpassant: {} enpassant value: {?} to value: {} --> ",.{self.capture_enpassant, self.en_passant, to});

        const allU64BitBoards = getArrayOfU64Boards(self);

        const pieceFromBoard = getBoardFromPiece(self, piece, color);

        // Ensures the piece you're moving is present on the from square
        if((pieceFromBoard.* >> from) & 1 != 1){
                std.debug.print("There is no {} {} on this square to move\n",.{color,piece});
                return MoveError.IlegalMove;
        }
        
        for(0..allU64BitBoards.len)|i|{
            if((allU64BitBoards[i].* >> to) & 1 == 1){
                std.debug.print("The board {} contians a piece on the square you want to move to, capturing the piece\n",.{i});
                //for testing value before printU64Bits(allU64BitBoards[i].*);
                const toMask:u64 = @as(u64,1)<<to;
                allU64BitBoards[i].* ^= toMask;
                //for testing value after printU64Bits(allU64BitBoards[i].*);
            }
        }

        

        
    
        std.debug.print("The sqaure you're moving to is empty, moving piece to square\n",.{});
        const mask:u64 = @as(u64,1)<<from | @as(u64,1)<<to; // setting the in the correct place
        //for testing mask printU64Bits(mask);
        pieceFromBoard.* ^= mask; // the mask will remove the piece from old position and put it to new position
        //for testing the move made printU64Bits(pieceFromBoard.*);

        // if enabled sest the enpassant flag if valid
        if(self.flag_enpassant and piece == .pawn and checkThenSetEnpassant(self, piece, color, from, to)){
            std.debug.print("Enpassant detected setting the flag at position {?}\n",.{self.en_passant});
            return; // we return early so enpassant isn't removed
        }

        else if(self.capture_enpassant and piece == .pawn and self.en_passant != null and to == self.en_passant ){
            if(captureEnpassant(self, piece, color, from, to)){
                std.debug.print("captured enpassant\n",.{});
            }else{
                std.debug.print("failed to capture",.{});
            }
        }

        self.en_passant = null;

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

pub fn printAsciiBoard(asciiBoard:[64]u8)void{
        var i:i7 = 7;
        while(i>=0):(i-=1){
            for(0..8)|j|{
                const pos = @as(u6,@intCast(i*8)) + @as(u6,@intCast(j));
                if(@mod(pos,8) == 0){
                    std.debug.print("\n",.{});
                }
                if(asciiBoard[pos]>=65 and asciiBoard[pos]<=90){
                    std.debug.print("\x1b[32m{c}\x1b[0m", .{asciiBoard[pos]});
                }
                else if(asciiBoard[pos]>=98 and asciiBoard[pos]<=122){
                    std.debug.print("\x1b[33m{c}\x1b[0m", .{asciiBoard[pos]});
                }
                else{
                    std.debug.print("{c}", .{asciiBoard[pos]});
                }
            }
        }
        std.debug.print("\n",.{});
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




