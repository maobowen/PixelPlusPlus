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

    const char* path2 = "./extended-pos-3-v.png";
    uint8_t image2[length1];

    vector<int> kernel = {1, 4, 7, 4, 1, 4, 16, 26, 16, 4, 7, 26, 41, 26, 7, 4, 16, 26, 16, 4, 1, 4, 7, 4, 1};
    int sum = 0;
    for (auto k : kernel) { sum += k; }
    for (int i = 0; i < height1; i++) {
    	for (int j = 0; j < width1; j++) {
    		int r = (width1 * i + j) * 3;
    		int g = r + 1;
    		int b = r + 2;
    		if (i - 2 >= 0 && i + 2 < height1 && j - 2 >= 0 && j + 2 < width1) {
    			int kr = 0, kg = 0, kb = 0;
    			for (int m = 0; m < 5; m++) {
    				for (int n = 0; n < 5; n++) {
    					int r_tmp = (width1 * (i + m - 2) + j + n - 2) * 3;
    					int g_tmp = r_tmp + 1;
    					int b_tmp = r_tmp + 2;
    					kr += kernel[(5-m-1) * 5 + (5-n-1)] * image1[r_tmp];
    					kg += kernel[(5-m-1) * 5 + (5-n-1)] * image1[g_tmp];
    					kb += kernel[(5-m-1) * 5 + (5-n-1)] * image1[b_tmp];
    				}
    			}
    			if (sum != 0) {
    				image2[r] = kr / sum;
    				image2[g] = kg / sum;
    				image2[b] = kb / sum;
    			} else {
    				image2[r] = kr - 128;
    				image2[g] = kg - 128;
    				image2[b] = kb - 128;
    			}
    		} else { image2[r] = image1[r]; image2[g] = image1[g]; image2[b] = image1[b]; }
    	}
    }
    for (int k = 0; k < 3; k++) {
    	for (int i = 0; i < height1; i++) {
    		for (int j = 0; j < width1; j++) {
    			int pixel = image2[(i * width1 + j) * 3 + k];
    			if (pixel < 0) { image2[(i * width1 + j) * 3 + k] = 0; }
    			if (pixel > 255) { image2[(i * width1 + j) * 3 + k] = 255; }
    		}
    	}
    }
    stbi_write_png(path2, width1, height1, CHANNEL_NUM, image2, width1 * CHANNEL_NUM);
    stbi_image_free(image1);
    return 0;
}
