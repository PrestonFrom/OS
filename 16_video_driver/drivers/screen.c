#include "screen.h"
#include "../drivers/ports.h"

int get_cursor_position() {
    port_byte_out(REG_SCREEN_CTRL, 14);
    int position = port_byte_in(REG_SCREEN_DATA);
    position = position << 8;
    port_byte_out(REG_SCREEN_CTRL, 15);
    position += port_byte_in(REG_SCREEN_DATA);

    return position * 2;
}

void set_cursor_position(int position) {
    position /= 2;
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(position >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, (position & 0xff));
}

void clear_screen() {
    char* vga = VIDEO_ADDRESS;
    int pos = 0;
    int max_pos = (MAX_COLS) * (MAX_ROWS) * 2;
    for (; pos < max_pos; pos += 2) {
        vga[pos] = ' ';
        vga[pos + 1] = WHITE_ON_BLACK;
    }
}

int print_char(char letter, int cells) {
    if (letter != '\n') {
        char* vga = VIDEO_ADDRESS;
        vga[cells] = letter;
        vga[cells + 1] = WHITE_ON_BLACK;
        set_cursor_position(cells + 2);
        cells += 2;
    } else {
        cells /= 2;
        int row = cells / MAX_COLS;
        cells = (row + 1) * MAX_COLS * 2;
        set_cursor_position(cells);
    }
    return cells;
}

void print_error() {
    char* vga = VIDEO_ADDRESS;
    vga[MAX_CELLS] = 'E';
    vga[MAX_CELLS + 1] = RED_ON_WHITE;
    set_cursor_position(MAX_CELLS);
}

void kprint_at(char* message, int col, int row) {
    int cells = 0;
    if (col == -1 || row == -1) {
        cells = get_cursor_position();
    }
    else { 
        int converted_rows = (row) * MAX_COLS;
        int total_cols = (col) + converted_rows;
        cells = total_cols * 2;
    }
    
    int i = 0;
    while (message[i] != 0) {
        if (cells >= MAX_CELLS) {
            print_error();
        }
        cells = print_char(message[i], cells);
        ++i;
    }
}

void kprint(char* message) {
    kprint_at(message, -1, -1);
}
