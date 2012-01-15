#include "nf2util.c"

unsigned get_register(unsigned reg) {
  struct nf2device nf2;
  unsigned val;

  nf2.device_name = "nf2c0";
  check_iface(&nf2);
  openDescriptor(&nf2);

  readReg(&nf2, reg, &val);

  closeDescriptor(&nf2);

  return val;
}

void set_register(unsigned reg, unsigned val) {
  struct nf2device nf2;

  nf2.device_name = "nf2c0";
  check_iface(&nf2);
  openDescriptor(&nf2);

  writeReg(&nf2, reg, val);

  closeDescriptor(&nf2);
}
