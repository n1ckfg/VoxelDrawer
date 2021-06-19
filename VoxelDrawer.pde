import peasy.*;
import latkProcessing.*;

PeasyCam cam;
Latk latk;
VoxelGrid grid;
int dim = 128;
int voxelSize = 1;
boolean doFill = false;

void setup() {
  size(800, 800, P3D);
  latk = new Latk(this, "layer_test.latk");  
  latk.normalize();
  cam = new PeasyCam(this, 400);
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  grid = new VoxelGrid(dim, voxelSize);
  for (int i=0; i<latk.layers.size(); i++) {
    LatkLayer layer = latk.layers.get(i);
    for (int j=0; j<layer.frames.size(); j++) {
      LatkFrame frame = layer.frames.get(j);
      for (int k=0; k<frame.strokes.size(); k++) {
        LatkStroke stroke = frame.strokes.get(k);
        LatkPoint rootPoint = stroke.points.get(stroke.points.size()/2);
        if (stroke.points.size() > 1) {
          for (int l=1; l<stroke.points.size(); l++) {
            LatkPoint p1 = stroke.points.get(l);
            LatkPoint p2 = stroke.points.get(l-1);
            int x1, y1, z1, x2, y2, z2;
            x1 = int(p1.co.x * dim);
            y1 = int(p1.co.y * dim);
            z1 = int(p1.co.z * dim);
            if (doFill) {
              x2 = int(rootPoint.co.x * dim);
              y2 = int(rootPoint.co.y * dim);
              z2 = int(rootPoint.co.z * dim);
            } else {
              x2 = int(p2.co.x * dim);
              y2 = int(p2.co.y * dim);
              z2 = int(p2.co.z * dim);
            }
            grid.drawLine(x1, y1, z1, x2, y2, z2);
          }
        }
      }
    }
  }
}

void draw() {
  lights();
  background(0);
  
  grid.run();
  //latk.run();
  
  surface.setTitle("" + frameRate);
}
