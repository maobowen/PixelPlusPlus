#include <stdint.h>
#include <stdio.h>
#include <memory.h>
/*#define STB_IMAGE_IMPLEMENTATION
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image.h"
#include "stb_image_write.h"*/

struct Img {
	int length;
        int height;
        int width;
	uint8_t* arr;
};

void close(struct Img* img) {
  stbi_image_free(img->arr);
  free(img);
  printf("close completed!\n");
}

#ifdef BUILD_TEST
int main() {
    struct Img *img = load("./img2.png");
    stbi_image_free(img->arr);
    free(img);
}
#endif
