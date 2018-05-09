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

    // Grey scaling
    for (int i = 0; i < length1; i += 3)
    {
        int temp = (image1[i] + image1[i + 1] + image1[i + 2]) / 3;
        image1[i] = temp;
        image1[i + 1] = temp;
        image1[i + 2] = temp;
    }

    // Apply Sci-Fi effect
    uint8_t *image3 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);
    uint8_t *image4 = (uint8_t*) malloc(sizeof(uint8_t) * length1);
    scifi(image3, width1, height1, image4);
    stbi_image_free(image3);

    // Collage
    int width2 = width1;
    int height2 = height1 * 2;
    int length2 = width2 * height2 * CHANNEL_NUM;
    uint8_t *image2 = (uint8_t*) malloc(sizeof(uint8_t) * length2);

    collage(image1, width1, height1, image4, image2);

    const char *path2 = "./demo-2-v.png";
    stbi_write_png(path2, width2, height2, CHANNEL_NUM, image2, width2 * CHANNEL_NUM);

    stbi_image_free(image1);
    free(image2);
    free(image4);
    return 0;
}
