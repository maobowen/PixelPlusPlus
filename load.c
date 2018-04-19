#include <stdint.h>
#include <stdio.h>
#include <memory.h>
#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"

struct Img {
	int length;
    int height;
    int width;
	int* arr;
};

struct Img* load(char* path) {
    int width, height, bpp;
    int CHANNEL_NUM = 3;
    uint8_t* rgb_image = stbi_load(path, &width, &height, &bpp, 3);
    printf("loading_image completed!\n");
    struct Img *img;
    img = (struct Img *) malloc(sizeof(struct Img));
    img->length = width * height * CHANNEL_NUM;
    img->width = width;
    img->height = height;
    img->arr = (int*) malloc(sizeof(int) * (img->length));
    for (int i = 0; i < img->length; i++) {
        (img->arr)[i] = (int)rgb_image[i];
    }
    stbi_image_free(rgb_image);
    return img;
}

void save(struct Img *img, char* path) {
    uint8_t arr_i8[img->length];
    for (int i = 0; i < img->length; i++) {
        arr_i8[i] = (uint8_t) (img->arr[i]);
    }
    stbi_write_png(path, img->width, img->height, 3, arr_i8, img->width * 3);
    printf("saving image completed!\n");
}

void close(struct Img* img, int i) {
  free(img->arr);
  if (i == 0)
    free(img);
  printf("close completed!\n");
}

#ifdef BUILD_TEST
int main() {
    struct Img *img = load("./img2.png");
    save(img, "./img2_new.png");
    close(img, 0);
}
#endif
