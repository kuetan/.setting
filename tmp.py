from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import sys

import tensorflow as tf

from tensorflow.examples.tutorials.mnist import input_data
from tensorflow.python.client import timeline

a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)

jit_scope = tf.contrib.compiler.jit.experimental_jit_scope  # Using JIT compilation
with jit_scope():
    add = tf.add(a, b)
    mul = tf.multiply(a, b)

with tf.Session() as sess:
    # Run every operation with variable input
    print("Addition with variables: %i" % sess.run(add, feed_dict={a: 2, b: 3}))
    print("Multiplication with variables: %i" % sess.run(mul, feed_dict={a: 2, b: 3}))
