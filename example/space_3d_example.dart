import 'package:space_3d/space_3d.dart';

void main() {
  FHDRaster raster = FHDRaster(width: 300, heigth: 300);
  Space3D space3D = Space3D();
  space3D.cargarObjetos('./obj_in/xyz_blocks.obj');
  for (Object3D obj in space3D.objetos3d) {
    print(obj.name);
  }
  HomogeneousPoint hpoint = HomogeneousPoint(Vertice.fromPoints(1000, 2, 3));
  hpoint.multiplyMatrix(MatrixTrasform.proyection(10));
  var a = hpoint.vertice3D;
  print(a);
  space3D.getObject3DByName('cubex').color = Color(160, 0, 0);
  space3D.getObject3DByName('cubey').color = Color(0, 160, 0);
  space3D.getObject3DByName('cubez').color = Color(0, 0, 160);
  space3D.getObject3DByName('textx').color = Color(255, 0, 0);
  space3D.getObject3DByName('texty').color = Color(0, 255, 0);
  space3D.getObject3DByName('textz').color = Color(0, 0, 255);
  space3D.getObject3DByName('cube_center').color = Color(220, 220, 220);
  space3D.scaleUnifrom(50);
  print("${space3D.getObject3DByName('textz').min_z}, ${space3D.getObject3DByName('textz').max_z}");
  print("${space3D.getObject3DByName('cube_center').min_z}, ${space3D.getObject3DByName('cube_center').max_z}");
  space3D.draw(raster, ViewFace.xy, DrawMode.scaline);
  raster.write('./image/top.ppm');

  raster.clearPixels();
  space3D.draw(raster, ViewFace.xz, DrawMode.scaline);
  raster.write('./image/front.ppm');

  raster.clearPixels();
  space3D.draw(raster, ViewFace.yz, DrawMode.scaline);
  raster.write('./image/rigth.ppm');
}
