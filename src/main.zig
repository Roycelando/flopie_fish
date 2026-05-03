const std = @import("std");
const root = @import("root.zig");
const flopie_fish = @import("flopie_fish");
const io = std.io;
const Board = root.Board;

// TODO: Refactor the std.out and std.in to make this code look cleaner [2026_04_06]
// TODO: Understand how the std.in and std.out actually work [2026_04_06]

pub fn menu() !u8{
    var stdout_buffer:[1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;
    
    while(true) {
        try stdout.print("\nWelcom to the flopie fish project! A chess engine written in zig by Royce Lando\n",.{});
        try stdout.print("=====================================\n",.{});
        try stdout.print("==             Menu                ==\n",.{});
        try stdout.print("=====================================\n\n",.{});
        try stdout.print("1. Play manually\n",.{});
        try stdout.print("2. Play Flopie Fish\n",.{});
        try stdout.print("*. Exit\n",.{});
        try stdout.flush();
        try stdout.print("input: ",.{});

        var user_input:[]const u8 = undefined;
        var stdin_buffer: [256]u8 = undefined;
        var stdin_reader = std.fs.File.stdin().reader(&stdin_buffer);
        const stdin = &stdin_reader.interface;
        user_input = try stdin.takeDelimiterExclusive('\n');

        const choice = try std.fmt.parseInt(u8, user_input, 10);

        if(choice == 1 or choice == 2 or choice == 3){
            return choice;
        }
    }

    return 0;
}

pub fn main() !void {

    const val = 4;
    if(val == 4){
        var b = root.Board{};
        try b.makeMove(.pawn,.black,51,11);
        try b.makeMove(.pawn,.black,53,13);

        try b.makeMove(.pawn,.white,10,51);
        try b.makeMove(.pawn,.white,14,53);
 
        root.printAsciiBaord(b.getAsciiBoard());

        if(root.isLegalPawnMove(&b, .white, 51, 60)){
            std.debug.print("Is legal move\n",.{});
        }else{
            std.debug.print("Illegal move\n",.{});
        }
        return;
    }

    if (val == 3){
        var b = root.Board{};
        try b.makeMove(.pawn, .white, 9, 33);
        try b.makeMove(.pawn, .black, 48, 32);
        try b.makeMove(.pawn, .black, 50, 34);
        try b.makeMove(.pawn, .white, 33 , 42); 
        try b.makeMove(.pawn, .black, 52, 36);
        try b.makeMove(.pawn, .white, 42 , 44); 


        try b.makeMove(.pawn, .black, 51, 27);
        try b.makeMove(.pawn, .black, 49, 25);
        try b.makeMove(.pawn, .white, 10, 26);
        //try b.makeMove(.pawn, .black, 27 , 18);
        //try b.makeMove(.pawn, .black, 25 , 16);

        root.printAsciiBaord(b.getAsciiBoard());


        // if(root.isLegalPawnMove(&b, .black, 13, 5)){
        //     try b.makeMove(.pawn,.black,13,5);
        //     std.debug.print("Legal move\n",.{});
        //     root.printAsciiBaord(b.getAsciiBoard());
        // }else{
        //     std.debug.print("Illegal move\n",.{});
        // }

        //root.printU64Bits(b.getCopyOfAllPieceOccupancy());

        // if(root.canPawnMoveTwo(b, .black, square)){
        //     std.debug.print("The pawn on square {} CAN move two\n",.{square});
        // }
        // else{
        //     std.debug.print("The pawn on square {} CANT move two\n",.{square});
        // }
        //
       // _ = try root.isLegalPawnMove(&b, .white, 10, 18);
        return;
    }

    if(val == 1) {
        var b = root.Board{};
        try b.makeMove(.queen, .white, 3, 23);
        try b.makeMove(.pawn, .white, 11,27);
        try b.makeMove(.pawn, .white, 10,26);
        try b.makeMove(.pawn, .black, 51,35);

        var allBoards:u64 =0;

        for(b.getArryOfU64Boards())|item|{
            allBoards |= item.*;
        }

        root.printU64Bits(allBoards);

        return;
    }

    if(val == 2){
        var b = root.Board{};

        try b.makeMove(.queen, .white, 3, 23);
        try b.makeMove(.pawn, .white, 11,27);
        try b.makeMove(.pawn, .white, 10,26);
        try b.makeMove(.pawn, .black, 51,35);
        //try b.makeMove(.bishop, .white, 3-1,64-1);

        const asciiBoard = b.getAsciiBoard();
        root.printAsciiBaord(asciiBoard);
        return;
    }

    const choice:u8 = menu() catch |err| {
        std.debug.print("Something went wrong with the selection: {}\n",.{err});
        return;
    };

    //===================================================
    // Maps the choice the the correct selection instance
    //===================================================
    switch (choice) {
        1 => {
            std.debug.print("You chose to play a manual game\n",.{});
            const b:Board = Board{};
            root.printAllU64BitBoards(b);
            // manualGame();
        },
        2 => {
            std.debug.print("You chose to play flopie fish\n",.{});
            // playFlopie()
        },
        else => {
            std.debug.print("Exiting the program...\n",.{});
            return;            
        }
    }
}
