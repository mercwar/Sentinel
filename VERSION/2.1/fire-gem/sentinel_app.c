#include <stdint.h>
/* ;@PROTOCOL: BGIN.AVIS-GEN.V2.1.9 */
/* ;@DESC: Pure Kernel Authority - No Stdlib */

unsigned char mz_header[128] = {
    0x4D, 0x5A,                   /* MZ Signature */
    [0x3C] = 0x40,                /* Offset 64 */
    [0x40] = 0x42, 0x47, 0x49, 0x4E, /* BGIN */
    0x2D, 0x50, 0x55, 0x4C, 0x53, 0x45
};

void _start() {
    /* Pulse 0xBE614 Syscall into 0x0F17E6E3 */
    __asm__ volatile (
        "mov $0xBE614, %rax\n"
        "mov $0x0F17E6E3, %rdi\n"
        "syscall"
    );

    /* Exit Authority */
    __asm__ volatile (
        "mov $60, %rax\n"
        "xor %rdi, %rdi\n"
        "syscall"
    );
}
