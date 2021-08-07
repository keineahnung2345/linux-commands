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
