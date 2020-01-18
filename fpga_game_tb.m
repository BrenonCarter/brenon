button1 = [1,0,1,0,1,0,1,0,1,0,1,0,1,0];
button2 = [0,1,0,1,0,1,0,1,0,1,0,1,0,1];

A=zeros(size(button1));
B=zeroes(size(button2));

for i=1:length(button1)
    A(i) = fpga_game(button1(i));
    B(i) = fpga_game(button2(i));
end

subplot(2,2,1);
bar(button1,'r');
ylabel('Input: button1');
subplot(2,2,2);
bar(A, 'b');
ylabel('Output: A');

subplot(2,2,3);
bar(button1,'r');
ylabel('Input: button2');
subplot(2,2,4);
bar(B, 'b');
ylabel('Output: B');