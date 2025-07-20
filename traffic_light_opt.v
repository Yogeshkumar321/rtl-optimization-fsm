module traffic_light_opt (
    input wire clk,
    input wire rst,
    output reg red,
    output reg yellow,
    output reg green
);
    parameter RED_TIME = 50, GREEN_TIME = 50, YELLOW_TIME = 20;
    reg [1:0] state;
    reg [7:0] cnt;

    localparam S_RED = 2'b00, S_GREEN = 2'b01, S_YELLOW = 2'b10;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= S_RED;
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
            case (state)
                S_RED: begin
                    red <= 1; yellow <= 0; green <= 0;
                    if (cnt == RED_TIME) begin
                        state <= S_GREEN;
                        cnt <= 0;
                    end
                end
                S_GREEN: begin
                    red <= 0; yellow <= 0; green <= 1;
                    if (cnt == GREEN_TIME) begin
                        state <= S_YELLOW;
                        cnt <= 0;
                    end
                end
                S_YELLOW: begin
                    red <= 0; yellow <= 1; green <= 0;
                    if (cnt == YELLOW_TIME) begin
                        state <= S_RED;
                        cnt <= 0;
                    end
                end
            endcase
        end
    end
endmodule
