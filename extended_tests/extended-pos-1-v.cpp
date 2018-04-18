#include <cstdio>
#include <cstdint>
#include <memory.h>
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "../stb_image.h"
#include "../stb_image_write.h"
#define CHANNEL_NUM 3
using namespace std;

int main()
{
    const char* path1 = "./image.png";
    int width1, height1, bpp;
    uint8_t* image1 = stbi_load(path1, &width1, &height1, &bpp, CHANNEL_NUM);

    const char* path2 = "./extended-pos-1-v.png";
    int x = 0;
    int y = 350;
    int width2 = 300;
    int height2 = 540;
    int length2 = width2 * height2 * CHANNEL_NUM;
    uint8_t image2[length2];

    for (int i = 0; i < height2; i++)
        for (int j = 0; j < width2; j++)
            for (int k = 0; k < CHANNEL_NUM; k++)
                image2[(i * width2 + j) * CHANNEL_NUM + k] = image1[((x + i) * width1 + (y + j)) * CHANNEL_NUM + k];

    stbi_write_png(path2, width2, height2, CHANNEL_NUM, image2, width2 * CHANNEL_NUM);
    stbi_image_free(image1);
    return 0;
}