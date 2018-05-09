#ifndef __XPPSTDLIB_H__
#define __XPPSTDLIB_H__
#define CHANNEL_NUM 3

#include <vector>
using namespace std;

struct Kernel {
    vector<int> kernel;
    int width;
    int height;
};

void apply_convolution(uint8_t *image1, int width, int height, uint8_t *image2, Kernel kernel);
void collage(uint8_t *image1, int width, int height, uint8_t *image2, uint8_t *image3);
void crop(uint8_t *image1, int width1, uint8_t *image2, int width2, int height2, int x, int y);
void flip(uint8_t *image1, int width, int height, uint8_t *image2);
void rotate(uint8_t *image1, int width, int height, uint8_t *image2, int angle);
void scifi(uint8_t *image1, int width, int height, uint8_t *image2);

#endif
