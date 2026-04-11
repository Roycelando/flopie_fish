const std = @import("std");
const flopie_fish = @import("flopie_fish");
const io = std.io;


// TODO: Refactor the std.out and std.in to make this code look cleaner [2026_04_06]
// TODO: Understand how the std.in and std.out actually work [2026_04_06]

pub fn menu() !u8{
    var stdout_buffer:[1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    while(true){
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
