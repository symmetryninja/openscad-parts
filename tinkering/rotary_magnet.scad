include <sn_tools.scad>

mag1 = [25, 5, 5];
mag2 = [25, 3, 5];

for (i = [0:15]) {
  Rz(i * 22.5) {
    Tx(mag1[0] * 1.5) ccube(mag1);
    Rz(11.25) Tx(mag1[0] * 1.5) ccube(mag2);
  }
}