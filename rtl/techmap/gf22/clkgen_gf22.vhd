-- Copyright (c) 2011-2021 Columbia University, System Level Design Group
-- SPDX-License-Identifier: Apache-2.0
library ieee;
use ieee.std_logic_1164.all;


entity dco_gf22_wrapper is

  generic (
    enable_div2 : integer range 0 to 1 := 0);
  port (
    RSTN     : in  std_ulogic;
    EXT_CLK  : in  std_logic;
    EN       : in  std_ulogic;
    CLK_SEL  : in  std_ulogic;
    CC_SEL   : in  std_logic_vector(5 downto 0);
    FC_SEL   : in  std_logic_vector(5 downto 0);
    DIV_SEL  : in  std_logic_vector(2 downto 0);
    FREQ_SEL : in  std_logic_vector(1 downto 0);
    CLK      : out std_logic;
    CLK_DIV2    : out std_logic;
    CLK_DIV2_90 : out std_logic;
    CLK_DIV  : out std_logic);

end entity dco_gf22_wrapper;

architecture rtl of dco_gf22_wrapper is

  signal RST : std_ulogic;

  component DCO_GF22 is
    port (
      RSTN     : in  std_ulogic;
      EXT_CLK  : in  std_logic;
      EN       : in  std_ulogic;
      CLK_SEL  : in  std_ulogic;
      CC_SEL   : in  std_logic_vector(5 downto 0);
      FC_SEL   : in  std_logic_vector(5 downto 0);
      DIV_SEL  : in  std_logic_vector(2 downto 0);
      FREQ_SEL : in  std_logic_vector(1 downto 0);
      CLK      : out std_logic;
      CLK_DIV  : out std_logic);
  end component DCO_GF22;

  component DCO_LPDDR_GF22 is
    port (
      RSTN        : in  std_ulogic;
      EXT_CLK     : in  std_logic;
      EN          : in  std_ulogic;
      CLK_SEL     : in  std_ulogic;
      CC_SEL      : in  std_logic_vector(5 downto 0);
      FC_SEL      : in  std_logic_vector(5 downto 0);
      DIV_SEL     : in  std_logic_vector(2 downto 0);
      FREQ_SEL    : in  std_logic_vector(1 downto 0);
      CLK         : out std_logic;
      CLK_DIV2    : out std_logic;
      CLK_DIV2_90 : out std_logic;
      CLK_DIV     : out std_logic);
  end component DCO_LPDDR_GF22;

begin  -- architecture rtl

  RST <= not RSTN;

  no_div2: if enable_div2 = 0 generate
    DCO_GF22_1 : DCO_GF22
      port map (
        RSTN     => RST,
        EXT_CLK  => EXT_CLK,
        EN       => EN,
        CLK_SEL  => CLK_SEL,
        CC_SEL   => CC_SEL,
        FC_SEL   => FC_SEL,
        DIV_SEL  => DIV_SEL,
        FREQ_SEL => FREQ_SEL,
        CLK      => CLK,
        CLK_DIV  => CLK_DIV);

    CLK_DIV2 <= '0';
    CLK_DIV2_90 <= '0';
  end generate no_div2;

  with_div2: if enable_div2 /= 0 generate
    DCO_LPDDR_GF22_1 : DCO_LPDDR_GF22
      port map (
        RSTN        => RSTN,
        EXT_CLK     => EXT_CLK,
        EN          => EN,
        CLK_SEL     => CLK_SEL,
        CC_SEL      => CC_SEL,
        FC_SEL      => FC_SEL,
        DIV_SEL     => DIV_SEL,
        FREQ_SEL    => FREQ_SEL,
        CLK         => CLK,
        CLK_DIV2    => CLK_DIV2,
        CLK_DIV2_90 => CLK_DIV2_90,
        CLK_DIV     => CLK_DIV);
  end generate with_div2;

end architecture rtl;
