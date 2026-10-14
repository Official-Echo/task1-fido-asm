# Реалізація завдання на ASM

Виконання Завдання 1 для FIdo: знайти вузол на позиції ⌊2n/3⌋ - 1 в однозв'язному списку.

Бібліотека це функція `get_two_thirds_node` у `compileable/compileable.asm` на x86-64 NASM. До неї додатково створено простий C-драйвер для командного рядка `compileable/main.c`.

## Вхідні дані

Якщо подано одне число n, буде зроблено список довжиною n зі значеннями 0..n-1.

## Запуск

У Releases є два готові файли: `compileable` для Linux (ELF64) і `compileable.exe` для Windows (x86-64 PE32+).

Linux:

```bash
chmod +x compileable
./compileable 5
```

Windows:

```bat
compileable.exe 5
```

## Збірка

Потрібні NASM і gcc або clang. Команди виконуються в теці `compileable/`.

Linux:

```bash
nasm -f elf64 compileable.asm -o compileable.o
gcc main.c compileable.o -o compileable
```

Windows:

```bash
nasm -f win64 compileable.asm -o compileable.obj
clang main.c compileable.obj -o compileable.exe
```

## Опис

Алгоритм робить один прохід, O(n) за часом і O(1) за пам'яттю. Вказівник `res` зсувається на кожному кроці, крім тих, де `len mod 3 = 1`. Остача за модулем 3 рахується без `div`, через множення на магічну константу.

## Походження коду

Цей асемблер отримано з Rust-версії завдання за допомогою [cargo-show-asm](https://github.com/pacak/cargo-show-asm):

```bash
cargo asm --lib --simplify
```

Вивід збережено як `original.asm` (Windows x64 ABI, синтаксис LLVM). У `cleared.asm` той самий код з нормальними іменами регістрів і міток та з коментарями. Щоб отримати `compileable.asm`, код було переписано під NASM, де було прибрано `qword ptr`, `movabs` замінено на `mov`, `shr rdx` на `shr rdx, 1`, додано `default rel`, `global`, макрос `arg1` та секцію `.note.GNU-stack` для ELF. Драйвер `main.c` написано окремо.
