# OpenVINO

## Model Optimizer

### Install Prerequisites
For all frameworks:

```sh
cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
./install_prerequisites.sh
```

Just for one framework:

```sh
cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
./install_prerequisites_tf.sh
```

### Darknet 
#### Convert YOLOv1 and YOLOv2 Models to the IR
Ref to the link: [Convert YOLOv1 and YOLOv2 Models to the IR](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_tf_specific_Convert_YOLO_From_Tensorflow.html#convert_yolov1_and_yolov2_models_to_the_ir)

Based on `/opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/yolo_v2_voc.json`, write your own `yolo_v2_xxx.json`(revise `anchors` and `classes` based on your darknet cfg file)

and then:

```
cd /opt/intel/openvino/deployment_tools/model_optimizer
python3 ./mo_tf.py --input_model <tf_yolov2>.pb --batch 1  --tensorflow_use_custom_operations_config /opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/<custom_yolov2>.json
```

Then one can find `<tf_yolov2_pb_filename>.bin`, `<tf_yolov2_pb_filename>.mapping`, `<tf_yolov2_pb_filename>.xml` in `/opt/intel/openvino/deployment_tools/model_optimizer`.

#### Convert YOLOv3 Model to IR
Just follow the instruction here: [Convert YOLOv3 Model to IR](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_tf_specific_Convert_YOLO_From_Tensorflow.html#yolov3-to-ir), the process is quite smooth.

#### model input: RGB -> BGR
Remember that when converting from tensorflow model to IR, we can specify `--reverse_input_channels` so that the model will expect BGR input image rather than RGB ones.
```sh
python3 mo_tf.py --input_model $TF_MODEL_PATH --tensorflow_use_custom_operations_config $JSON_PATH --batch 1 --reverse_input_channels
```

P.S. In darknet, it will convert image from BGR to RGB before training. [BGR or RGB order for image reading in darknet?](https://github.com/pjreddie/darknet/issues/427)

### TensorFlow
#### Convert frozen ssd_mobilenet_v2 to IR
This model is trained on COCO and will output 91 classes, [here](https://tech.amikelive.com/node-718/what-object-categories-labels-are-in-coco-dataset/) is the mapping.

Ref: [Tensorflow/models uses COCO 90 class ids although COCO has only 80 categories](https://stackoverflow.com/questions/50665110/tensorflow-models-uses-coco-90-class-ids-although-coco-has-only-80-categories)
```sh
wget http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v2_coco_2018_03_29.tar.gz
tar -xvf ssd_mobilenet_v2_coco_2018_03_29.tar.gz
cd ssd_mobilenet_v2_coco_2018_03_29
python3 /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model frozen_inference_graph.pb --tensorflow_object_detection_api_pipeline_config pipeline.config --reverse_input_channels --tensorflow_use_custom_operations_config /opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/ssd_v2_support.json
```
This will generate `frozen_inference_graph.xml` and `frozen_inference_graph.bin`.

To test them:
```sh
~/inference_engine_samples_build/intel64/Release/object_detection_sample_ssd -i <input_image> -m frozen_inference_graph.xml -d CPU
```
This will generate `out_0.bmp`, on which the bounding boxes are drawed.

Sample output:
```
[0,2] element, prob = 0.980039    (55,66)-(969,649) batch id : 0 WILL BE PRINTED!
# [curProposal, label] element, prob = confidence    (xmin,ymin)-(xmax,ymax) batch id : image_id
```

#### Convert unfrozen inception_resnet_v2 to IR
Follow [tensorflow-code-snippets/tf_freeze_checkpoint_to_pb](https://github.com/keineahnung2345/tensorflow-code-snippets/tree/master/tf_freeze_checkpoint_to_pb) to download the tensorflow checkpoint file and freeze it.

This model is trained on ImageNet and will output 1001 classes, where the 0th class is background, for the later 1000 classes, there is a [mapping from imagenet class id to class name](https://gist.github.com/yrevar/942d3a0ac09ec9e5eb3a).

Convert it to IR:
```sh
python3 /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model inception_resnet_v2.pb --reverse_input_channel --input_shape "(1,299,299,3)" --mean_values "(127.5,127.5,127.5)" --scale 127.5
```

Test:
```sh
~/inference_engine_samples_build/intel64/Release/classification_sample_async -i <input_image> -m inception_resnet_v2.xml -d CPU
```

Sample output:
```
classid probability
------- -----------
944     0.5505478  
940     0.3143223  
474     0.0010462  
924     0.0010045  
303     0.0009022  
507     0.0008387  
999     0.0008005  
894     0.0007374  
564     0.0007317  
785     0.0007239
```

### Caffe
#### Convert SqueezeNet_v1.1 to IR
Clone the repo [forresti/SqueezeNet](https://github.com/forresti/SqueezeNet.git):
```sh
git clone https://github.com/forresti/SqueezeNet.git
cd SqueezeNet/SqueezeNet_v1.1
```
The model is trained on ImageNet, and it will output 1000 classes.

Convert it to IR:
```sh
python3 /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model squeezenet_v1.1.caffemodel --input_proto deploy.prototxt
# the following is wrong but it could be helpful in other cases
# python3 /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model squeezenet_v1.1.caffemodel --input_proto deploy.prototxt --mean_values "data(123.68,116.779,103.939)" --scale_values "data(127.5)"
```

Test:
```sh
~/inference_engine_samples_build/intel64/Release/classification_sample_async -i <input_image> -m squeezenet_v1.1.xml -d CPU
```

### ONNX
#### Convert AlexNet to IR
This model is trained on ImageNet, and it will output 1000 classes.
```sh
wget https://s3.amazonaws.com/download.onnx/models/opset_8/bvlc_alexnet.tar.gz
tar -xzf bvlc_alexnet.tar.gz
cd bvlc_alexnet
python3 /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model model.onnx
```
Test: 
```sh
~/inference_engine_samples_build/intel64/Release/classification_sample_async -i <input_image> -m model.xml -d CPU
```

## Inference Engine
### Build samples
```sh
cd /opt/intel/openvino/deployment_tools/inference_engine/samples
./build_samples.sh
```
This will generate executable files in `~/inference_engine_samples_build`.

## Accuracy Checker
[Deep Learning accuracy validation framework](https://docs.openvinotoolkit.org/latest/_tools_accuracy_checker_README.html)
```sh
python3 setup.py install
```
If there is some problem related to `Pillow`, try reinstalling it:
```sh
pip install --no-cache-dir -I -i https://pypi.tuna.tsinghua.edu.cn/simple pillow
```
Sample usage:
[Accuracy Checker Sample](https://docs.openvinotoolkit.org/latest/_tools_accuracy_checker_sample_README.html)
```sh
accuracy_check -c sample/sample_config.yml -m data/test_models -s sample
```
