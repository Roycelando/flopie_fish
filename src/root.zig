const board_file = @import("skeleton/board.zig");
const piece_file = @import("skeleton/piece.zig");
const chess_rules = @import("brain/chess_rules.zig");

//==========================
// Types
//==========================

//board.zig types
pub const Board = board_file.Board;

//piece.zig types
pub const  Piece = piece_file.Piece;
pub const  Color = piece_file.Color;

//==========================
// Errors
//==========================

//board.zig types
pub const MoveError = board_file.MoveError;


//==========================
// Functions
//==========================

// board.zig functions
pub const printU64Bits = board_file.printU64Bits;
pub const printAllU64BitBoards = board_file.printAllU64BitBoards;
pub const printAsciiBaord = board_file.printAsciiBoard;
pub const getOccupancyOfColourU64Bits = board_file.getOccupancyOfColourU64Bits;
pub const generateRookAttakcBoard = board_file.generateRookAttakcBoard;

// piece.zig functions
pub const pieceValue = piece_file.pieceValue;

//chess_rules.zig functions
pub const isLegalPawnMove = chess_rules.isPawnMoveLegal;
pub const isKnightMoveLegal = chess_rules.isKnightMoveLegal;
pub const canPawnMoveTwo = chess_rules.canPawnMoveTwo;


