module tb_traffic_light;
    reg clk, rst;
    wire red, yellow, green;

    
    traffic_light_opt uut (
        .clk(clk), .rst(rst),
        .red(red), .yellow(yellow), .green(green)
    );

    initial begin
        clk = 0; forever #5 clk = ~clk; // 100 MHz clock
    end

    initial begin
        rst = 1; #20;
        rst = 0;
        #1000 $stop;
    end

    initial begin
        $monitor("Time=%0t, R=%b, Y=%b, G=%b", $time, red, yellow, green);
    end
endmodule
