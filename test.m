clear all;

ur10 = loadrobot("universalUR10",DataFormat="row");
ur10.Gravity=[0,0,-9.81];
q=homeConfiguration(ur10);
q_me=[0.1,0.2,0.3,2.7,0.6,0];
% show(ur10,q);
%showdetails(ur10)
%b=getBody(ur10,"base_link")
rrt=manipulatorRRT(ur10,{});
rrt.MaxConnectionDistance=0.25;
rrt.IgnoreSelfCollision=0;
rrt.SkippedSelfCollisions='parent';
path=plan(rrt,q,q_me);
t1=path(:,1);
t2=path(:,2);
t3=path(:,3);
t4=path(:,4);
t5=path(:,5);
t6=path(:,6);
t=linspace(0,length(t1),length(t1));