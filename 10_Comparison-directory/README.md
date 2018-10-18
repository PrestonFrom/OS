This directory consolidates all the necessary files to switch to 32-bit mode and print to the screen with a bootloader to more easily compare the files I produced with the original OS tutorial GitHub page. The reason for this is that using the files I produced doesn't work -- so here's an attempt to figure out what I did wrong!
<br><br>
First problem: the 16-bit string printing functions were too big to fit in the limited memory held by the bootloader. Looking at the file again, we see that it was originally written to run on its own, so it was including the necessary buffer to get to 512 bytes. The print.asm file has been refactored to do only priting now!
<br><br>
Second problem: In 32bit-print.asm, the address set for the VIDEO_MEMORY constant was wrong! It was supposed to be 0xb8000, but was set to 0xb80000. (Extra zero)
<br><br>
Third problem:  In 32bit-print.asm, the jmp back to the beginning of the print loop was missing, so it would only print the first character of the string.
<br><br>
Fourth problem: Not sure how big of an impact this had, but there was an additional label (gdt_null) immediately after gdt_start. This wasn't in the original, but not sure if this would have messed up byte calculations or not. Removing it does not seem to have had a significant impact.
<br><br>
Fifth problem: In 32bit-switch.asm, there was an issue with the address loaded into ebp -- it was being set to 0x9000 instead of 0x90000.
<br><br>
After looking at the above issues, the problem still continued. At this point, commenting out 32bit-gdt.asm and pasting in the contents from the GitHub tutorial worked, so we can confidently say that the issue is with the GDT. As it turns out, the issue was in both gdt_data and gdt_code -- the third item was dw 0x0, but it should have been db 0x0. This was causing the memory layout of these sections to be off by 1 byte.
