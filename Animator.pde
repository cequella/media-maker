class Animator {
  private float m_framerate = 60.0;
  private float m_velocity  = 1.0/m_framerate;
  private float m_current   = 0.0;
  private float m_start     = 0.0;
  private float m_end       = 1.0;
  private float m_offset    = 0.0;
  
  Animator(float t_start, float t_end, float t_framerate){
    start(t_start).end(t_end).framerate(t_framerate).reset();
  }
  Animator(float t_start, float t_end){
    start(t_start).end(t_end).reset();
  }
  Animator(float t_secDuration){
    duration(t_secDuration).reset();
  }
  Animator(){
  }
  
  Animator start(float t_start){
    m_start = t_start;
    return this;
  }
  Animator end(float t_end){
    m_end = t_end+m_offset;
    return this;
  }
  Animator offset(float t_offset){
    m_offset =  t_offset;
    m_end    += t_offset;
    return this;
  }
  Animator duration(float t_secDuration){
    m_velocity = 1.0/(t_secDuration*m_framerate);
    return this;
  }
  Animator framerate(float t_framerate){
    m_velocity = 1.0/t_framerate;
    m_framerate = t_framerate;
    return this;
  }
  Animator reset(){
    m_current = m_start;
    return this;
  }
  
  float start(){
    return m_start;
  }
  float end(){
    return m_end;
  }
  float update(){
    m_current = min(m_end, m_current+m_velocity);
    return m_current;
  }
  float current(){
    if(m_current < m_offset){
      return 0.0;
    } else {
      return m_current-m_offset;
    }
  }
  float remaining(){
    return (m_end-m_offset)-current();
  }
  boolean finished(){
    return (m_current==m_end);
  }
  
  // Examples
  color fadeColor(color from, color to){
    float c = current();
    float r = remaining();
    
    color out = color(
        red(from)*r + red(to)*c,
        green(from)*r + green(to)*c,
        blue(from)*r + blue(to)*c,
        alpha(to)
      );
    return out;
  }
  color alphaBlend(color to){
    float c = current();
    
    color out = color(
        red(to),
        green(to),
        blue(to),
        alpha(to)*c
      );
    return out;
  }
  PImage fadeImage(color from, PImage to){
    PImage out = createImage(to.width, to.height, ARGB);
    
    for(int i=0; i<to.width; i++)for(int j=0; j<to.height; j++){
      color temp = this.fadeColor(from, to.get(i, j));
      out.set(i, j, temp);
    }
    
    return out;
  }
  PImage blendImage(PImage to){
    PImage out = createImage(to.width, to.height, ARGB);
    
    for(int i=0; i<to.width; i++)for(int j=0; j<to.height; j++){
      color temp = this.alphaBlend(to.get(i, j));
      out.set(i, j, temp);
    }
    
    return out;
  }
}