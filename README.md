
# Batch resize images for YoloV5 dataset (Mac OS)

This script automatically resizes web scrapped images within a folder to YOLOv5s, YOLOv5m, YOLOv5l default dimension of 640px by 640px. 

- Aspect ratio preservation: images maintain their original aspect ratio. This ensures that the visual integrity of your images remains intact, preventing any distortion or loss of quality.

- Automatic letterboxing: If any side of an image falls short of 640px width, the script automatically adds black letterboxing to maintain the specified dimensions.

This script is user-friendly, selecting input and output folders uses the native Finder app on Mac OS.

*PS: The default image sizes recommended by the YOLOV5 architecture are intended to optimize training performance and ensure compatibility. However, they are not mandatory, and you have the flexibility to adjust them according to your specific requirements.*
## Run Locally

Clone the project

```bash
  git clone
```
Install dependencies

```bash
  brew install imagemagick
```

Go to the project directory

```bash
  cd dataset_resizer
```
Make script executable

```bash
  chmod +x photo_set_resize.sh
```

Start the script

```bash
  ./photo_set_resize.sh
```

## Screenshots

![Demo](demo.gif)

## License

[MIT](https://choosealicense.com/licenses/mit/)

