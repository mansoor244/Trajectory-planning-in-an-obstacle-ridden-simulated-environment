ur10 = loadrobot("universalUR10","DataFormat","row");
ur10.Gravity=[0,0,-9.81];
[actual,~]=trapveltraj(interpPath',100);
[sim,~]=trapveltraj(q_actual',100);
actual=actual';
sim=sim';

env = {collisionBox(1,1,0.05),collisionBox(0.2,0.2,1),collisionCylinder(0.2,1)};
env{1}.Pose(3, end) = -0.05;
env{2}.Pose(1, end) = -0.5;
env{2}.Pose(2, end) = -0.5;
env{2}.Pose(3, end) = 0.5;

env{3}.Pose(1, end) = 0.3;
env{3}.Pose(2, end) = -0.3;
env{3}.Pose(3, end) = 0.5;

myVideo = VideoWriter('my','MPEG-4'); %open video file
myVideo.FrameRate = 5;  %can adjust this, 5 - 10 works well for me
open(myVideo)

myVideo2 = VideoWriter('my2','MPEG-4'); %open video file
myVideo2.FrameRate = 5;  %can adjust this, 5 - 10 works well for me
open(myVideo2)

for i=1:length(actual)
    show(ur10,actual(i,:));
    view([1,1,1])
    zlim([-0.2 3])
    hold on
    show(env{1});
    hold on
    show(env{2});
    hold on
    show(env{3});
    hold off
    pause(0.01);
    frame = getframe(gcf);
    writeVideo(myVideo, frame);
end
close(myVideo)
pause(0.5)
figure;
for i=1:length(sim)
    show(ur10,sim(i,:));
    view([1,1,1])
    zlim([-0.2 3])
    hold on
    show(env{1});
    hold on
    show(env{2});
    hold on
    show(env{3});
    hold off
    pause(0.01);
    frame = getframe(gcf);
    writeVideo(myVideo2, frame);
end
close(myVideo2)