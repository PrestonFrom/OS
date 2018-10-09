Learning how to write an operating system from scratch, following https://github.com/cfenollosa/os-tutorial.

Other useful resources:
<list>
<li>NASM docs (https://www.nasm.us/doc/)</li>
<li>Fedora docs on virtualization (https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/)</li>
<li>Writing a Simple Operating System -- from Scratch PDF (http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf)
<list>

<br><br>
For ease of use, add this to your bashrc:
alias qemu="echo 'USING qemu-system-x86_64!!!!' && qemu-system-x86_64 "
```bash
alias qemu="echo 'USING qemu-system-x86_64!!!!' && qemu-system-x86_64 "
nasm_and_run() {
    echo "Building $1.asm"
    nasm -f bin "$1".asm -o "$1".bin -l "$1".lst
    if [ $? -eq 0 ]
    then
        echo "Trying with qemu"
        qemu "$1".bin
    fi
}```

