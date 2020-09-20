# shiny-upsetr
This is a shiny implementation deployed with docker of the [UpSetR](https://github.com/hms-dbmi/UpSetR) R package for UpSet plots.

# Running using Docker
To run shiny-upsetr on a Cloud please create a Docker image of it using the Dockerfile provided. Once the image is ready it can be run either locally or on a Cloud.

## Building the image
Then go into this folder and build your image, giving it a name by using this command :
```
docker build -t upsetr . 
```

## Starting a container
After you have built the image, you can create a container and run it locally:
```
docker run --rm -p 3838:3838 upsetr
```
Finally, the shiny-upsetr app will be accessible at http://localhost:3838

# Online availability
The shiny-upsetr App is freely available at
> https://dongwei.shinyapps.io/upsetr/

or

> https://hiplot.com.cn/advance/upsetr

![image.png](https://upload-images.jianshu.io/upload_images/8723194-8267e24061218c0b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# Support
If you have any questions, or found any bug in the program, please write to us at dongw26@mail2.sysu.edu.cn

# Citation
If you use UpSetR in a paper, please cite:

> Jake R Conway, Alexander Lex, Nils Gehlenborg UpSetR: An R Package for the Visualization of Intersecting Sets and their Properties doi: https://doi.org/10.1093/bioinformatics/btx364

The original technique and the interactive visualization tool implementing the approach are described here:

> Alexander Lex, Nils Gehlenborg, Hendrik Strobelt, Romain Vuillemot, Hanspeter Pfister,
UpSet: Visualization of Intersecting Sets,
IEEE Transactions on Visualization and Computer Graphics (InfoVis '14), vol. 20, no. 12, pp. 1983–1992, 2014.
doi: https://doi.org/10.1109/TVCG.2014.2346248
