module traffic_light_orig (
    input wire clk,
    input wire rst,
    output reg red,
    output reg yellow,
    output reg green
);
    reg [2:0] state; // One-hot encoding (wasteful)
    reg [7:0] red_cnt, green_cnt, yellow_cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 3'b100; // RED
            red_cnt <= 0;
            green_cnt <= 0;
            yellow_cnt <= 0;
        end else begin
            case (state)
                3'b100: begin
                    red <= 1; yellow <= 0; green <= 0;
                    red_cnt <= red_cnt + 1;
                    if (red_cnt == 8'd50) begin
                        state <= 3'b010; // GREEN
                        red_cnt <= 0;
                    end
                end
                3'b010: begin
                    red <= 0; yellow <= 0; green <= 1;
                    green_cnt <= green_cnt + 1;
                    if (green_cnt == 8'd50) begin
                        state <= 3'b001; // YELLOW
                        green_cnt <= 0;
                    end
                end
                3'b001: begin
                    red <= 0; yellow <= 1; green <= 0;
                    yellow_cnt <= yellow_cnt + 1;
                    if (yellow_cnt == 8'd20) begin
                        state <= 3'b100; // RED
                        yellow_cnt <= 0;
                    end
                end
            endcase
        end
    end
endmodule
