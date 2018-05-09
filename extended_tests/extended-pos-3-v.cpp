/* Author: Jiayang (jl4305), Bowen (bm2734) */

#include <memory.h>
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../stb_image.h"
#include "../stb_image_write.h"
#include "xppstdlib.h"

int main() {
    const char *path1 = "./image.png";
    int width1, height1, bpp;
    uint8_t *image1 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);
    int length1 = width1 * height1 * CHANNEL_NUM;

    const char *path2 = "./extended-pos-3-v.png";
    uint8_t *image2 = (uint8_t*) malloc(sizeof(uint8_t) * length1);

    Kernel filter = {
        {1, 4, 7, 4, 1, 4, 16, 26, 16, 4, 7, 26, 41, 26, 7, 4, 16, 26, 16, 4, 1, 4, 7, 4, 1},
        5,
        5
    };
    apply_convolution(image1, width1, height1, image2, filter);

    stbi_write_png(path2, width1, height1, CHANNEL_NUM, image2, width1 * CHANNEL_NUM);
    stbi_image_free(image1);
    free(image2);
    return 0;
}
