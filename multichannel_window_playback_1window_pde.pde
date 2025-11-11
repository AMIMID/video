import processing.video.*;

Movie movie1, movie2;

void setup() {
  size(1280, 360);
  movie1 = new Movie(this, "/Users/amimid/Desktop/projects/video/multichannel_window_playback/data/dream.mp4");
  movie2 = new Movie(this, "/Users/amimid/Desktop/projects/video/multichannel_window_playback/data/dream_copy.mp4");
  movie1.play();
  movie2.play();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  background(0);
  image(movie1, 0, 0, width/2, height);
  image(movie2, width/2, 0, width/2, height);
}
