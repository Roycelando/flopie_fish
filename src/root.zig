const board_file = @import("skeleton/board.zig");
const piece_file = @import("skeleton/piece.zig");

pub const printU64Bits = board_file.printU64Bits;
pub const printAllU64BitBoards = board_file.printAllU64BitBoards;
pub const Board = board_file.Board;

pub const  Piece = piece_file.Piece;
pub const  Color = piece_file.Color;
pub const pieceValue = piece_file.pieceValue;

