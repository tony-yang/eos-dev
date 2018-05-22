#include <system.h>

unsigned short *textmemptr;
int attrib = 0x0F;
int csr_x = 0, csr_y = 0;

#define COLS 80
#define ROWS 24

void cls() {
  unsigned blank;
  int i;

  blank = 0x20 | (attrib << 8);

  for (i = 0; i < ROWS/*25*/; i++) {
    memsetw(textmemptr + i * COLS, blank, COLS);
  }
  csr_x = 0;
  csr_y = 0;
}

/* Puts a single char on the screen */
void putch(unsigned char c) {
  unsigned short *where;
  unsigned att = attrib << 8;
  if (c == 0x08) {
    if (csr_x != 0) {
      csr_x--;
    }
  }
  /* Handles a tab by incrementing the cursor's x, divisible by 8 */
  else if (c == 0x09) {
    csr_x = (csr_x + 8) & ~(8 - 1);
  }
  /* Handle carriage return */
  else if (c == '\r') {
    csr_x = 0;
  }
  /* Handle newline with CR */
  else if (c == '\n') {
    csr_x = 0;
    csr_y++;
  }
  else if (c >= ' ') {
    where = textmemptr + (csr_y * COLS + csr_x);
    *where = c | att;
    csr_x++;
  }
  if (csr_x >= COLS) {
    csr_x = 0;
    csr_y++;
  }
}

void puts(unsigned char *text) {
  int i;
  for (i = 0; i < strlen((const char*)text); i++) {
    putch(text[i]);
  }
}

void settextcolor(unsigned char forecolor, unsigned char backcolor) {
  attrib = (backcolor << 4) | (forecolor & 0x0F);
}

void init_video(void) {
  textmemptr = (unsigned short *)0XB8000;
  cls();
}
