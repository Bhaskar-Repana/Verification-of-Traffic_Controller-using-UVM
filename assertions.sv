module traffic_assertions (
  input logic clock,
  input logic reset,
  input logic RED,
  input logic GREEN,
  input logic YELLOW
);

  // ============================================================
  // 1. Only one light ON at a time (Mutual Exclusion)
  // ============================================================

  property red_exclusive;
    @(posedge clock)
    disable iff (reset)
      RED |-> (!GREEN && !YELLOW);
  endproperty
  a_red_exclusive: assert property(red_exclusive);

  property green_exclusive;
    @(posedge clock)
    disable iff (reset)
      GREEN |-> (!RED && !YELLOW);
  endproperty
  a_green_exclusive: assert property(green_exclusive);

  property yellow_exclusive;
    @(posedge clock)
    disable iff (reset)
      YELLOW |-> (!RED && !GREEN);
  endproperty
  a_yellow_exclusive: assert property(yellow_exclusive);



  // ============================================================
  // 2. Timing Assertions for Traffic Sequence
  // ============================================================

  // RED must stay ON for 10 cycles → then GREEN
  property red_timing;
    @(posedge clock)
    disable iff (reset)
      RED |-> (RED[*10] ##1 GREEN);
  endproperty
  a_red_timing: assert property(red_timing);


  // GREEN must stay ON for 15 cycles → then YELLOW
  property green_timing;
    @(posedge clock)
    disable iff (reset)
      GREEN |-> (GREEN[*15] ##1 YELLOW);
  endproperty
  a_green_timing: assert property(green_timing);


  // YELLOW must stay ON for 5 cycles → then RED
  property yellow_timing;
    @(posedge clock)
    disable iff (reset)
      YELLOW |-> (YELLOW[*5] ##1 RED);
  endproperty
  a_yellow_timing: assert property(yellow_timing);



  // ============================================================
  // 3. State-ordering Assertions (strict sequence check)
  // ============================================================

  // RED must always be followed by GREEN
  property red_to_green;
    @(posedge clock)
    disable iff (reset)
      RED |=> GREEN;
  endproperty
  a_red_to_green: assert property(red_to_green);


  // GREEN must always be followed by YELLOW
  property green_to_yellow;
    @(posedge clock)
    disable iff (reset)
      GREEN |=> YELLOW;
  endproperty
  a_green_to_yellow: assert property(green_to_yellow);


  // YELLOW must always be followed by RED
  property yellow_to_red;
    @(posedge clock)
    disable iff (reset)
      YELLOW |=> RED;
  endproperty
  a_yellow_to_red: assert property(yellow_to_red);

endmodule
