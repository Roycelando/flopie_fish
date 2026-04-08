const std = @import("std");
const flopie_fish = @import("flopie_fish");
const Io = std.Io;
const Init = std.process.Init;


// TODO: Refactor the std.out and std.in to make this code look cleaner [2026_04_06]
// TODO: Understand how the std.in and std.out actually work [2026_04_06]

pub fn menu(init:Init) !void{
    var stdout_buffer:[1024]u8 = undefined;
    var stdout = Io.File.stdout().writer(init.io, &stdout_buffer);
    const stdout_writer = &stdout.interface;


    

    

   const choice = while (true){
        try stdout_writer.print("\nWelcom to the flopie fish project! A chess engine written in zig by Royce Lando\n",.{});
        try stdout_writer.print("=====================================\n",.{});
        try stdout_writer.print("==             Menu                ==\n",.{});
        try stdout_writer.print("=====================================\n\n",.{});
        try stdout_writer.print("1. Play manually\n",.{});
        try stdout_writer.print("2. Play Flopie Fish\n",.{});
        try stdout_writer.print("3. Exit\n",.{});
        try stdout_writer.flush();
        try stdout_writer.print("input: ",.{});
        try stdout_writer.flush();

        var stdin_buffer:[1024]u8 = undefined;
        var stdin = Io.File.stdin().reader(init.io,&stdin_buffer); 
        var stdin_reader = &stdin.interface;

        const user_input:[]u8 = try stdin_reader.takeDelimiterExclusive(10);
        const choice:u8 = try std.fmt.parseInt(u8, user_input, 10);

        if(choice == 1 or choice == 2 or choice == 3){
            break choice;
        }
    } else 3;

    switch(choice){
        1 =>{
            try stdout_writer.print("You chose to play manually\n",.{});
            try stdout_writer.flush();
        },
        2 =>{
            try stdout_writer.print("You chose to play flopie\n",.{});
            try stdout_writer.flush();

        },
        3=>{
            try stdout_writer.print("You chose to exit\n",.{});
            try stdout_writer.flush();

        },
        else =>{
            try stdout_writer.print("Invalid option",.{});
            try stdout_writer.flush();
        }
    }


}

pub fn main(init: Init) !void {
    try menu(init);

}
