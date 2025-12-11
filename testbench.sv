import uvm_pkg::*;
`include "uvm_macros.svh"
`include "assertions.sv"

module tb_top;

    logic clock = 0;
    logic reset;

    always #5 clock = ~clock;

    traffic_intf vif(clock);

    traffic_light_controller dut (
        .clock(clock),
        .reset(reset),
        .RED(vif.RED),
        .GREEN(vif.GREEN),
        .YELLOW(vif.YELLOW)
    );

    traffic_assertions asrt (
        .clock(clock),
        .reset(reset),
        .RED(vif.RED),
        .GREEN(vif.GREEN),
        .YELLOW(vif.YELLOW)
    );

    initial begin
        reset = 1;
        #20 reset = 0;
    end

    // Questa waveform dump
    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_top);
        
    end

    initial begin
        uvm_config_db#(virtual traffic_intf)::set(null, "*", "vif", vif);
        run_test("base_test");
    end

endmodule
