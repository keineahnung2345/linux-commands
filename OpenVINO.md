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

### Caffe
#### Convert SqueezeNet_v1.1 to IR
Clone the repo [forresti/SqueezeNet](https://github.com/forresti/SqueezeNet.git):
```sh
git clone https://github.com/forresti/SqueezeNet.git
cd SqueezeNet/SqueezeNet_v1.1
python /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model squeezenet_v1.1.caffemodel --input_proto deploy.prototxt # --mean_values "data(123.68,116.779,103.939)" --scale_values "data(127.5)"
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
