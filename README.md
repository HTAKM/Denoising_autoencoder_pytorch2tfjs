# About this
This is an experiment for converting an model from PyTorch to Tensorflow.js.
The overall process of such conversion can be summarized by:
PyTorch -> ONNX -> Tensorflow -> Tensorflow.js
I show this experiment just to tell you how I perform such action.

# Package version

    python == 3.11.11
    numpy == 1.26.4
    torch == 2.6.0+cu124
    tensorflow == 2.18.0
    tensorflowjs == 4.22.0
    keras == 3.8.0
    onnx == 1.17.0
    onnx2tf == 1.27.10
    

# Conversion from PyTorch model to ONNX model
This is likely the easier part. However, not all modules in PyTorch can be converted into ONNX modules.
For example, in my experiment, MaxUnpool2d is not supported in ONNX.
An attempt is implemented to try to solve this problem, but does not work due to lack of backward function for support autograd AD.
Some notable observations are found.
1. The PyTorch model must be set to evaluation mode by <code>model.eval()</code>.
2. The model input in the <code>torch.onnx.export(...)</code> can be random, as it only saves the input shape.

# Conversion from ONNX model to Tensorflow model
A common way to perform such action is to use <code>prepare</code> from <code>onnx_tf.backend</code>.
However, as of making this conversion, it suffers from great compatibility issues.
Some modules in the <code>tensorflow_addons</code> cannot be found likely for conflicting or deprecating modules.
Therefore, instead I use another module <code>onnx2tf</code> to convert my ONNX model into Tensorflow model.
The <code>onnx2tf</code> module requires the following modules.

    pip install onnx onnx2tf 
    pip install onnx_graphsurgeon
    pip install ai_edge_litert
    pip install sng4onnx

## Conversion from Tensorflow model to Tensorflow.js model
At the final step, we use the Tensorflow.js converter to perform the final conversion (I perform this in WSL).

    pip install tensorflowjs

The final conversion is done by running the following command in the terminal:

    tensorflowjs_converter --input_format=keras model.h5 tfjs_model

