#include <cstdio>
#include <cstdint>
#include <vector>
#include <memory.h>
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../stb_image.h"
#include "../stb_image_write.h"
#define CHANNEL_NUM 3
using namespace std;

int main() {
	const char* path1 = "./image.png";
    int width1, height1, bpp;
    uint8_t* image1 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);
    int length1 = width1 * height1 * CHANNEL_NUM;

    const char* path2 = "./extended-pos-5-v.png";
    uint8_t image2[length1];
    uint8_t image3[length1];
    for (int i = 0; i < length1; i++) {
	image3[length1 - 1 - i] = image1[i];
    }
	
    for (int i = 0; i < height1; i++) {
    	for (int j = 0; j < width1; j++) {
	    int pixel = (i * width1 + j) * 3;
	    int pixel2 = ((height - 1 - i) * width1 + (width1 - 1 - j)) * 3;
	    image2[pixel] = image3[pixel2];
	    image2[pixel + 1] = image3[pixel2 + 1];
	    image2[pixel + 2] = image3[pixel2 + 2];
	}
    }
    
    stbi_write_png(path2, width1, height1, CHANNEL_NUM, image2, width1 * CHANNEL_NUM);
    stbi_image_free(image1);
    return 0;
}
