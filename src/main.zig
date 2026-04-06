const std = @import("std");
const flopie_fish = @import("flopie_fish");
const io = std.io;


// TODO: Refactor the std.out and std.in to make this code look cleaner [2026_04_06]
// TODO: Understand how the std.in and std.out actually work [2026_04_06]

pub fn menu() !void{
    var stdout_buffer:[1024]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout = &stdout_writer.interface;

    try stdout.print("\nWelcom to the flopie fish project! A chess engine written in zig by Royce Lando\n",.{});
    try stdout.print("=====================================\n",.{});
    try stdout.print("==             Menu                ==\n",.{});
    try stdout.print("=====================================\n\n",.{});
    try stdout.print("1. Play manually\n",.{});
    try stdout.print("2. Play Flopie Fish\n",.{});
    try stdout.print("*. Exit\n",.{});
    try stdout.flush();

    try stdout.print("input: ",.{});
    var user_input:[]u8 = undefined;
    var stdin_buffer: [256]u8 = undefined;
    var stdin_reader = std.fs.File.stdin().reader(&stdin_buffer);
    const stdin = &stdin_reader.interface;
    user_input = try stdin.takeDelimiterExclusive('\n');

    const choice:u8 = try std.fmt.parseInt(u8, user_input, 10);
    //var trimmed_choice = std.mem.trim(u8, choice, &std.ascii.whitespace);

    std.debug.print("choice {} its type is {}\n",.{choice, @TypeOf(choice)});

    if(choice == 1){
        std.debug.print("its equl\n",.{});
    }

    while(choice != 1 and choice != 2 and choice != 3){
//      try stdout.print("input: ",.{});
//      try stdout.flush();
//      user_input = try stdin.takeDelimiterExclusive('\n');
//      choice = std.mem.trim(u8, user_input, &std.ascii.whitespace);
//      trimmed_choice = try std.fmt.parseInt(u8, choice, 10);

   }

}

pub fn main() !void {
    menu() catch |err|{
        std.debug.print("{}",.{err});
    };

}
