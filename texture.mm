#import <Foundation/Foundation.h>
#import <algorithm>
#define STB_IMAGE_WRITE_IMPLEMENTATION
#define STBI_ONLY_PNG
#import "stb_image_write.h"

const unsigned int COLORS[12] = {
	0xFF1200E6,
	0xFF0098F3,
	0xFF00F1FF,
	0xFF1FC38F,
	0xFF449900,
	0xFF969E00,
	0xFFE9A000,
	0xFFB76800,
	0xFF88201D,
	0xFF830792,
	0xFF7F00E4,
	0xFF4F00E5
};

int main(int argc, char *argv[]) {
		
	int w = 1920*2;
	int h = 1080*2;
	
	int type = 10;
	if(type<0) type = 0;
	else if(type>=11) type = 11;
	
	int rows = (type/3.0)+1;
	int cols = std::min(type+1,3);
	
	unsigned int *texture = new unsigned int[(w*rows)*(h*cols)];
	
	for(int i=0; i<h*cols; i++) {
		for(int j=0; j<w*rows; j++) {
			texture[i*(w*rows)+j] = 0xFF808080;
		}
	}
	
	for(int n=0; n<=type; n++) {
		
		int x = (n/3)*w;
		int y = (n%3)*h;

		for(int i=0; i<h; i++) {
			for(int j=0; j<w; j++) {
				texture[(i+y)*(w*rows)+(j+x)] = COLORS[n];
			}
		}
	}
	
	stbi_write_png([[NSString stringWithFormat:@"./docs/%05d.png",type] UTF8String],(w*rows),(h*cols),4,(void const*)texture,(w*rows)<<2);
	
	delete[] texture;
}