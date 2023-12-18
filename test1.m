ur10 = loadrobot("universalUR10","DataFormat","row");
ur10.Gravity=[0,0,-9.81];
q=homeConfiguration(ur10);

x=0;
y=-1;
z=1;

tform=[ 1,0,0,x;
        0,1,0,y;
        0,0,1,z;
        0,0,0,1];


ik = inverseKinematics("RigidBodyTree",ur10);
weights = [0 0 0 1 1 1];
[conf,~] = ik("tool0",tform,weights,q);
q_end=conf;

env = {collisionBox(1,1,0.05),collisionCylinder(0.2,1),collisionCylinder(0.2,1)};%,collisionCylinder(0.2,1),collisionCylinder(0.2,1)};

env{1}.Pose(3, end) = -0.05;

env{2}.Pose(1, end) = 0.5;
env{2}.Pose(2, end) = -0.5;
env{2}.Pose(3, end) = 0.5;

env{3}.Pose(1, end) = -0.5;
env{3}.Pose(2, end) = 0.5;
env{3}.Pose(3, end) = 0.5;

% env{4}.Pose(1, end) = -0.5;
% env{4}.Pose(2, end) = 0.5;
% env{4}.Pose(3, end) = 0.5;
% 
% env{5}.Pose(1, end) = 0.5;
% env{5}.Pose(2, end) = 0.5;
% env{5}.Pose(3, end) = 0.5;

show(ur10,q);
hold on
show(env{1});
hold on
show(env{2});
hold on
show(env{3});

% hold on
% show(env{4});
% hold on
% show(env{5});

rrt=manipulatorRRT(ur10,env);
path=plan(rrt,q,q_end);
interpPath = interpolate(rrt,path,4);