module traffic_light_controller (
  input  logic clock,
  input  logic reset,
  output logic RED,
  output logic GREEN,
  output logic YELLOW
);

  // Define states
  typedef enum logic [1:0] { 
    red_state, 
    green_state, 
    yellow_state 
  } state_t;

  state_t present_state, next_state;

  integer counter;

  // State & counter update
  always_ff @(posedge clock or posedge reset) begin
    if (reset) begin
      present_state <= red_state;
      counter <= 0;
    end 
    else begin
      present_state <= next_state;

      // If state changed → reset counter
      if (present_state != next_state)
        counter <= 0;
      else
        counter <= counter + 1;
    end
  end


  // Next state logic
  always_comb begin
    next_state = present_state;   // default

    case(present_state)
      red_state:
        if(counter == 10)
          next_state = green_state;

      green_state:
        if(counter == 15)
          next_state = yellow_state;

      yellow_state:
        if(counter == 5)
          next_state = red_state;

      default:
        next_state = red_state;
    endcase
  end


  // Output logic
  always_comb begin
    case(present_state)
      red_state: begin
        RED = 1; GREEN = 0; YELLOW = 0;
      end

      green_state: begin
        RED = 0; GREEN = 1; YELLOW = 0;
      end

      yellow_state: begin
        RED = 0; GREEN = 0; YELLOW = 1;
      end
    endcase
  end

endmodule
