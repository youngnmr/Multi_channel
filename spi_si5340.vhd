library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_ip_new is
  Port (
  clk : in std_logic;
  rst : in std_logic;
  spi_cs : out std_logic;
  spi_clk : out std_logic;
  rst_micro : out std_logic;
  spi_sdo : out std_logic
   );
end spi_ip_new;

architecture Behavioral of spi_ip_new is

type reg_add_high is array (326 downto 0) of std_logic_vector(15 downto 0);
constant addr_high : reg_add_high := (
x"040B", x"040B", x"0405", x"0405", x"0409", x"040B", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0401", x"0401", x"0401", x"0401",
x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0401", x"0402", x"0402", x"0402", x"0402", x"0402",
x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402",
x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402",
x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402", x"0402",
x"0402", x"0402", x"0402", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403",
x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403",
x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403",
x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0403", x"0408", x"0408", x"0408",
x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408",
x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408",
x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408",
x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408",
x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0408", x"0409", x"0409", x"0409", x"0409", x"0409", x"0409", x"0409", x"0409", x"040A", x"040A", x"040A", x"040A",
x"040A", x"040A", x"040A", x"040A", x"040B", x"040B", x"040B", x"040B", x"0400", x"040B", x"040B", x"0000"
);

type reg_add_low is array (326 downto 0) of std_logic_vector(15 downto 0);
constant addr_low : reg_add_low := (
x"0024", x"0025", x"0002", x"0005", x"0057", x"004E", x"0006", x"0007", x"0008", x"000B", x"0017", x"0018", x"0021", x"0022", x"002B", x"002C", x"002D", x"002E", x"002F", x"0030", x"0031",
x"0032", x"0033", x"0034", x"0035", x"0036", x"0037", x"0038", x"0039", x"003A", x"003B", x"003C", x"003D", x"0041", x"0042", x"0043", x"0044", x"009E", x"0002", x"0012", x"0013", x"0014",
x"0015", x"0017", x"0018", x"0019", x"001A", x"0026", x"0027", x"0028", x"0029", x"002B", x"002C", x"002D", x"002E", x"003F", x"0040", x"0041", x"0006", x"0008", x"0009", x"000A", x"000B",
x"000C", x"000D", x"000E", x"000F", x"0010", x"0011", x"0012", x"0013", x"0014", x"0015", x"0016", x"0017", x"0018", x"0019", x"001A", x"001B", x"001C", x"001D", x"001E", x"001F", x"0020",
x"0021", x"0022", x"0023", x"0024", x"0025", x"0026", x"0027", x"0028", x"0029", x"002A", x"002B", x"002C", x"002D", x"002E", x"002F", x"0035", x"0036", x"0037", x"0038", x"0039", x"003A",
x"003B", x"003C", x"003D", x"003E", x"0050", x"0051", x"0052", x"0053", x"0054", x"0055", x"005C", x"005D", x"005E", x"005F", x"0060", x"0061", x"006B", x"006C", x"006D", x"006E", x"006F",
x"0070", x"0071", x"0072", x"0002", x"0003", x"0004", x"0005", x"0006", x"0007", x"0008", x"0009", x"000A", x"000B", x"000C", x"000D", x"000E", x"000F", x"0010", x"0011", x"0012", x"0013",
x"0014", x"0015", x"0016", x"0017", x"0018", x"0019", x"001A", x"001B", x"001C", x"001D", x"001E", x"001F", x"0020", x"0021", x"0022", x"0023", x"0024", x"0025", x"0026", x"0027", x"0028",
x"0029", x"002A", x"002B", x"002C", x"002D", x"0038", x"0039", x"003B", x"003C", x"003D", x"003E", x"003F", x"0040", x"0041", x"0042", x"0043", x"0044", x"0045", x"0046", x"0047", x"0048",
x"0049", x"004A", x"004B", x"004C", x"004D", x"004E", x"004F", x"0050", x"0051", x"0052", x"0059", x"005A", x"005B", x"005C", x"005D", x"005E", x"005F", x"0060", x"0002", x"0003", x"0004",
x"0005", x"0006", x"0007", x"0008", x"0009", x"000A", x"000B", x"000C", x"000D", x"000E", x"000F", x"0010", x"0011", x"0012", x"0013", x"0014", x"0015", x"0016", x"0017", x"0018", x"0019",
x"001A", x"001B", x"001C", x"001D", x"001E", x"001F", x"0020", x"0021", x"0022", x"0023", x"0024", x"0025", x"0026", x"0027", x"0028", x"0029", x"002A", x"002B", x"002C", x"002D", x"002E",
x"002F", x"0030", x"0031", x"0032", x"0033", x"0034", x"0035", x"0036", x"0037", x"0038", x"0039", x"003A", x"003B", x"003C", x"003D", x"003E", x"003F", x"0040", x"0041", x"0042", x"0043",
x"0044", x"0045", x"0046", x"0047", x"0048", x"0049", x"004A", x"004B", x"004C", x"004D", x"004E", x"004F", x"0050", x"0051", x"0052", x"0053", x"0054", x"0055", x"0056", x"0057", x"0058",
x"0059", x"005A", x"005B", x"005C", x"005D", x"005E", x"005F", x"0060", x"0061", x"000E", x"001C", x"0043", x"0049", x"004A", x"004E", x"004F", x"005E", x"0002", x"0003", x"0004", x"0005",
x"0014", x"001A", x"0020", x"0026", x"0044", x"004A", x"0057", x"0058", x"001C", x"0024", x"0025", x"0000"
);

type reg_data is array (326 downto 0) of std_logic_vector(15 downto 0);
constant data : reg_data := (
x"04C0", x"0400", x"0401", x"0403", x"0417", x"041A", x"0400", x"0400", x"0400", x"0474", x"04D0", x"04FD", x"040B", x"0400", x"0402", x"0432", x"0404", x"0400", x"0400", x"0488", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0488", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0406", x"0400", x"0400", x"0400", x"0401", x"0406", x"0409", x"043E",
x"0418", x"0406", x"0409", x"043E", x"0418", x"0401", x"0409", x"043B", x"0428", x"0401", x"0409", x"043B", x"0428", x"0400", x"0400", x"0440", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0401", x"0400", x"0400", x"0400", x"0400", x"0400", x"0401", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0442", x"0400",
x"0400", x"0400", x"0400", x"0480", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"04A5", x"0400", x"0400", x"0400", x"0400", x"0480", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"041F", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400",
x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0400", x"0404", x"0400", x"0402", x"0420", x"0449", x"0402", x"0400", x"0400", x"0401", x"0401", x"0401",
x"0400", x"0400", x"0400", x"0400", x"040F", x"040E", x"0481", x"0400", x"0401", x"04C3", x"0402", x"0000");

constant page_addr : std_logic_vector(15 downto 0):= X"0001";

signal clk_div : std_logic := '0';
signal temporal: STD_LOGIC;
signal counter : integer range 0 to 10 := 0; --count clock
signal cnt_bits : integer range 0 to 15 := 15;
signal cnt_clk : integer range 0 to 3 := 0; --for counting clock
signal cnt : integer range 0 to 326 := 326;
signal flag : std_logic_vector(1 downto 0) := "00";

signal cnt_delay1 :  integer range 0 to 500 := 0;
signal cnt_delay2 :  integer range 0 to 500 := 0;
signal cnt_delay3 :  integer range 0 to 500 := 0;

type state_type is (set_page_reg, wrt_page, set_addr, wrt_data, delay, cs_high, done);
signal  state :state_type;

begin
clk_division :
process (rst, clk) begin
        if (rst = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk) then
            if (counter = 9) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
end process;

clk_div <= temporal;




process(clk_div, rst)
begin
    if rst = '1' then
        state <= cs_high;
        spi_sdo <= '0';
		rst_micro <= '0';
		spi_cs <= '1';
    elsif falling_edge(clk_div) then
        case state is

          when cs_high =>
          spi_cs <= '1';
          if cnt = 0 then
            state <= done;
          --elsif cnt = 319 then  --319
            --state <= delay;--after delay, jump to set_page_reg
          elsif cnt_clk = 3 then
                cnt_clk <= 0;
              if flag <= "00" then
                if cnt = 321 and cnt_delay3 = 60 then
                    cnt <= cnt - 1;
                end if;
                state <= set_page_reg;
              elsif flag <= "01" then
                state <= wrt_page;
              elsif flag <= "10" then
                state <= set_addr;
              elsif flag <= "11" then
                state <= wrt_data;
              end if;
          else
            cnt_clk <= cnt_clk + 1;
            spi_cs <= '1';
          end if;

      --First step, Set Address to Register 0x01 PAGE,set address command 0X00.
        when set_page_reg =>
          spi_cs <= '0';
          if cnt_bits = 0 then
            --if cnt = 319 then
              --  state <= wrt_page;
           -- else
              state <= cs_high;
           -- end if;
            spi_sdo <= page_addr(cnt_bits);
            cnt_bits <= 15;
            flag <= "01";
          else
            spi_sdo <= page_addr(cnt_bits);
            cnt_bits <= cnt_bits - 1;
            state <= set_page_reg;
          end if;

      --Second step, Write Value 0x?? (high) to set the page to ??, write data commamd 0X40.
        when wrt_page =>
          spi_cs <= '0';
          if cnt_bits = 0 then
            spi_sdo <= addr_high(cnt)(cnt_bits);
            cnt_bits <= 15;
            --if cnt = 319 then
               -- state <= set_addr;
            --else
                state <= cs_high;
            --end if;
            flag <= "10";
          else
            spi_sdo <= addr_high(cnt)(cnt_bits);
            cnt_bits <= cnt_bits - 1;
            state <= wrt_page;
          end if;

      --Third step,  Set the register address to 0x?? (low), set address command 0X00.
        when set_addr =>
          spi_cs <= '0';
          if cnt_bits = 0 then
            spi_sdo <= addr_low(cnt)(cnt_bits);
            cnt_bits <= 15;
            --if cnt = 319 then
               -- state <= wrt_data;
            --else
                state <= cs_high;
            --end if;
            flag <= "11";
          else
            spi_sdo <= addr_low(cnt)(cnt_bits);
            cnt_bits <= cnt_bits - 1;
            state <= set_addr;
          end if;
      --Fourth step, Write Value, write data commamd 0X40.
        when wrt_data =>
          spi_cs <= '0';
          if cnt_bits = 0 then
            spi_sdo <= data(cnt)(cnt_bits);
            cnt_bits <= 15;
            if cnt = 321 then
                if cnt_delay3 = 50 then
                    state <= cs_high;
                else
                    state <= delay;
                end if;
            elsif cnt > 0 and  cnt /= 321 then
                cnt <= cnt - 1;
                state <= cs_high;
            --elsif cnt = 0 then
                --state <= done;
            else
                state <= cs_high;
            end if;
            flag <= "00";
          else
            spi_sdo <= data(cnt)(cnt_bits);
            cnt_bits <= cnt_bits - 1;
            state <= wrt_data;
          end if;

      --delay
        when delay =>
            spi_cs <= '1';
             if cnt_delay3 = 60 then
               state <= cs_high;
            elsif  cnt_delay2 =100 then
               cnt_delay2 <= 0;
               state <= delay;
               cnt_delay3 <= cnt_delay3 + 1;
            elsif cnt_delay1 = 200 then
               state <= delay;
               cnt_delay1 <= 0;
               cnt_delay2 <= cnt_delay2 + 1;
            else
               cnt_delay1 <= cnt_delay1 + 1;
               state <= delay;
            end if;
      --done
        when done =>
           state <= done;
           spi_cs <= '1';
           spi_sdo <= '0';
           rst_micro <= '1';
      end case;
  end if;
end process;

spi_clk <= clk_div;

end Behavioral;
