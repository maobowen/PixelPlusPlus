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
	uint8_t* arr;
};

struct Img* load(char* path) {
    int width, height, bpp;
    int CHANNEL_NUM = 3;
    uint8_t* rgb_image = stbi_load(path, &width, &height, &bpp, 3);
    printf("loading_image completed!\n");
    struct Img *img;
    img = (struct Img *) malloc(sizeof(struct Img));
    img->length = width * height * CHANNEL_NUM;
    img->arr = rgb_image;
    img->width = width;
    img->height = height;
    return img;
}

void close(struct Img* img, int i) {
  stbi_image_free(img->arr);
  if (i == 0)
    free(img);
  printf("close completed!\n");
}

void save(struct Img *img, char* path) {
    stbi_write_png(path, img->width, img->height, 3, img->arr, img->width * 3);
    printf("saving image completed!\n");
}

#ifdef BUILD_TEST
int main() {
    struct Img *img = load("./img2.png");
    save(img, "./img2_new.png");
    stbi_image_free(img->arr);
    free(img);
}
#endif
