library verilog;
use verilog.vl_types.all;
entity deja_glitch_power is
    port(
        clk_i           : in     vl_logic;
        rst_i           : in     vl_logic;
        stb_i           : in     vl_logic;
        we_i            : in     vl_logic;
        adr_i           : in     vl_logic_vector(3 downto 0);
        dat_i           : in     vl_logic_vector(7 downto 0);
        ack_o           : out    vl_logic;
        dat_o           : out    vl_logic_vector(7 downto 0);
        run_i           : in     vl_logic;
        power_o         : out    vl_logic
    );
end deja_glitch_power;
