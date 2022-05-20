clc
clear all
close all

% pn = 'C:\SIXRay\20\Image\';
% pn = 'C:\OPIXray-master\DOAM\OPIXray_Dataset\test\test_image\';
% pn = 'C:\icip\GDXray\';
% pn = 'C:\Users\Windows\Downloads\COMPASS-XP\Colour\';
% pn2 = 'C:\OPIXray-master\DOAM\OPIXray_Dataset\test\test_annotation\';
pn2 = 'testingDataset\segmentation_results_proposed_2\';
pn = 'testingDataset\test_images_2\';
ext_img = [pn '*.png'];
a = dir(ext_img);
nfile = length(a);
proposals = {};
obj = [];

bg = [20 215 197];
gun1 = [207 248 132];
gun2 = [183 244 155];
gun3 = [144 71 111];
gun4 = [128 48 71];
gun5 = [50 158 75];
gun6 = [241 169 37];
knife1 = [222 181 51];
knife2 = [244 104 161];
knife3 = [31 133 226];
shuriken1 = [149 154 55];
shuriken2 = [104 170 63];
razor1 = [123 162 197];
razor2 = [46 227 147];
wrench1 = [204 47 7];
wrench2 = [170 252 0];
wrench3 = [];
scissor1 = [122 113 97];
plier1 = [46 229 72];
plier2 = [250 163 41];
stKnife = [96 94 148];
screwdriver = [133 16 95];
powerdrill = [45 35 243];
hammer = [19 76 66];
axe = [141 200 41];

% i = 2158; to resume

for ii=1:nfile
    fn = a(ii).name; 
    img = imread([pn fn]);
    img2 = imread([pn2 fn]);
    
    [r,c,ch] = size(img2);
    im = uint8(zeros(r,c,3));
%     im(:,:,1) = 61;
%     im(:,:,2) = 38;
%     im(:,:,3) = 168;
    im(:,:,1) = 0;
    im(:,:,2) = 0;
    im(:,:,3) = 0;    
    im3 = im;
    
    gun1m = zeros(r,c,3);
    gun2m = zeros(r,c,3);
    gun3m = zeros(r,c,3);
    gun4m = zeros(r,c,3);
    gun5m = zeros(r,c,3);
    gun6m = zeros(r,c,3);
    knife1m = zeros(r,c,3);
    knife2m = zeros(r,c,3);
    knife3m = zeros(r,c,3);
    shuriken1m = zeros(r,c,3);
    shuriken2m = zeros(r,c,3);
    razor1m = zeros(r,c,3);
    razor2m = zeros(r,c,3);
    wrench1m = zeros(r,c,3);
    wrench2m = zeros(r,c,3);
    scissor1m = zeros(r,c,3);
    plier1m = zeros(r,c,3);
    plier2m = zeros(r,c,3);
    stKnife1m = zeros(r,c,3);
	screwdriver1m = zeros(r,c,3);
    powerdrill1m = zeros(r,c,3);
    hammer1m = zeros(r,c,3);
    axe1m = zeros(r,c,3);
    
    for i = 1:r
        for j = 1:c
            if img2(i,j,1) == gun1(1) && img2(i,j,2) == gun1(2) && img2(i,j,3) == gun1(3)
                gun1m(i,j,1) = 255;
                gun1m(i,j,2) = 0;
                gun1m(i,j,3) = 0;
            elseif img2(i,j,1) == gun2(1) && img2(i,j,2) == gun2(2) && img2(i,j,3) == gun2(3)
                gun2m(i,j,1) = 0;
                gun2m(i,j,2) = 255;
                gun2m(i,j,3) = 0;
            elseif img2(i,j,1) == gun3(1) && img2(i,j,2) == gun3(2) && img2(i,j,3) == gun3(3)
                gun3m(i,j,1) = 0;
                gun3m(i,j,2) = 0;
                gun3m(i,j,3) = 255;
            elseif img2(i,j,1) == gun4(1) && img2(i,j,2) == gun4(2) && img2(i,j,3) == gun4(3)
                gun4m(i,j,1) = 255;
                gun4m(i,j,2) = 255;
                gun4m(i,j,3) = 0;
            elseif img2(i,j,1) == gun5(1) && img2(i,j,2) == gun5(2) && img2(i,j,3) == gun5(3)
                gun5m(i,j,1) = 0;
                gun5m(i,j,2) = 255;
                gun5m(i,j,3) = 255;
            elseif img2(i,j,1) == gun6(1) && img2(i,j,2) == gun6(2) && img2(i,j,3) == gun6(3)
                gun6m(i,j,1) = 255;
                gun6m(i,j,2) = 0;
                gun6m(i,j,3) = 255;
            elseif img2(i,j,1) == knife1(1) && img2(i,j,2) == knife1(2) && img2(i,j,3) == knife1(3)
                knife1m(i,j,1) = 128;
                knife1m(i,j,2) = 64;
                knife1m(i,j,3) = 0;
            elseif img2(i,j,1) == knife2(1) && img2(i,j,2) == knife2(2) && img2(i,j,3) == knife2(3)
                knife2m(i,j,1) = 64;
                knife2m(i,j,2) = 128;
                knife2m(i,j,3) = 0;
            elseif img2(i,j,1) == knife3(1) && img2(i,j,2) == knife3(2) && img2(i,j,3) == knife3(3)
                knife3m(i,j,1) = 64;
                knife3m(i,j,2) = 0;
                knife3m(i,j,3) = 128;
            elseif img2(i,j,1) == shuriken1(1) && img2(i,j,2) == shuriken1(2) && img2(i,j,3) == shuriken1(3)
                shuriken1m(i,j,1) = 128;
                shuriken1m(i,j,2) = 128;
                shuriken1m(i,j,3) = 64;
            elseif img2(i,j,1) == shuriken2(1) && img2(i,j,2) == shuriken2(2) && img2(i,j,3) == shuriken2(3)
                shuriken2m(i,j,1) = 64;
                shuriken2m(i,j,2) = 128;
                shuriken1m(i,j,3) = 128;
            elseif img2(i,j,1) == razor1(1) && img2(i,j,2) == razor1(2) && img2(i,j,3) == razor1(3)
                razor1m(i,j,1) = 128;
                razor1m(i,j,2) = 64;
                razor1m(i,j,3) = 128;
            elseif img2(i,j,1) == razor2(1) && img2(i,j,2) == razor2(2) && img2(i,j,3) == razor2(3)
                razor2m(i,j,1) = 64;
                razor2m(i,j,2) = 50;
                razor2m(i,j,3) = 0;
            elseif img2(i,j,1) == wrench1(1) && img2(i,j,2) == wrench1(2) && img2(i,j,3) == wrench1(3)
                wrench1m(i,j,1) = 50;
                wrench1m(i,j,2) = 64;
                wrench1m(i,j,3) = 0;
            elseif img2(i,j,1) == wrench2(1) && img2(i,j,2) == wrench2(2) && img2(i,j,3) == wrench2(3)
                wrench2m(i,j,1) = 0;
                wrench2m(i,j,2) = 50;
                wrench2m(i,j,3) = 64;
            elseif img2(i,j,1) == scissor1(1) && img2(i,j,2) == scissor1(2) && img2(i,j,3) == scissor1(3)
                scissor1m(i,j,1) = 64;
                scissor1m(i,j,2) = 20;
                scissor1m(i,j,3) = 20;
            elseif img2(i,j,1) == plier1(1) && img2(i,j,2) == plier1(2) && img2(i,j,3) == plier1(3)
                plier1m(i,j,1) = 20;
                plier1m(i,j,2) = 64;
                plier1m(i,j,3) = 20;
            elseif img2(i,j,1) == plier2(1) && img2(i,j,2) == plier2(2) && img2(i,j,3) == plier2(3)
                plier2m(i,j,1) = 64;
                plier2m(i,j,2) = 20;
                plier2m(i,j,3) = 64;
            elseif img2(i,j,1) == stKnife(1) && img2(i,j,2) == stKnife(2) && img2(i,j,3) == stKnife(3)
                stKnife1m(i,j,1) = 40;
                stKnife1m(i,j,2) = 30;
                stKnife1m(i,j,3) = 0;
            elseif img2(i,j,1) == screwdriver(1) && img2(i,j,2) == screwdriver(2) && img2(i,j,3) == screwdriver(3)
                screwdriver1m(i,j,1) = 30;
                screwdriver1m(i,j,2) = 40;
                screwdriver1m(i,j,3) = 0;
            elseif img2(i,j,1) == powerdrill(1) && img2(i,j,2) == powerdrill(2) && img2(i,j,3) == powerdrill(3)
                powerdrill1m(i,j,1) = 20;
                powerdrill1m(i,j,2) = 40;
                powerdrill1m(i,j,3) = 100;
            elseif img2(i,j,1) == hammer(1) && img2(i,j,2) == hammer(2) && img2(i,j,3) == hammer(3)
                hammer1m(i,j,1) = 40;
                hammer1m(i,j,2) = 22;
                hammer1m(i,j,3) = 11;
            elseif img2(i,j,1) == axe(1) && img2(i,j,2) == axe(2) && img2(i,j,3) == axe(3)
                axe1m(i,j,1) = axe(1);
                axe1m(i,j,2) = axe(2);
                axe1m(i,j,3) = axe(3);
            end
        end
    end
    
    threshold = 600;
    
    g1 = bwareaopen(imbinarize(rgb2gray(gun1m),0.1),threshold);
    g2 = bwareaopen(imbinarize(rgb2gray(gun2m),0.1),threshold);
    g3 = bwareaopen(imbinarize(rgb2gray(gun3m),0.1),threshold);
    g4 = bwareaopen(imbinarize(rgb2gray(gun4m),0.1),threshold);
    g5 = bwareaopen(imbinarize(rgb2gray(gun5m),0.1),threshold);
    g6 = bwareaopen(imbinarize(rgb2gray(gun6m),0.1),threshold);
    k1 = bwareaopen(imbinarize(rgb2gray(knife1m),0.1),threshold);
    k2 = bwareaopen(imbinarize(rgb2gray(knife2m),0.1),threshold);
    k3 = bwareaopen(imbinarize(rgb2gray(knife3m),0.1),threshold);
    s1 = bwareaopen(imbinarize(rgb2gray(shuriken1m),0.1),threshold);
    s2 = bwareaopen(imbinarize(rgb2gray(shuriken2m),0.1),threshold);
    r1 = bwareaopen(imbinarize(rgb2gray(razor1m),0.1),threshold);
    r2 = bwareaopen(imbinarize(rgb2gray(razor2m),0.1),threshold);
    w1 = bwareaopen(imbinarize(rgb2gray(wrench1m),0.1),threshold);
    w2 = bwareaopen(imbinarize(rgb2gray(wrench2m),0.1),threshold);
    sc1 = bwareaopen(imbinarize(rgb2gray(scissor1m),0.1),threshold);
    p1 = bwareaopen(imbinarize(rgb2gray(plier1m),0.1),threshold);
    p2 = bwareaopen(imbinarize(rgb2gray(plier2m),0.1),threshold);
    st1 = bwareaopen(imbinarize(rgb2gray(stKnife1m),0.1),threshold);
    scr1 = bwareaopen(imbinarize(rgb2gray(screwdriver1m),0.1),threshold);
    po1 = bwareaopen(imbinarize(rgb2gray(powerdrill1m),0.1),threshold);
    h1 = bwareaopen(imbinarize(rgb2gray(hammer1m),0.1),threshold);
    a1 = bwareaopen(imbinarize(rgb2gray(axe1m),0.1),threshold);
    
    gun1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(gun1m),0.1),threshold),'canny'),'skel');
    gun2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(gun2m),0.1),threshold),'canny'),'skel');
    gun3m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(gun3m),0.1),threshold),'canny'),'skel');
    gun4m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(gun4m),0.1),threshold),'canny'),'skel');
    gun5m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(gun5m),0.1),threshold),'canny'),'skel');
    gun6m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(gun6m),0.1),threshold),'canny'),'skel');
    knife1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(knife1m),0.1),threshold),'canny'),'skel');
    knife2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(knife2m),0.1),threshold),'canny'),'skel');
    knife3m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(knife3m),0.1),threshold),'canny'),'skel');
    shuriken1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(shuriken1m),0.1),threshold),'canny'),'skel');
    shuriken2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(shuriken2m),0.1),threshold),'canny'),'skel');
    razor1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(razor1m),0.1),threshold),'canny'),'skel');
    razor2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(razor2m),0.1),threshold),'canny'),'skel');
    wrench1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(wrench1m),0.1),threshold),'canny'),'skel');
    wrench2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(wrench2m),0.1),threshold),'canny'),'skel');
    scissor1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(scissor1m),0.1),threshold),'canny'),'skel');
    plier1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(plier1m),0.1),threshold),'canny'),'skel');
    plier2m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(plier2m),0.1),threshold),'canny'),'skel');
    stKnife1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(stKnife1m),0.1),threshold),'canny'),'skel');
	screwdriver1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(screwdriver1m),0.1),threshold),'canny'),'skel');
    powerdrill1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(powerdrill1m),0.1),threshold),'canny'),'skel');
    hammer1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(hammer1m),0.1),threshold),'canny'),'skel');
    axe1m = bwmorph(edge(bwareaopen(imbinarize(rgb2gray(axe1m),0.1),threshold),'canny'),'skel');
    
    im3(:,:,1) = im3(:,:,1) + gun1(1) * uint8(gun1m);
    im3(:,:,2) = im3(:,:,2) + gun1(2) * uint8(gun1m);
    im3(:,:,3) = im3(:,:,3) + gun1(3) * uint8(gun1m);
    
    im3(:,:,1) = im3(:,:,1) + gun2(1) * uint8(gun2m);
    im3(:,:,2) = im3(:,:,2) + gun2(2) * uint8(gun2m);
    im3(:,:,3) = im3(:,:,3) + gun2(3) * uint8(gun2m);
    
    im3(:,:,1) = im3(:,:,1) + gun3(1) * uint8(gun3m);
    im3(:,:,2) = im3(:,:,2) + gun3(2) * uint8(gun3m);
    im3(:,:,3) = im3(:,:,3) + gun3(3) * uint8(gun3m);
    
    im3(:,:,1) = im3(:,:,1) + gun4(1) * uint8(gun4m);
    im3(:,:,2) = im3(:,:,2) + gun4(2) * uint8(gun4m);
    im3(:,:,3) = im3(:,:,3) + gun4(3) * uint8(gun4m);
    
    im3(:,:,1) = im3(:,:,1) + gun5(1) * uint8(gun5m);
    im3(:,:,2) = im3(:,:,2) + gun5(2) * uint8(gun5m);
    im3(:,:,3) = im3(:,:,3) + gun5(3) * uint8(gun5m);
    
    im3(:,:,1) = im3(:,:,1) + gun6(1) * uint8(gun6m);
    im3(:,:,2) = im3(:,:,2) + gun6(2) * uint8(gun6m);
    im3(:,:,3) = im3(:,:,3) + gun6(3) * uint8(gun6m);
    
    im3(:,:,1) = im3(:,:,1) + knife1(1) * uint8(knife1m);
    im3(:,:,2) = im3(:,:,2) + knife1(2) * uint8(knife1m);
    im3(:,:,3) = im3(:,:,3) + knife1(3) * uint8(knife1m);
    
    im3(:,:,1) = im3(:,:,1) + knife2(1) * uint8(knife2m);
    im3(:,:,2) = im3(:,:,2) + knife2(2) * uint8(knife2m);
    im3(:,:,3) = im3(:,:,3) + knife2(3) * uint8(knife2m);
    
    im3(:,:,1) = im3(:,:,1) + knife3(1) * uint8(knife3m);
    im3(:,:,2) = im3(:,:,2) + knife3(2) * uint8(knife3m);
    im3(:,:,3) = im3(:,:,3) + knife3(3) * uint8(knife3m);
    
    im3(:,:,1) = im3(:,:,1) + shuriken1(1) * uint8(shuriken1m);
    im3(:,:,2) = im3(:,:,2) + shuriken1(2) * uint8(shuriken1m);
    im3(:,:,3) = im3(:,:,3) + shuriken1(3) * uint8(shuriken1m);
    
    im3(:,:,1) = im3(:,:,1) + shuriken2(1) * uint8(shuriken2m);
    im3(:,:,2) = im3(:,:,2) + shuriken2(2) * uint8(shuriken2m);
    im3(:,:,3) = im3(:,:,3) + shuriken2(3) * uint8(shuriken2m);
    
    im3(:,:,1) = im3(:,:,1) + razor1(1) * uint8(razor1m);
    im3(:,:,2) = im3(:,:,2) + razor1(2) * uint8(razor1m);
    im3(:,:,3) = im3(:,:,3) + razor1(3) * uint8(razor1m);
    
    im3(:,:,1) = im3(:,:,1) + razor2(1) * uint8(razor2m);
    im3(:,:,2) = im3(:,:,2) + razor2(2) * uint8(razor2m);
    im3(:,:,3) = im3(:,:,3) + razor2(3) * uint8(razor2m);
    
    im3(:,:,1) = im3(:,:,1) + wrench1(1) * uint8(wrench1m);
    im3(:,:,2) = im3(:,:,2) + wrench1(2) * uint8(wrench1m);
    im3(:,:,3) = im3(:,:,3) + wrench1(3) * uint8(wrench1m);
    
    im3(:,:,1) = im3(:,:,1) + wrench2(1) * uint8(wrench2m);
    im3(:,:,2) = im3(:,:,2) + wrench2(2) * uint8(wrench2m);
    im3(:,:,3) = im3(:,:,3) + wrench2(3) * uint8(wrench2m);
    
    im3(:,:,1) = im3(:,:,1) + scissor1(1) * uint8(scissor1m);
    im3(:,:,2) = im3(:,:,2) + scissor1(2) * uint8(scissor1m);
    im3(:,:,3) = im3(:,:,3) + scissor1(3) * uint8(scissor1m);
    
    im3(:,:,1) = im3(:,:,1) + plier1(1) * uint8(plier1m);
    im3(:,:,2) = im3(:,:,2) + plier1(2) * uint8(plier1m);
    im3(:,:,3) = im3(:,:,3) + plier1(3) * uint8(plier1m);
    
    im3(:,:,1) = im3(:,:,1) + plier2(1) * uint8(plier2m);
    im3(:,:,2) = im3(:,:,2) + plier2(2) * uint8(plier2m);
    im3(:,:,3) = im3(:,:,3) + plier2(3) * uint8(plier2m);
    
    im3(:,:,1) = im3(:,:,1) + stKnife(1) * uint8(stKnife1m);
    im3(:,:,2) = im3(:,:,2) + stKnife(2) * uint8(stKnife1m);
    im3(:,:,3) = im3(:,:,3) + stKnife(3) * uint8(stKnife1m);
    
    im3(:,:,1) = im3(:,:,1) + screwdriver(1) * uint8(screwdriver1m);
    im3(:,:,2) = im3(:,:,2) + screwdriver(2) * uint8(screwdriver1m);
    im3(:,:,3) = im3(:,:,3) + screwdriver(3) * uint8(screwdriver1m);
    
    im3(:,:,1) = im3(:,:,1) + powerdrill(1) * uint8(powerdrill1m);
    im3(:,:,2) = im3(:,:,2) + powerdrill(2) * uint8(powerdrill1m);
    im3(:,:,3) = im3(:,:,3) + powerdrill(3) * uint8(powerdrill1m);
    
    im3(:,:,1) = im3(:,:,1) + hammer(1) * uint8(hammer1m);
    im3(:,:,2) = im3(:,:,2) + hammer(2) * uint8(hammer1m);
    im3(:,:,3) = im3(:,:,3) + hammer(3) * uint8(hammer1m);
    
    im3(:,:,1) = im3(:,:,1) + axe(1) * uint8(axe1m);
    im3(:,:,2) = im3(:,:,2) + axe(2) * uint8(axe1m);
    im3(:,:,3) = im3(:,:,3) + axe(3) * uint8(axe1m);
    
    im(:,:,1) = im(:,:,1) + gun1(1) * uint8(g1);
    im(:,:,2) = im(:,:,2) + gun1(2) * uint8(g1);
    im(:,:,3) = im(:,:,3) + gun1(3) * uint8(g1);
    
    im(:,:,1) = im(:,:,1) + gun2(1) * uint8(g2);
    im(:,:,2) = im(:,:,2) + gun2(2) * uint8(g2);
    im(:,:,3) = im(:,:,3) + gun2(3) * uint8(g2);
    
    im(:,:,1) = im(:,:,1) + gun3(1) * uint8(g3);
    im(:,:,2) = im(:,:,2) + gun3(2) * uint8(g3);
    im(:,:,3) = im(:,:,3) + gun3(3) * uint8(g3);
    
    im(:,:,1) = im(:,:,1) + gun4(1) * uint8(g4);
    im(:,:,2) = im(:,:,2) + gun4(2) * uint8(g4);
    im(:,:,3) = im(:,:,3) + gun4(3) * uint8(g4);
    
    im(:,:,1) = im(:,:,1) + gun5(1) * uint8(g5);
    im(:,:,2) = im(:,:,2) + gun5(2) * uint8(g5);
    im(:,:,3) = im(:,:,3) + gun5(3) * uint8(g5);
    
    im(:,:,1) = im(:,:,1) + gun6(1) * uint8(g6);
    im(:,:,2) = im(:,:,2) + gun6(2) * uint8(g6);
    im(:,:,3) = im(:,:,3) + gun6(3) * uint8(g6);
    
    im(:,:,1) = im(:,:,1) + knife1(1) * uint8(k1);
    im(:,:,2) = im(:,:,2) + knife1(2) * uint8(k1);
    im(:,:,3) = im(:,:,3) + knife1(3) * uint8(k1);
    
    im(:,:,1) = im(:,:,1) + knife2(1) * uint8(k2);
    im(:,:,2) = im(:,:,2) + knife2(2) * uint8(k2);
    im(:,:,3) = im(:,:,3) + knife2(3) * uint8(k2);
    
    im(:,:,1) = im(:,:,1) + knife3(1) * uint8(k3);
    im(:,:,2) = im(:,:,2) + knife3(2) * uint8(k3);
    im(:,:,3) = im(:,:,3) + knife3(3) * uint8(k3);
    
    im(:,:,1) = im(:,:,1) + shuriken1(1) * uint8(s1);
    im(:,:,2) = im(:,:,2) + shuriken1(2) * uint8(s1);
    im(:,:,3) = im(:,:,3) + shuriken1(3) * uint8(s1);
    
    im(:,:,1) = im(:,:,1) + shuriken2(1) * uint8(s2);
    im(:,:,2) = im(:,:,2) + shuriken2(2) * uint8(s2);
    im(:,:,3) = im(:,:,3) + shuriken2(3) * uint8(s2);
    
    im(:,:,1) = im(:,:,1) + razor1(1) * uint8(r1);
    im(:,:,2) = im(:,:,2) + razor1(2) * uint8(r1);
    im(:,:,3) = im(:,:,3) + razor1(3) * uint8(r1);
    
    im(:,:,1) = im(:,:,1) + razor2(1) * uint8(r2);
    im(:,:,2) = im(:,:,2) + razor2(2) * uint8(r2);
    im(:,:,3) = im(:,:,3) + razor2(3) * uint8(r2);
    
    im(:,:,1) = im(:,:,1) + wrench1(1) * uint8(w1);
    im(:,:,2) = im(:,:,2) + wrench1(2) * uint8(w1);
    im(:,:,3) = im(:,:,3) + wrench1(3) * uint8(w1);
    
    im(:,:,1) = im(:,:,1) + wrench2(1) * uint8(w2);
    im(:,:,2) = im(:,:,2) + wrench2(2) * uint8(w2);
    im(:,:,3) = im(:,:,3) + wrench2(3) * uint8(w2);
    
    im(:,:,1) = im(:,:,1) + scissor1(1) * uint8(sc1);
    im(:,:,2) = im(:,:,2) + scissor1(2) * uint8(sc1);
    im(:,:,3) = im(:,:,3) + scissor1(3) * uint8(sc1);
    
    im(:,:,1) = im(:,:,1) + plier1(1) * uint8(p1);
    im(:,:,2) = im(:,:,2) + plier1(2) * uint8(p1);
    im(:,:,3) = im(:,:,3) + plier1(3) * uint8(p1);
    
    im(:,:,1) = im(:,:,1) + plier2(1) * uint8(p2);
    im(:,:,2) = im(:,:,2) + plier2(2) * uint8(p2);
    im(:,:,3) = im(:,:,3) + plier2(3) * uint8(p2);
    
    im(:,:,1) = im(:,:,1) + stKnife(1) * uint8(st1);
    im(:,:,2) = im(:,:,2) + stKnife(2) * uint8(st1);
    im(:,:,3) = im(:,:,3) + stKnife(3) * uint8(st1);
    
    im(:,:,1) = im(:,:,1) + screwdriver(1) * uint8(scr1);
    im(:,:,2) = im(:,:,2) + screwdriver(2) * uint8(scr1);
    im(:,:,3) = im(:,:,3) + screwdriver(3) * uint8(scr1);
    
    im(:,:,1) = im(:,:,1) + powerdrill(1) * uint8(po1);
    im(:,:,2) = im(:,:,2) + powerdrill(2) * uint8(po1);
    im(:,:,3) = im(:,:,3) + powerdrill(3) * uint8(po1);
    
    im(:,:,1) = im(:,:,1) + hammer(1) * uint8(h1);
    im(:,:,2) = im(:,:,2) + hammer(2) * uint8(h1);
    im(:,:,3) = im(:,:,3) + hammer(3) * uint8(h1);
    
    im(:,:,1) = im(:,:,1) + axe(1) * uint8(a1);
    im(:,:,2) = im(:,:,2) + axe(2) * uint8(a1);
    im(:,:,3) = im(:,:,3) + axe(3) * uint8(a1);
    
    fn2 = replace(fn,'png','jpg');
    
    im2 = img;
%     if exist(['original\' fn])
%         im2 = imread(['original\' fn]);
%     else
%         im2 = imread(['original\' fn2]);
%     end
    
    im2 = imresize(im2, [r,c], 'bilinear');
    
    if max(max(gun1m)) ~= 0
%         ab = regionprops(g1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Gun ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(gun1m,8);
        for j = 1:max(max(L))
            [r,c] = find(gun1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Gun '],'LineWidth',2,'Color',gun1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end
    end
    
    if max(max(gun2m)) ~= 0
%         ab = regionprops(g2, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Gun ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(gun2m,8);
        for j = 1:max(max(L))
            [r,c] = find(gun2m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Gun '],'LineWidth',2,'Color',gun2/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(gun3m)) ~= 0
%         ab = regionprops(g3, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Gun ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(gun3m,8);
        for j = 1:max(max(L))
            [r,c] = find(gun3m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Gun '],'LineWidth',2,'Color',gun3/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(gun4m)) ~= 0
%         ab = regionprops(g4, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Gun ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(gun4m,8);
        for j = 1:max(max(L))
            [r,c] = find(gun4m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Gun '],'LineWidth',2,'Color',gun4/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(gun5m)) ~= 0
%         ab = regionprops(g5, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Gun ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(gun5m,8);
        for j = 1:max(max(L))
            [r,c] = find(gun5m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Gun '],'LineWidth',2,'Color',gun5/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(gun6m)) ~= 0
%         ab = regionprops(g6, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Gun ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(gun6m,8);
        for j = 1:max(max(L))
            [r,c] = find(gun6m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Gun '],'LineWidth',2,'Color',gun6/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(knife1m)) ~= 0
%         ab = regionprops(k1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Knife ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(knife1m,8);
        for j = 1:max(max(L))
            [r,c] = find(knife1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Straight Knife '],'LineWidth',2,'Color',knife1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(knife2m)) ~= 0
%         ab = regionprops(k2, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Knife ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end


        L = bwlabel(knife2m,8);
        for j = 1:max(max(L))
            [r,c] = find(knife2m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Straight Knife '],'LineWidth',2,'Color',knife2/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(knife3m)) ~= 0
%         ab = regionprops(k3, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Knife ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end


        L = bwlabel(knife3m,8);
        for j = 1:max(max(L))
            [r,c] = find(knife3m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Straight Knife '],'LineWidth',2,'Color',knife3/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(shuriken1m)) ~= 0
%         ab = regionprops(s1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Shuriken ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end


        L = bwlabel(shuriken1m,8);
        for j = 1:max(max(L))
            [r,c] = find(shuriken1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Shuriken '],'LineWidth',2,'Color',shuriken1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(shuriken2m)) ~= 0
%         ab = regionprops(s2, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Shuriken ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(shuriken2m,8);
        for j = 1:max(max(L))
            [r,c] = find(shuriken2m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Shuriken '],'LineWidth',2,'Color',shuriken2/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(razor1m)) ~= 0
%         ab = regionprops(r1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Razor ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(razor1m,8);
        for j = 1:max(max(L))
            [r,c] = find(razor1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Razor '],'LineWidth',2,'Color',razor1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(razor2m)) ~= 0
%         ab = regionprops(r2, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Razor ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(razor2m,8);
        for j = 1:max(max(L))
            [r,c] = find(razor2m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Razor '],'LineWidth',2,'Color',razor2/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(wrench1m)) ~= 0
%         ab = regionprops(w1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Wrench ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(wrench1m,8);
        for j = 1:max(max(L))
            [r,c] = find(wrench1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Wrench '],'LineWidth',2,'Color',wrench1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(wrench2m)) ~= 0
%         ab = regionprops(w2, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Wrench ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(wrench2m,8);
        for j = 1:max(max(L))
            [r,c] = find(wrench2m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Wrench '],'LineWidth',2,'Color',wrench2/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(scissor1m)) ~= 0
%         ab = regionprops(sc1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Scissor ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(scissor1m,8);
        for j = 1:max(max(L))
            [r,c] = find(scissor1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Scissor '],'LineWidth',2,'Color',scissor1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(plier1m)) ~= 0
%         ab = regionprops(p1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Pliers ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(plier1m,8);
        for j = 1:max(max(L))
            [r,c] = find(plier1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Pliers '],'LineWidth',2,'Color',plier1/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(plier2m)) ~= 0
%         ab = regionprops(p2, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Pliers ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(plier2m,8);
        for j = 1:max(max(L))
            [r,c] = find(plier2m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Pliers '],'LineWidth',2,'Color',plier2/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(stKnife1m)) ~= 0
%         ab = regionprops(st1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Straight Knife ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(stKnife1m,8);
        for j = 1:max(max(L))
            [r,c] = find(stKnife1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Folding Knife '],'LineWidth',2,'Color',stKnife/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(screwdriver1m)) ~= 0
%         ab = regionprops(scr1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Screw Driver ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(screwdriver1m,8);
        for j = 1:max(max(L))
            [r,c] = find(screwdriver1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Screw Driver '],'LineWidth',2,'Color',screwdriver/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(powerdrill1m)) ~= 0
%         ab = regionprops(po1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Power Drill ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(powerdrill1m,8);
        for j = 1:max(max(L))
            [r,c] = find(powerdrill1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Power Drill '],'LineWidth',2,'Color',powerdrill/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(hammer1m)) ~= 0
%         ab = regionprops(h1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Hammer ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(hammer1m,8);
        for j = 1:max(max(L))
            [r,c] = find(hammer1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Hammer '],'LineWidth',2,'Color',hammer/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    if max(max(axe1m)) ~= 0
%         ab = regionprops(a1, 'BoundingBox');
%         ab = {ab.BoundingBox};
%         for k = 1:length(ab)
%             im2 = insertObjectAnnotation(im2,'rectangle',ab{k},['Axe ', num2str(round((0.9-0.7)*rand()+0.7,5))],'FontSize',28,'LineWidth',4);
%         end

        L = bwlabel(axe1m,8);
        for j = 1:max(max(L))
            [r,c] = find(axe1m == j);
            minX = min(c);
            minY = min(r);
            maxX = max(c);
            maxY = max(r);

            im2 = insertObjectAnnotation(im2,'rectangle',[minX,minY,maxX-minX,maxY-minY],['Axe '],'LineWidth',2,'Color',axe/1,'TextBoxOpacity',0.6,'FontSize',18);
        end

    end
    
    h=imshow(im2);
    hold on
    
    th = 0.5;
    if max(max(gun1m)) ~= 0
        
%         [r,c] = find(edge(g1,'canny') == 1);
% %         [r,c] = find(g1 == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[gun1(1)/255, gun1(2)/255, gun1(3)/255],'MarkerEdgeColor',[gun1(1)/255, gun1(2)/255, gun1(3)/255]);
%         plot(c,r,'.');
        
        [r,c] = find(edge(g1,'canny') == 1);
        b = labeloverlay(im2,g1, 'Colormap',gun1/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',gun1/255,'MarkerEdgeColor',gun1/255);
    end
    
    if max(max(gun2m)) ~= 0
% %         [r,c] = find(g2 == 1);
%         [r,c] = find(edge(g2,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[gun2(1)/255, gun2(2)/255, gun2(3)/255],'MarkerEdgeColor',[gun2(1)/255, gun2(2)/255, gun2(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(g2,'canny') == 1);
        b = labeloverlay(im2,g2, 'Colormap',gun2/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',gun2/255,'MarkerEdgeColor',gun2/255);
    end
    
    if max(max(gun3m)) ~= 0
% %         [r,c] = find(g3 == 1);
%         [r,c] = find(edge(g3,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[gun3(1)/255, gun3(2)/255, gun3(3)/255],'MarkerEdgeColor',[gun3(1)/255, gun3(2)/255, gun3(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(g3,'canny') == 1);
        b = labeloverlay(im2,g3, 'Colormap',gun3/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',gun3/255,'MarkerEdgeColor',gun3/255);
    end
    
    if max(max(gun4m)) ~= 0
% %         [r,c] = find(g4 == 1);
%         [r,c] = find(edge(g4,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[gun4(1)/255, gun4(2)/255, gun4(3)/255],'MarkerEdgeColor',[gun4(1)/255, gun4(2)/255, gun4(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(g4,'canny') == 1);
        b = labeloverlay(im2,g4, 'Colormap',gun4/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',gun4/255,'MarkerEdgeColor',gun4/255);
    end
    
    if max(max(gun5m)) ~= 0
% %         [r,c] = find(g5 == 1);
%         [r,c] = find(edge(g5,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[gun5(1)/255, gun5(2)/255, gun5(3)/255],'MarkerEdgeColor',[gun5(1)/255, gun5(2)/255, gun5(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(g5,'canny') == 1);
        b = labeloverlay(im2,g5, 'Colormap',gun5/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',gun5/255,'MarkerEdgeColor',gun5/255);
    end
    
    if max(max(gun6m)) ~= 0
% %         [r,c] = find(g6 == 1);
%         [r,c] = find(edge(g6,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[gun6(1)/255, gun6(2)/255, gun6(3)/255],'MarkerEdgeColor',[gun6(1)/255, gun6(2)/255, gun6(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(g6,'canny') == 1);
        b = labeloverlay(im2,g6, 'Colormap',gun6/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',gun6/255,'MarkerEdgeColor',gun6/255);
    end
    
    if max(max(knife1m)) ~= 0
% %         [r,c] = find(k1 == 1);
%         [r,c] = find(edge(k1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[stKnife(1)/255, stKnife(2)/255, stKnife(3)/255],'MarkerEdgeColor',[stKnife(1)/255, stKnife(2)/255, stKnife(3)/255]);
%         plot(c,r,'r.');
        [r,c] = find(edge(k1,'canny') == 1);
        b = labeloverlay(im2,k1, 'Colormap',stKnife/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',stKnife/255,'MarkerEdgeColor',stKnife/255);
    end
    
    if max(max(knife2m)) ~= 0
% %         [r,c] = find(k2 == 1);
%         [r,c] = find(edge(k2,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[knife2(1)/255, knife2(2)/255, knife2(3)/255],'MarkerEdgeColor',[knife2(1)/255, knife2(2)/255, knife2(3)/255]);
%         plot(c,r,'r.');
        [r,c] = find(edge(k2,'canny') == 1);
        b = labeloverlay(im2,k2, 'Colormap',knife2/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',knife2/255,'MarkerEdgeColor',knife2/255);
    end
    
    if max(max(knife3m)) ~= 0
% %         [r,c] = find(k3 == 1);
%         [r,c] = find(edge(k3,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[knife3(1)/255, knife3(2)/255, knife3(3)/255],'MarkerEdgeColor',[knife3(1)/255, knife3(2)/255, knife3(3)/255]);
%         plot(c,r,'r.');
        [r,c] = find(edge(k3,'canny') == 1);
        b = labeloverlay(im2,k3, 'Colormap',knife3/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',knife3/255,'MarkerEdgeColor',knife3/255);
    end
    
    if max(max(shuriken1m)) ~= 0
% %         [r,c] = find(s1 == 1);
%         [r,c] = find(edge(s1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[shuriken1(1)/255, shuriken1(2)/255, shuriken1(3)/255],'MarkerEdgeColor',[shuriken1(1)/255, shuriken1(2)/255, shuriken1(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(s1,'canny') == 1);
        b = labeloverlay(im2,s1, 'Colormap',shuriken1/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',shuriken1/255,'MarkerEdgeColor',shuriken1/255);
    end
    
    if max(max(shuriken2m)) ~= 0
% %         [r,c] = find(s2 == 1);
%         [r,c] = find(edge(s2,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[shuriken2(1)/255, shuriken2(2)/255, shuriken2(3)/255],'MarkerEdgeColor',[shuriken2(1)/255, shuriken2(2)/255, shuriken2(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(s2,'canny') == 1);
        b = labeloverlay(im2,s2, 'Colormap',shuriken2/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',shuriken2/255,'MarkerEdgeColor',shuriken2/255);
    end
    
    if max(max(razor1m)) ~= 0
% %         [r,c] = find(r1 == 1);
%         [r,c] = find(edge(r1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[razor1(1)/255, razor1(2)/255, razor1(3)/255],'MarkerEdgeColor',[razor1(1)/255, razor1(2)/255, razor1(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(r1,'canny') == 1);
        b = labeloverlay(im2,r1, 'Colormap',razor1/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',razor1/255,'MarkerEdgeColor',razor1/255);
    end
    
    if max(max(razor2m)) ~= 0
%         [r,c] = find(r2 == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[razor2(1)/255, razor2(2)/255, razor2(3)/255],'MarkerEdgeColor',[razor2(1)/255, razor2(2)/255, razor2(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(r2,'canny') == 1);
        b = labeloverlay(im2,r2, 'Colormap',razor2/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',razor2/255,'MarkerEdgeColor',razor2/255);
    end
    
    if max(max(wrench1m)) ~= 0
% %         [r,c] = find(w1 == 1);
%         [r,c] = find(edge(w1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[wrench1(1)/255, wrench1(2)/255, wrench1(3)/255],'MarkerEdgeColor',[wrench1(1)/255, wrench1(2)/255, wrench1(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(w1,'canny') == 1);
        b = labeloverlay(im2,w1, 'Colormap',wrench1/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',wrench1/255,'MarkerEdgeColor',wrench1/255);
    end
    
    if max(max(wrench2m)) ~= 0
% %         [r,c] = find(w2 == 1);
%         [r,c] = find(edge(w2,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[wrench2(1)/255, wrench2(2)/255, wrench2(3)/255],'MarkerEdgeColor',[wrench2(1)/255, wrench2(2)/255, wrench2(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(w2,'canny') == 1);
        b = labeloverlay(im2,w2, 'Colormap',wrench2/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',wrench2/255,'MarkerEdgeColor',wrench2/255);
    end
    
    if max(max(scissor1m)) ~= 0
% %         [r,c] = find(sc1 == 1);
%         [r,c] = find(edge(sc1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[scissor1(1)/255, scissor1(2)/255, scissor1(3)/255],'MarkerEdgeColor',[scissor1(1)/255, scissor1(2)/255, scissor1(3)/255]);
%         plot(c,r,'m.');
        [r,c] = find(edge(sc1,'canny') == 1);
        b = labeloverlay(im2,sc1, 'Colormap',scissor1/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',scissor1/255,'MarkerEdgeColor',scissor1/255);
    end
    
    if max(max(plier1m)) ~= 0
% %         [r,c] = find(p1 == 1);
%         [r,c] = find(edge(p1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[plier1(1)/255, plier1(2)/255, plier1(3)/255],'MarkerEdgeColor',[plier1(1)/255, plier1(2)/255, plier1(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(p1,'canny') == 1);
        b = labeloverlay(im2,p1, 'Colormap',plier1/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',plier1/255,'MarkerEdgeColor',plier1/255);
    end
    
    if max(max(plier2m)) ~= 0
% %         [r,c] = find(p2 == 1);
%         [r,c] = find(edge(p2,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[plier2(1)/255, plier2(2)/255, plier2(3)/255],'MarkerEdgeColor',[plier2(1)/255, plier2(2)/255, plier2(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(p2,'canny') == 1);
        b = labeloverlay(im2,p2, 'Colormap',plier2/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',plier2/255,'MarkerEdgeColor',plier2/255);
    end
    
    if max(max(stKnife1m)) ~= 0
% %         [r,c] = find(st1 == 1);
%         [r,c] = find(edge(st1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[stKnife(1)/255, stKnife(2)/255, stKnife(3)/255],'MarkerEdgeColor',[stKnife(1)/255, stKnife(2)/255, stKnife(3)/255]);
%         plot(c,r,'r.');
        [r,c] = find(edge(st1,'canny') == 1);
        b = labeloverlay(im2,st1, 'Colormap',stKnife/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',stKnife/255,'MarkerEdgeColor',stKnife/255);
    end
    
    if max(max(screwdriver1m)) ~= 0
% %         [r,c] = find(scr1 == 1);
%         [r,c] = find(edge(scr1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[screwdriver(1)/255, screwdriver(2)/255, screwdriver(3)/255],'MarkerEdgeColor',[screwdriver(1)/255, screwdriver(2)/255, screwdriver(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(scr1,'canny') == 1);
        b = labeloverlay(im2,scr1, 'Colormap',screwdriver/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',screwdriver/255,'MarkerEdgeColor',screwdriver/255);
    end
    
    if max(max(powerdrill1m)) ~= 0
% %         [r,c] = find(po1 == 1);
%         [r,c] = find(edge(po1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[powerdrill(1)/255, powerdrill(2)/255, powerdrill(3)/255],'MarkerEdgeColor',[powerdrill(1)/255, powerdrill(2)/255, powerdrill(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(po1,'canny') == 1);
        b = labeloverlay(im2,po1, 'Colormap',powerdrill/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',powerdrill/255,'MarkerEdgeColor',powerdrill/255);
    end
    
    if max(max(hammer1m)) ~= 0
% %         [r,c] = find(h1 == 1);
%         [r,c] = find(edge(h1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[hammer(1)/255, hammer(2)/255, hammer(3)/255],'MarkerEdgeColor',[hammer(1)/255, hammer(2)/255, hammer(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(h1,'canny') == 1);
        b = labeloverlay(im2,h1, 'Colormap',hammer/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',hammer/255,'MarkerEdgeColor',hammer/255);
    end
    
    if max(max(axe1m)) ~= 0
% %         [r,c] = find(a1 == 1);
%         [r,c] = find(edge(a1,'canny') == 1);
% %         scatter1 = scatter(c,r,'.','MarkerEdgeAlpha',th,'MarkerFaceAlpha',th,'MarkerFaceColor',[axe(1)/255, axe(2)/255, axe(3)/255],'MarkerEdgeColor',[axe(1)/255, axe(2)/255, axe(3)/255]);
%         plot(c,r,'.');
        [r,c] = find(edge(a1,'canny') == 1);
        b = labeloverlay(im2,a1, 'Colormap',axe/255, 'Transparency',th);
        imshow(b),
        hold on
        plot(c,r,'.','MarkerFaceColor',axe/255,'MarkerEdgeColor',axe/255);
    end
    
%     mask = logical(mask);
    
%     st = uint8(mask) .* img;
    
    axis off tight
    hold off

    saveas(gcf,['results_tmm\' fn],'png');
%     imwrite(im2,['results_opixray\' fn],'PNG');
%     imwrite(im2,[pn2 'results2\' fn],'PNG');
%     imwrite(im3,[pn2 'results3\' fn],'PNG');
%     im2(im~=0) = im(im~=0);
% 	imwrite(im2,[pn2 'results4\' fn],'PNG');
end

function [cTensor,cTensor2] = getCoherentOne(tensors)
cTensor = [];
cTensor2 = [];
[r,c] = size(tensors);
m = -100000000000000000;
index1 = -1;
index2 = -1;
for i = 1:r
    for j = 1:c
        if isempty(tensors{i,j}) 
            continue;
        end
        
        t = tensors{i,j};
        [u s v] = svd(t);
        if m < max(max(s))
            cTensor2 = cTensor;
            cTensor = t;
            m = max(max(s));
        end
    end
end

% figure,imagesc(cTensor)
end


function [Sxx, Sxy, Syy] = stOld(I,si,so)
I = double(I);
[m n] = size(I);
 
Sxx = NaN(m,n);
Sxy = NaN(m,n);
Syy = NaN(m,n);
 
x  = -2*si:2*si;
g  = exp(-0.5*(x/si).^2);
g  = g/sum(g);
gd = -x.*g/(si^2); 
 
Ix = conv2( conv2(I,gd,'same'),g','same' );
Iy = conv2( conv2(I,gd','same'),g,'same' );
 
Ixx = Ix.^2;
Ixy = Ix.*Iy;
Iyy = Iy.^2;
 
x  = -2*so:2*so;
g  = exp(-0.5*(x/so).^2);
Sxx = conv2( conv2(Ixx,g,'same'),g','same' ); 
Sxy = conv2( conv2(Ixy,g,'same'),g','same' );
Syy = conv2( conv2(Iyy,g,'same'),g','same' );

end
%%
function [tensors] = structureTensor(I,N)
I = double(I);
[m n] = size(I);
si = 1;
so = 1;
tensors = {};
Sxx = NaN(m,n);
Sxy = NaN(m,n);
Syy = NaN(m,n);
 
x  = -2*si:2*si;
g  = exp(-0.5*(x/si).^2);
g  = g/sum(g);
gd = -x.*g/(si^2); 

a = zeros(5,5);
a(3,:) = gd;
b = zeros(5,5);
b(:,3) = g;
an = a;
index = 1;

gradients = {};

index = 1;
for i = 0:N-1
    angle = (2*180*i)/N;
    a = imrotate(an,angle,'bilinear','crop');
    Ig = conv2( conv2(I,a,'same'),b','same' );
    gradients{index} = Ig;
    index = index + 1;
end

nGradients = length(gradients);

for i = 1:nGradients
    I1 = gradients{i};
    for j = 1:nGradients
        I2 = gradients{j};
        Ixy = I1.*I2;
        Sxy = imdiffusefilt(Ixy);
        x  = -2*so:2*so;
        g  = exp(-0.5*(x/so).^2);
%         Sxy = conv2( conv2(Ixy,g,'same'),g','same' );
        tensors{i,j} = Sxy;
%         imagesc(Sxy)
    end
end
end