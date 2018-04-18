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
    int length1 = width1 * height1 * CHANNEL_NUM;

    const char* path2 = "./extended-pos-0-v.png";
    int width2 = width1;
    int height2 = height1 * 2;
    int length2 = width2 * height2 * CHANNEL_NUM;
    uint8_t image2[length2];

    int k = 0;
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < length1; j++)
            image2[k++] = image1[j];

    stbi_write_png(path2, width2, height2, CHANNEL_NUM, image2, width2 * CHANNEL_NUM);
    stbi_image_free(image1);
    return 0;
}