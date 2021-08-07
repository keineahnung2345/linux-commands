# ROS commands

## catkin_create_pkg
[CreatingPackage](http://wiki.ros.org/cn/ROS/Tutorials/catkin/CreatingPackage)
```sh
cd ~/catkin_ws/src # must cd here and then catkin_create_pkg!
catkin_create_pkg beginner_tutorials std_msgs rospy roscpp
```

## remove package
[catkin: move/remove package and workspace](https://answers.ros.org/question/105576/catkin-moveremove-package-and-workspace/)

Just delete the folder. 

## catkin_make && source devel/setup.bash
[roscd: No such package/stack 'beginner_tutorials'](https://answers.ros.org/question/65003/roscd-no-such-packagestack-beginner_tutorials/)
```sh
# in "catkin_ws" directory
# catkin_create_pkg learning_tf2 tf2 tf2_ros roscpp rospy turtlesim
catkin_make
source devel/setup.bash
# roscd learning_tf2
```
This solves `roscd: No such package/stack 'learning_tf2'`.

## /usr/bin/env: ‘python’: No such file or directory
[Unable to broadcast the turtle position to tf2 , Tutorial: turtle_tf2_demo.launch and getting only one turtle](https://answers.ros.org/question/357423/unable-to-broadcast-the-turtle-position-to-tf2-tutorial-turtle_tf2_demolaunch-and-getting-only-one-turtle/)
```sh
sudo ln -s /usr/bin/python3 /usr/bin/python
```

## [ERROR] [1628307689.337043638]: [registerPublisher] Failed to contact master at [localhost:11311].  Retrying...
This can be solved by running:

```sh
roscore
```

[roscore](http://wiki.ros.org/roscore)
```
roscore is a collection of nodes and programs that are pre-requisites of a ROS-based system. 
You must have a roscore running in order for ROS nodes to communicate. It is launched using the roscore command. 
```

## Exception thrown:"turtle1" passed to lookupTransform argument source_frame does not exist. 
In [Writing a tf2 broadcaster (C++)](http://wiki.ros.org/tf2/Tutorials/Writing%20a%20tf2%20broadcaster%20%28C%2B%2B%29),
when running:
```sh
roslaunch learning_tf2 start_demo.launch
```
It shows:
```
Failure at 1628308374.969766010
Exception thrown:"turtle" passed to lookupTransform argument source_frame does not exist. 
The current list of frames is:
Frame turtle1 exists with parent world.
```
It turns out that we should create a folder named `launch` and put `start_demo.launch` there.
```sh
# in catkin_ws/src/learning_tf2
mkdir launch
vim launch/start_demo.launch # fill it
# and then roslaunch again
roslaunch learning_tf2 start_demo.launch
```
It will successfully outputs:
```
At time 1628308379.856
- Translation: [6.698, 4.107, 0.000]
- Rotation: in Quaternion [0.000, 0.000, -0.606, 0.796]
            in RPY (radian) [0.000, 0.000, -1.301]
            in RPY (degree) [0.000, 0.000, -74.531]
```

