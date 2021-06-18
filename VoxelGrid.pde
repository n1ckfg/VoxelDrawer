class VoxelGrid {
  
  int dim;
  int voxelSize;
  Voxel[] voxels;
  
  VoxelGrid(int _dim, int _voxelSize) {
    dim = _dim;
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
  
  void run() {
    pushMatrix();
    translate(dim*voxelSize, dim/2*voxelSize, -dim/2*voxelSize);
    for (int i=0; i<voxels.length; i++) {
      if (voxels[i].active) {
        strokeWeight(voxelSize);
        stroke(255, 127);
        pushMatrix();
        translate(voxels[i].x * voxelSize, voxels[i].y * voxelSize, voxels[i].z * voxelSize);
        point(0,0);
        popMatrix();
      }
    }
    popMatrix();
  }
   
}
