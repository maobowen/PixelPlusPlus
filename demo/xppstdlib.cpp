/* Author: Bowen (bm2734) */

#include <cstdint>
#include "xppstdlib.h"
using namespace std;

void apply_convolution(uint8_t *image1, int width, int height, uint8_t *image2, Kernel kernel)
{
    int y_offset = (kernel.width - 1) / 2;
    int x_offset = (kernel.height - 1) / 2;
    int sum = 0;
    for (auto k : kernel.kernel)
        sum += k;
    for (int i = 0; i < height; i++) 
        for (int j = 0; j < width; j++)
        {
            int r = (width * i + j) * 3;
            int g = r + 1;
            int b = r + 2;
            if (i - x_offset >= 0 && i + x_offset < height && j - y_offset >= 0 && j + y_offset < width)
            {
                int kernel_r = 0, kernel_g = 0, kernel_b = 0;
                for (int m = 0; m < kernel.height; m++)
                    for (int n = 0; n < kernel.width; n++)
                    {
                        int r_tmp = (width * (i + m - x_offset) + j + n - y_offset) * 3;
                        int g_tmp = r_tmp + 1;
                        int b_tmp = r_tmp + 2;
                        kernel_r += kernel.kernel[(kernel.height - m - 1) * kernel.width + (kernel.width - n - 1)] * image1[r_tmp];
                        kernel_g += kernel.kernel[(kernel.height - m - 1) * kernel.width + (kernel.width - n - 1)] * image1[g_tmp];
                        kernel_b += kernel.kernel[(kernel.height - m - 1) * kernel.width + (kernel.width - n - 1)] * image1[b_tmp];
                    }
                int r_before_normalize;
                int g_before_normalize;
                int b_before_normalize;
                if (sum != 0)
                {
                    r_before_normalize = kernel_r / sum;
                    g_before_normalize = kernel_g / sum;
                    b_before_normalize = kernel_b / sum;
                }
                else
                {
                    r_before_normalize = kernel_r - 128;
                    g_before_normalize = kernel_g - 128;
                    b_before_normalize = kernel_b - 128;
                }
                image2[r] = (r_before_normalize > 255) ? 255 : r_before_normalize;
                image2[r] = (r_before_normalize < 0) ? 0 : image2[r];
                image2[g] = (g_before_normalize > 255) ? 255 : g_before_normalize;
                image2[g] = (g_before_normalize < 0) ? 0 : image2[g];
                image2[b] = (b_before_normalize > 255) ? 255 : b_before_normalize;
                image2[b] = (b_before_normalize < 0) ? 0 : image2[b];
            }
            else
            {
                image2[r] = image1[r];
                image2[g] = image1[g];
                image2[b] = image1[b];
            }
        }
}

void collage(uint8_t *image1, int width, int height, uint8_t *image2, uint8_t *image3)
{
    int length = width * height * CHANNEL_NUM;
    int k = 0;
    for (int i = 0; i < length; i++)
        image3[k++] = image1[i];
    for (int i = 0; i < length; i++)
        image3[k++] = image2[i];
}

void crop(uint8_t *image1, int width1, uint8_t *image2, int width2, int height2, int x, int y)
{
    for (int i = 0; i < height2; i++)
        for (int j = 0; j < width2; j++)
            for (int k = 0; k < CHANNEL_NUM; k++)
                image2[(i * width2 + j) * CHANNEL_NUM + k] = image1[((x + i) * width1 + (y + j)) * CHANNEL_NUM + k];
}

void flip(uint8_t *image1, int width, int height, uint8_t *image2)
{
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            for (int k = 0; k < CHANNEL_NUM; k++)
                image2[(i * width + j) * CHANNEL_NUM + k] = image1[(i * width + (width - 1 - j)) * CHANNEL_NUM + k];
}

void rotate(uint8_t *image1, int width, int height, uint8_t *image2, int angle)
{
    if (angle == 180)
        for (int i = 0; i < height; i++)
            for (int j = 0; j < width; j++)
            {
                int pixel = (i * width + j) * 3;
                int pixel2 = ((height - 1 - i) * width + (width - 1 - j)) * 3;
                image2[pixel] = image1[pixel2];
                image2[pixel + 1] = image1[pixel2 + 1];
                image2[pixel + 2] = image1[pixel2 + 2];
            }
    else if (angle == 90)
        for (int i = 0; i < height; i++)
            for (int j = 0; j < width; j++)
            {
                int pixel = (i * width + j) * 3;
                int pixel2 = (j * height + (height - 1 - i)) * 3;
                image2[pixel2] = image1[pixel];
                image2[pixel2 + 1] = image1[pixel + 1];
                image2[pixel2 + 2] = image1[pixel + 2];
            }
    else if (angle == -90)
        for (int i = 0; i < height; i++)
            for (int j = 0; j < width; j++) {
                int pixel = (i * width + j) * 3;
                int pixel2 = ((width - 1 - j) * height + i) * 3;
                image2[pixel2] = image1[pixel];
                image2[pixel2 + 1] = image1[pixel + 1];
                image2[pixel2 + 2] = image1[pixel + 2];
            }
}

void scifi(uint8_t *image1, int width, int height, uint8_t *image2)
{
    int length = width * height * CHANNEL_NUM;
    uint8_t image3[length];
    for (int i = 0; i < length; i++)
        image3[length - 1 - i] = image1[i];
    rotate(image3, width, height, image2, 180);
}
