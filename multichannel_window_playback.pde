
import processing.video.*;

Movie movie1;
Movie movie2;

VideoWindow win1;
VideoWindow win2;

void setup() {
  size(400, 400);
  // Create two separate windows for the videos
  win1 = new VideoWindow("/Users/amimid/Desktop/projects/video/multichannel_window_playback/data/dream.mp4", 100, 100);
  win2 = new VideoWindow("/Users/amimid/Desktop/projects/video/multichannel_window_playback/data/dream_copy.mp4", 600, 100);
}

void draw() {
  background(0);
  fill(255);
  text("Main window – nothing here!", 100, height/2);
}

// This class represents a separate Processing window
class VideoWindow extends PApplet {
  Movie myMovie;

  String filename;
  int xpos, ypos;

  VideoWindow(String file, int x, int y) {
    this.filename = file;
    this.xpos = x;
    this.ypos = y;

    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    size(640, 360);
  }

  public void setup() {
    surface.setLocation(xpos, ypos);
    myMovie = new Movie(this, filename);
    myMovie.loop(); // loop the video
  }

  public void draw() {
    background(0);
    if (myMovie.available()) {
      myMovie.read();
    }
    image(myMovie, 0, 0, width, height);
  }
}
