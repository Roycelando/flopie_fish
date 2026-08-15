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

## Current status

Move generation is underway. Board representation and move generation for **pawns** (including the double push and en passant), **knights**, and **rooks** are complete, each covered by unit tests that check generated attack boards against hand-verified expected boards. Sliding-piece attacks for bishops and queens are next, followed by king moves and the game loop.

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
- [x] Board representation (12 bitboards)
- [x] Move generation — pawns (incl. double push & en passant), knights, rooks (unit-tested)
- [ ] Move generation — bishops, queens (sliding-piece attacks)
- [ ] Move generation — king, plus castling and promotion
- [ ] Human vs human game loop
- [ ] Perft validation
- [ ] Evaluation function
- [ ] Alpha-beta search
- [ ] UCI protocol

---

## Testing

Move generation is verified with unit tests in `immune_system/`. Each test sets up a known position and asserts that the generated attack board for a piece matches a hand-verified expected bitboard. Pawns, knights, and rooks are covered so far; tests are added alongside each new piece.

Perft (full-tree node counting against known-correct totals) is planned once all pieces are generating moves — it catches edge cases that per-position unit tests can miss.

---

## Getting started

```bash
git clone https://github.com/Roycelando/flopie_fish
cd flopie_fish
zig build run
```

---

## Built with

- [Zig 0.15.2](https://ziglang.org)
- [Chess Programming Wiki](https://www.chessprogramming.org)
