class VoxelGrid {
  
  int dim;
  int voxelSize;
  int drawReps;
  Voxel[] voxels;
  
  VoxelGrid(int _dim, int _voxelSize) {
    dim = _dim;
    drawReps = dim*dim;
    voxelSize = _voxelSize;
    voxels = new Voxel[dim*dim*dim];
    
    int counter = 0;
    for (int x = 0; x<dim; x++) {
      for (int y = 0; y<dim; y++) {
        for (int z = 0; z<dim; z++) {
          voxels[counter++] = new Voxel(x, y, z);
        }
      }
    }
  }  
  
  int getIndex(int _x, int _y, int _z) {
    return _x + dim * (_y + dim * _z); //x + WIDTH * (y + DEPTH * z);
  }
  
  Voxel getVoxel(int _x, int _y, int _z) {
    return voxels[getIndex(_x, _y, _z)];
  }
  
  boolean getVoxelValue(int _x, int _y, int _z) {
    return voxels[getIndex(_x, _y, _z)].active;
  }

  void setVoxel(int _x, int _y, int _z, Voxel _v) {
    voxels[getIndex(_x, _y, _z)] = _v;
  }
  
  void setVoxelValue(int _x, int _y, int _z, boolean _b) {
    voxels[getIndex(_x, _y, _z)].active = _b;
  }
  
  void voxelOn(int _x, int _y, int _z) {
    voxels[getIndex(_x, _y, _z)].active = true;
  }
  
  void voxelOff(int _x, int _y, int _z) {
    voxels[getIndex(_x, _y, _z)].active = false;
  }
  
  void drawLine(int _x1, int _y1, int _z1, int _x2, int _y2, int _z2) {  
    PVector p1 = new PVector(_x1, _y1, _z1);
    PVector p2 = new PVector(_x2, _y2, _z2);
    for (int i=0; i<drawReps; i++) {
      float val = (float) i / (float) drawReps;
      PVector p3 = p1.lerp(p2, val);
      int x = int(p3.x);
      int y = int(p3.y);
      int z = int(p3.z);
      voxelOn(x, y, z);
    }
  }
  
  void run() {
    noStroke();
    fill(255, 192);
    pushMatrix();
    translate(-dim*voxelSize/2, -dim*voxelSize/2, 0);
    for (int i=0; i<voxels.length; i++) {
      if (voxels[i].active) {
        pushMatrix();
        translate(voxels[i].x * voxelSize, voxels[i].y * voxelSize, voxels[i].z * voxelSize);
        box(voxelSize, voxelSize, voxelSize);
        popMatrix();
      }
    }
    popMatrix();
  }
   
}
