import peasy.*;

PeasyCam cam;
VoxelGrid grid;
int dim = 64;
int voxelSize = 3;

void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 300);
  
  grid = new VoxelGrid(dim, voxelSize);
  for (int i=0; i<100; i++) {
    int x1 = int(random(dim));
    int y1 = int(random(dim));
    int z1 = int(random(dim));
    int x2 = int(random(dim));
    int y2 = int(random(dim));
    int z2 = int(random(dim));
    grid.drawLine(x1, y1, z1, x2, y2, z2);
  }
}

void draw() {
  background(0);
  
  grid.run();
}
