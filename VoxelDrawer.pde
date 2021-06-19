import peasy.*;
import latkProcessing.*;

PeasyCam cam;
Latk latk;
VoxelGrid grid;
Kmeans kmeans;
int numCentroids = 10;
int dim = 128;
int voxelSize = 1;
boolean doFill = true;
ArrayList<PVector> allPoints;

void setup() {
  size(800, 800, P3D);
  latk = new Latk(this, "layer_test.latk");  
  latk.normalize();
  allPoints = new ArrayList<PVector>();
  
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
        if (stroke.points.size() > 1) {
          allPoints.add(stroke.points.get(0).co);
          for (int l=1; l<stroke.points.size(); l++) {
            PVector p1 = stroke.points.get(l).co;
            allPoints.add(p1);
            PVector p2 = stroke.points.get(l-1).co;
            int x1, y1, z1, x2, y2, z2;
            x1 = int(p1.x * dim);
            y1 = int(p1.y * dim);
            z1 = int(p1.z * dim);
            x2 = int(p2.x * dim);
            y2 = int(p2.y * dim);
            z2 = int(p2.z * dim);
            grid.drawLine(x1, y1, z1, x2, y2, z2);
          }
        }        
      }
    }
  }
  
  kmeans = new Kmeans(allPoints, numCentroids);
}

void draw() {
  lights();
  background(0);
  
  grid.run();
  //latk.run();
  if (doFill) {
  if (!kmeans.ready) {
    kmeans.run();
  } else {     
      for (int l=0; l<kmeans.clusters.size(); l++) {
        Cluster cluster = kmeans.clusters.get(l);
        PVector p1 = cluster.centroid;
        for (int m=0; m<cluster.points.size(); m++) {
          PVector p2 = cluster.points.get(m);
          int x1, y1, z1, x2, y2, z2;
          x1 = int(p1.x * dim);
          y1 = int(p1.y * dim);
          z1 = int(p1.z * dim);
          x2 = int(p2.x * dim);
          y2 = int(p2.y * dim);
          z2 = int(p2.z * dim);
          grid.drawLine(x1, y1, z1, x2, y2, z2);
        }
      }
      
      doFill = false;
    }
  }
  
  
  surface.setTitle("" + frameRate);
}
