# Notes for Developers

## Image Manipulation

To read a PNG image, use the following statment:

```cpp
arr img = load("./img2.png");
```

- If an image is created by the `load` function, you **do not need** to set height and width, since it is read from an external file.
- If an image is created by the Pixel++ statement `arr img = init(length, height, width)`, you **do not need** to set height and width, since it is recorded by passing arguments.
- If a kernel or a filter is created by the Pixel++ statement `arr filter = [1,3,1, 1,3,1, 1,3,1]` and its shape is 3 by 3, the compiler only knows that its length is 9. It does not know the height or the width. You **need** to use the built-in function `set(filter, 3, 3);` to set the height and the width.

### Row-major Order

The pixel on row `i` and column `j` is on position (i, j). The array storing the pixels of an image is in **row-major** order. To get the pixel on position (i, j):

```cpp
int h = height(img);
ing w = width(img);
int red_pixel = img[(i * w + j) * 3];        /* red pixel on (i, j) */
int green_pixel = img[(i * w + j) * 3 + 1];  /* green pixel on (i, j) */
int blue_pixel = img[(i * w + j) * 3 + 2];   /* blue pixel on (i, j) */
```
