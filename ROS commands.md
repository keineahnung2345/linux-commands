# ROS commands

## catkin_make && source devel/setup.bash
[roscd: No such package/stack 'beginner_tutorials'](https://answers.ros.org/question/65003/roscd-no-such-packagestack-beginner_tutorials/)
```sh
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
