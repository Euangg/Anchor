shader_type canvas_item;

uniform vec4 outline_color:source_color=vec4(0.0,0.0,0.0,1.0);
uniform float outline_width=1.0;

uniform int sample_count=32;

varying float modulate;
void vertex() {modulate=COLOR.a;}

void fragment() {
	float center_alpha=COLOR.a;
	
	float max_alpha=center_alpha;
	for (int d=0;d<sample_count;++d){
		float angle=float(d)/float(sample_count)*2.0*PI;
		for(float r=1.0;r<=outline_width;r+=1.0){
			vec2 offset=vec2(cos(angle),sin(angle))*TEXTURE_PIXEL_SIZE*r;
			float sample_alpha=texture(TEXTURE,UV+offset).a;
			max_alpha=max(max_alpha,sample_alpha);
		}
	}
	
	//执行描边渲染
	if(center_alpha<=0.9){
		COLOR=outline_color;
		COLOR.a*=max_alpha*modulate;
	}
}