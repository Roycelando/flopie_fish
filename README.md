# 🌸 Flopie Fish

> A bitboard chess engine built in Zig. Cute name, serious engine.

![Zig](https://img.shields.io/badge/Zig-0.15-green) ![Status](https://img.shields.io/badge/status-WIP-pink) ![License](https://img.shields.io/badge/license-MIT-blue)

---

## 🌺 About the name

The name **Flopie** comes from three places at once:

- 🌸 **Florencia** — a friend's baby girl whose name means "flower." She goes by Flopie.
- 🌿 **Flopie from Palworld** — the flowery little creature whose design inspired the connection.
- ♟ **Stockfish** — the engine this is lovingly named after (and nowhere near as good as). Yet.

---

## About

Flopie Fish is a chess engine written from scratch in Zig using a 12-bitboard representation. Designed with a human body metaphor — skeleton, nerves, brain, body — each layer builds cleanly on the one below it. Stockfish better watch out.

---

## Project structure

```
src/
├── main.zig
├── skeleton/        # types, structs, bitboard state
├── nerves/          # move generation, attack masks
├── brain/           # search, evaluation, move ordering
├── body/            # UCI protocol, game loop, I/O
└── immune_system/   # tests
```

## Architecture

Each layer only depends on the ones below it — nothing reaches upward.

```
main → body → brain → nerves → skeleton
```

| Layer | Role |
|---|---|
| 🦴 skeleton | Raw data — board state, piece types, enums |
| ⚡ nerves | Movement rules — attack masks, move generation |
| 🧠 brain | Thinking — search, evaluation, move ordering |
| 🫀 body | Outer shell — UCI protocol, game loop, I/O |
| 🛡 immune_system | Tests |

---

## Roadmap

- [x] Project structure & CLI menu
- [ ] Board representation (12 bitboards)
- [ ] Attack & move generation
- [ ] Human vs human game loop
- [ ] Evaluation function
- [ ] Alpha-beta search
- [ ] UCI protocol

---

## Getting started

```bash
git clone https://github.com/you/flopie_fish
cd flopie_fish
zig build run
```

---

## Built with

- [Zig 0.15.2](https://ziglang.org)
- [Chess Programming Wiki](https://www.chessprogramming.org)

---

*Dedicated to Florencia 🌸*
