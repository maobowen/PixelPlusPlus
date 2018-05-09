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

    // Dim the image by scaling 
    for (int i = 0; i < length1; i++)
    {
        image1[i] = (int)((double)image1[i] * 0.6);
        if (image1[i] > 255)
            image1[i] = 255;
    }

    // Rotate
    uint8_t *image3 = (uint8_t*) malloc(sizeof(uint8_t) * length1);
    rotate(image1, width1, height1, image3, 180);

    // Sharpen
    Kernel sharpen = {
        {0, -1, 0, -1, 5, -1, 0, -1, 0},
        3,
        3
    };
    uint8_t *image2 = (uint8_t*) malloc(sizeof(uint8_t) * length1);
    apply_convolution(image3, width1, height1, image2, sharpen);

    const char *path2 = "./demo-1-v.png";
    stbi_write_png(path2, width1, height1, CHANNEL_NUM, image2, width1 * CHANNEL_NUM);

    stbi_image_free(image1);
    free(image2);
    free(image3);
    return 0;
}
