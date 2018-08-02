/*Author IQram, written this code on April -2014*/
/*This is very simple camera app, It uses the mobile camera and tries to save the picture*/
/*This take the picture in the stealth way, it can be used as spy cam and I didn't add codes for video recording this is only for taking pictures NO Audio as well*/

import ketai.camera.*;
import ketai.net.*;
import ketai.ui.*;
import ketai.sensors.*;
import ketai.data.*;

import ketai.camera.*;

KetaiCamera cam;

void setup() {
  orientation(LANDSCAPE);
  cam = new KetaiCamera(this, width, height, 24);
  println(cam.list());
  cam.setCameraID(0);   //I'm using the back camera
  imageMode(CENTER);
  stroke(255);
  textSize(24);
}

void draw() { 
  background(0);
  if (!cam.isStarted())
  {
    pushStyle(); 
    textAlign(CENTER, CENTER);
    String info = "CameraInfo:\n";
    info += "current camera: "+ cam.getCameraID()+"\n";
    info += "image dimensions: "+ cam.width +
      "x"+cam.height+"\n";     //(5)
    info += "photo dimensions: "+ cam.getPhotoWidth() +
      "x"+cam.getPhotoHeight()+"\n"; 
    info += "flash state: "+ cam.isFlashEnabled()+"\n"; 
    text(info, width/2, height/2); 
    popStyle(); //(9)
  }
  else
  {
    image(cam, width/2, height/2);
  }
  drawUI();
}

void drawUI() {
  fill(0, 128);
  rect(0, 0, width/4, 40);
  rect(width/4, 0, width/4, 40);
  rect(2*(width/4), 0, width/4, 40);
  rect(3*(width/4), 0, width/4-1, 40);

  fill(255);
  if (cam.isStarted())
    text("stop", 10, 30);
  else
    text("start", 10, 30);

  text("IQcamera", (width/4)+10, 30);
  text("flash", 2*(width/4)+ 10, 30);
  text("save", 3*(width/4)+10, 30); 
}

void mousePressed() {
  if (mouseY <= 40) {
    if (mouseX > 0 && mouseX < width/4)
    {
      if (cam.isStarted())
      {
        cam.stop();
      }
      else
      {
        if (!cam.start())
          println("Failed to start camera.");
      }
    }
    else if (mouseX > width/4 && mouseX < 2*(width/4))
    {
      int cameraID = 0;
      if (cam.getCameraID() == 0)
        cameraID = 1;
      else
        cameraID = 0;
      cam.stop();
      cam.setCameraID(cameraID);
      cam.start();
    }
    else if (mouseX >2*(width/4) && mouseX < 3*(width/4))
    {
      if (cam.isFlashEnabled())
        cam.disableFlash();
      else
        cam.enableFlash();
    }
    else if (mouseX > 3*(width/4) && mouseX < width) 
    {
      if (cam.isStarted()) cam.savePhoto(); 
    }
  }
}

void onSavePhotoEvent(String filename) 
{
  cam.addToMediaLibrary(filename); 
}

void onCameraPreviewEvent()
{
  cam.read();
}
