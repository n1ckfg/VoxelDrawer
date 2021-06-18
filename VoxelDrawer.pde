VoxelGrid grid;
int dim = 64;

void setup() {
  size(800, 800, P3D);
  grid = new VoxelGrid(dim, 5);
  for (int i=0; i<100; i++) {
    int x = int(random(dim));
    int y = int(random(dim));
    int z = int(random(dim));
    grid.voxelOn(x, y, z);
  }
}

void draw() {
  background(0);
  
  grid.run();
}
