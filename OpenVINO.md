# OpenVINO

## Model Optimizer

### Convert YOLOv1 and YOLOv2 Models to the IR
Ref to the link: [Convert YOLOv1 and YOLOv2 Models to the IR](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_tf_specific_Convert_YOLO_From_Tensorflow.html#convert_yolov1_and_yolov2_models_to_the_ir)

Based on `/opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/yolo_v2_voc.json`, write your own `yolo_v2_xxx.json`(revise `anchors` and `classes` based on your darknet cfg file)

and then:

```
cd /opt/intel/openvino/deployment_tools/model_optimizer
python3 ./mo_tf.py --input_model <tf_yolov2>.pb --batch 1  --tensorflow_use_custom_operations_config /opt/intel/openvino/deployment_tools/model_optimizer/extensions/front/tf/<custom_yolov2>.json
```

Then one can find `<tf_yolov2_pb_filename>.bin`, `<tf_yolov2_pb_filename>.mapping`, `<tf_yolov2_pb_filename>.xml` in `/opt/intel/openvino/deployment_tools/model_optimizer`.

### Convert YOLOv3 Model to IR
Just follow the instruction here: [Convert YOLOv3 Model to IR](https://docs.openvinotoolkit.org/latest/_docs_MO_DG_prepare_model_convert_model_tf_specific_Convert_YOLO_From_Tensorflow.html#yolov3-to-ir), the process is quite smooth.

### Convert SqueezeNet_v1.1 to IR
Clone the repo [forresti/SqueezeNet](https://github.com/forresti/SqueezeNet.git):
```sh
git clone https://github.com/forresti/SqueezeNet.git
cd SqueezeNet/SqueezeNet_v1.1
python /opt/intel/openvino/deployment_tools/model_optimizer/mo.py --input_model squeezenet_v1.1.caffemodel --input_proto deploy.prototxt # --mean_values "data(123.68,116.779,103.939)" --scale_values "data(127.5)"
```

### model input: RGB -> BGR
Remember that when converting from tensorflow model to IR, we can specify `--reverse_input_channels` so that the model will expect BGR input image rather than RGB ones.
```sh
python3 mo_tf.py --input_model $TF_MODEL_PATH --tensorflow_use_custom_operations_config $JSON_PATH --batch 1 --reverse_input_channels
```

P.S. In darknet, it will convert image from BGR to RGB before training. [BGR or RGB order for image reading in darknet?](https://github.com/pjreddie/darknet/issues/427)

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
