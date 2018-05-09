/* Author: Bowen (bm2734) */

#include <memory.h>
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../stb_image.h"
#include "../stb_image_write.h"
#include "xppstdlib.h"

int main()
{
    const char *path1 = "./jc.png";
    int width1, height1, bpp;
    uint8_t *image1 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);
    int length1 = width1 * height1 * CHANNEL_NUM;

    // Stack filters
    Kernel emboss = {
        {-2, -1, 0, -1, 1, 1, 0, 1, 2},
        3,
        3
    };
    Kernel blur = {
        {1, 1, 1, 1, 1, 1, 1, 1, 1},
        3,
        3
    };
    uint8_t *image3 = (uint8_t*) malloc(sizeof(uint8_t) * length1);
    /*apply_convolution(image1, width1, height1, image3, emboss);*/
    memcpy(image3, image1, sizeof(uint8_t) * length1);
    uint8_t *image4 = (uint8_t*) malloc(sizeof(uint8_t) * length1);
    for (int i = 0; i < 7; i++)
    {
        apply_convolution(image3, width1, height1, image4, blur);
        memcpy(image3, image4, sizeof(uint8_t) * length1);
    }
    apply_convolution(image4, width1, height1, image3, emboss);

    // Flip
    flip(image3, width1, height1, image4);

    // Crop
    uint8_t *image2 = (uint8_t*) malloc(sizeof(uint8_t) * length1);
    crop(image4, width1, image2, 550, 650, 350, 200);

    const char *path2 = "./demo-0-v.png";
    stbi_write_png(path2, 550, 650, CHANNEL_NUM, image2, 550 * CHANNEL_NUM);

    stbi_image_free(image1);
    free(image2);
    free(image3);
    free(image4);
    return 0;
}
