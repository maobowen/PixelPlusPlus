/* Author: Bowen (bm2734) */

#include <memory.h>
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../stb_image.h"
#include "../stb_image_write.h"
#include "xppstdlib.h"

int main()
{
    const char *path1 = "./image.png";
    int width1, height1, bpp;
    uint8_t *image1 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);
    uint8_t *image3 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);

    const char *path2 = "./extended-pos-0-v.png";
    int width2 = width1;
    int height2 = height1 * 2;
    int length2 = width2 * height2 * CHANNEL_NUM;
    uint8_t *image2 = (uint8_t*) malloc(sizeof(uint8_t) * length2);

    collage(image1, width1, height1, image3, image2);

    stbi_write_png(path2, width2, height2, CHANNEL_NUM, image2, width2 * CHANNEL_NUM);
    stbi_image_free(image1);
    free(image2);
    free(image3);
    return 0;
}