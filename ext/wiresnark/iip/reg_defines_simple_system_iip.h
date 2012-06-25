/********************************************************
 *
 * C register defines file
 * Project: Simple System IIP (iip_simple_system)
 * Description: Test of simple system iip with static routing 
 *
 ********************************************************/

#ifndef _REG_DEFINES_IIP_SIMPLE_SYSTEM_
#define _REG_DEFINES_IIP_SIMPLE_SYSTEM_

/* ========= Version Information ========= */

#define DEVICE_ID          0
#define DEVICE_MAJOR       1
#define DEVICE_MINOR       0
#define DEVICE_REVISION    1
#define DEVICE_PROJ_DIR    "iip_simple_system"
#define DEVICE_PROJ_NAME   "Simple System IIP"
#define DEVICE_PROJ_DESC   "Test of simple system iip with static routing "


/* ========= Constants ========= */

// ===== File: lib/verilog/core/common/xml/global.xml =====

// Maximum number of phy ports
#define MAX_PHY_PORTS                       4

// PCI address bus width
#define PCI_ADDR_WIDTH                      32

// PCI data bus width
#define PCI_DATA_WIDTH                      32

// PCI byte enable bus width
#define PCI_BE_WIDTH                        4

// CPCI--CNET address bus width. This is byte addresses even though bottom bits are zero.
#define CPCI_CNET_ADDR_WIDTH                27

// CPCI--CNET data bus width
#define CPCI_CNET_DATA_WIDTH                32

// CPCI--Virtex address bus width. This is byte addresses even though bottom bits are zero.
#define CPCI_NF2_ADDR_WIDTH                 27

// CPCI--Virtex data bus width
#define CPCI_NF2_DATA_WIDTH                 32

// DMA data bus width
#define DMA_DATA_WIDTH                      32

// DMA control bus width
#define DMA_CTRL_WIDTH                      4

// CPCI debug bus width
#define CPCI_DEBUG_DATA_WIDTH               29

// SRAM address width
#define SRAM_ADDR_WIDTH                     19

// SRAM data width
#define SRAM_DATA_WIDTH                     36

// DRAM address width
#define DRAM_ADDR_WIDTH                     24


// ===== File: lib/verilog/core/common/xml/nf_defines.xml =====

// Clock period of 125 MHz clock in ns
#define FAST_CLK_PERIOD                     8

// Clock period of 62.5 MHz clock in ns
#define SLOW_CLK_PERIOD                     16

// Header value used by the IO queues
#define IO_QUEUE_STAGE_NUM                  0xff

// Data path data width
#define DATA_WIDTH                          64

// Data path control width
#define CTRL_WIDTH                          8


// ===== File: lib/verilog/core/utils/xml/device_id_reg.xml =====

// Total number of registers
#define DEV_ID_NUM_REGS                     64

// Number of non string registers
#define DEV_ID_NON_STR_REGS                 7

// Length of MD5 sum (bits)
#define DEV_ID_MD5SUM_LENGTH                128

// Project directory length (in words, not chars)
#define DEV_ID_PROJ_DIR_WORD_LEN            16

// Project directory length (in bytes/chars)
#define DEV_ID_PROJ_DIR_BYTE_LEN            64

// Project directory length (in bits)
#define DEV_ID_PROJ_DIR_BIT_LEN             512

// Project name length (in words, not chars)
#define DEV_ID_PROJ_NAME_WORD_LEN           16

// Project name length (in bytes/chars)
#define DEV_ID_PROJ_NAME_BYTE_LEN           64

// Project name length (in bits)
#define DEV_ID_PROJ_NAME_BIT_LEN            512

// Device description length (in words, not chars)
#define DEV_ID_PROJ_DESC_WORD_LEN           25

// Device description length (in bytes/chars)
#define DEV_ID_PROJ_DESC_BYTE_LEN           100

// Device description length (in bits)
#define DEV_ID_PROJ_DESC_BIT_LEN            800

// MD5 identifier (v1): MD5 sum of the string "device_id.v"
#define DEV_ID_MD5_VALUE_V1                 0x4071736d8a603d2b4d55f62989a73c95
#define DEV_ID_MD5_VALUE_V1_0               0x4071736d
#define DEV_ID_MD5_VALUE_V1_1               0x8a603d2b
#define DEV_ID_MD5_VALUE_V1_2               0x4d55f629
#define DEV_ID_MD5_VALUE_V1_3               0x89a73c95

// MD5 identifier (v2): MD5 sum of the string "device_id.v:v2"
#define DEV_ID_MD5_VALUE_V2                 0x5e461ffe439725c9279a22a1855f6c53
#define DEV_ID_MD5_VALUE_V2_0               0x5e461ffe
#define DEV_ID_MD5_VALUE_V2_1               0x439725c9
#define DEV_ID_MD5_VALUE_V2_2               0x279a22a1
#define DEV_ID_MD5_VALUE_V2_3               0x855f6c53

// Total number of registers (v1)
#define DEV_ID_NUM_REGS_V1                  64

// Number of non string registers (v1)
#define DEV_ID_NON_STR_REGS_V1              7

// Project name length (v1: in words, not chars)
#define DEV_ID_PROJ_NAME_WORD_LEN_V1        25

// Project name length (v1: in bytes/chars)
#define DEV_ID_PROJ_NAME_BYTE_LEN_V1        100

// Project name length (v1: in bits)
#define DEV_ID_PROJ_NAME_BIT_LEN_V1         800


// ===== File: lib/verilog/core/io_queues/cpu_dma_queue/xml/cpu_dma_queue.xml =====

#define CPU_QUEUE_REGS_ENABLE               0x00000000

#define CPU_QUEUE_REGS_DISABLE              0x00000001


// ===== File: lib/verilog/core/io_queues/ethernet_queue/xml/ethernet_mac.xml =====

// TX queue disable bit
#define MAC_GRP_TX_QUEUE_DISABLE_BIT_NUM    0

// RX queue disable bit
#define MAC_GRP_RX_QUEUE_DISABLE_BIT_NUM    1

// Reset MAC bit
#define MAC_GRP_RESET_MAC_BIT_NUM           2

// MAC TX queue disable bit
#define MAC_GRP_MAC_DISABLE_TX_BIT_NUM      3

// MAC RX queue disable bit
#define MAC_GRP_MAC_DISABLE_RX_BIT_NUM      4

// MAC disable jumbo TX bit
#define MAC_GRP_MAC_DIS_JUMBO_TX_BIT_NUM    5

// MAC disable jumbo RX bit
#define MAC_GRP_MAC_DIS_JUMBO_RX_BIT_NUM    6

// MAC disable crc check disable bit
#define MAC_GRP_MAC_DIS_CRC_CHECK_BIT_NUM   7

// MAC disable crc generate bit
#define MAC_GRP_MAC_DIS_CRC_GEN_BIT_NUM     8


/* ========= Modules ========= */

// Module tags
#define CORE_BASE_ADDR         0x0000000
#define DEV_ID_BASE_ADDR       0x0400000
#define MDIO_BASE_ADDR         0x0440000
#define DMA_BASE_ADDR          0x0500000
#define MAC_GRP_0_BASE_ADDR    0x0600000
#define MAC_GRP_1_BASE_ADDR    0x0640000
#define MAC_GRP_2_BASE_ADDR    0x0680000
#define MAC_GRP_3_BASE_ADDR    0x06c0000
#define CPU_QUEUE_0_BASE_ADDR  0x0700000
#define CPU_QUEUE_1_BASE_ADDR  0x0740000
#define CPU_QUEUE_2_BASE_ADDR  0x0780000
#define CPU_QUEUE_3_BASE_ADDR  0x07c0000
#define SRAM_BASE_ADDR         0x1000000
#define UDP_BASE_ADDR          0x2000000
#define PORT_0_BASE_ADDR       0x2000000
#define PORT_1_BASE_ADDR       0x2000100
#define PORT_2_BASE_ADDR       0x2000200
#define PORT_3_BASE_ADDR       0x2000300
#define PIROUTER_BASE_ADDR     0x2000400
#define DT_QUEUES_0_BASE_ADDR  0x2000480
#define DT_QUEUES_1_BASE_ADDR  0x2000500
#define DT_QUEUES_2_BASE_ADDR  0x2000580
#define DT_QUEUES_3_BASE_ADDR  0x2000600
#define DRAM_BASE_ADDR         0x4000000

#define CPU_QUEUE_OFFSET   0x0040000
#define DT_QUEUES_OFFSET   0x0000080
#define MAC_GRP_OFFSET     0x0040000
#define PORT_OFFSET        0x0000100


/* ========== Registers ========== */

// Name: device_id (DEV_ID)
// Description: Device identification
// File: lib/verilog/core/utils/xml/device_id_reg.xml
#define DEV_ID_MD5_0_REG          0x0400000
#define DEV_ID_MD5_1_REG          0x0400004
#define DEV_ID_MD5_2_REG          0x0400008
#define DEV_ID_MD5_3_REG          0x040000c
#define DEV_ID_DEVICE_ID_REG      0x0400010
#define DEV_ID_VERSION_REG        0x0400014
#define DEV_ID_CPCI_ID_REG        0x0400018
#define DEV_ID_PROJ_DIR_0_REG     0x040001c
#define DEV_ID_PROJ_DIR_1_REG     0x0400020
#define DEV_ID_PROJ_DIR_2_REG     0x0400024
#define DEV_ID_PROJ_DIR_3_REG     0x0400028
#define DEV_ID_PROJ_DIR_4_REG     0x040002c
#define DEV_ID_PROJ_DIR_5_REG     0x0400030
#define DEV_ID_PROJ_DIR_6_REG     0x0400034
#define DEV_ID_PROJ_DIR_7_REG     0x0400038
#define DEV_ID_PROJ_DIR_8_REG     0x040003c
#define DEV_ID_PROJ_DIR_9_REG     0x0400040
#define DEV_ID_PROJ_DIR_10_REG    0x0400044
#define DEV_ID_PROJ_DIR_11_REG    0x0400048
#define DEV_ID_PROJ_DIR_12_REG    0x040004c
#define DEV_ID_PROJ_DIR_13_REG    0x0400050
#define DEV_ID_PROJ_DIR_14_REG    0x0400054
#define DEV_ID_PROJ_DIR_15_REG    0x0400058
#define DEV_ID_PROJ_NAME_0_REG    0x040005c
#define DEV_ID_PROJ_NAME_1_REG    0x0400060
#define DEV_ID_PROJ_NAME_2_REG    0x0400064
#define DEV_ID_PROJ_NAME_3_REG    0x0400068
#define DEV_ID_PROJ_NAME_4_REG    0x040006c
#define DEV_ID_PROJ_NAME_5_REG    0x0400070
#define DEV_ID_PROJ_NAME_6_REG    0x0400074
#define DEV_ID_PROJ_NAME_7_REG    0x0400078
#define DEV_ID_PROJ_NAME_8_REG    0x040007c
#define DEV_ID_PROJ_NAME_9_REG    0x0400080
#define DEV_ID_PROJ_NAME_10_REG   0x0400084
#define DEV_ID_PROJ_NAME_11_REG   0x0400088
#define DEV_ID_PROJ_NAME_12_REG   0x040008c
#define DEV_ID_PROJ_NAME_13_REG   0x0400090
#define DEV_ID_PROJ_NAME_14_REG   0x0400094
#define DEV_ID_PROJ_NAME_15_REG   0x0400098
#define DEV_ID_PROJ_DESC_0_REG    0x040009c
#define DEV_ID_PROJ_DESC_1_REG    0x04000a0
#define DEV_ID_PROJ_DESC_2_REG    0x04000a4
#define DEV_ID_PROJ_DESC_3_REG    0x04000a8
#define DEV_ID_PROJ_DESC_4_REG    0x04000ac
#define DEV_ID_PROJ_DESC_5_REG    0x04000b0
#define DEV_ID_PROJ_DESC_6_REG    0x04000b4
#define DEV_ID_PROJ_DESC_7_REG    0x04000b8
#define DEV_ID_PROJ_DESC_8_REG    0x04000bc
#define DEV_ID_PROJ_DESC_9_REG    0x04000c0
#define DEV_ID_PROJ_DESC_10_REG   0x04000c4
#define DEV_ID_PROJ_DESC_11_REG   0x04000c8
#define DEV_ID_PROJ_DESC_12_REG   0x04000cc
#define DEV_ID_PROJ_DESC_13_REG   0x04000d0
#define DEV_ID_PROJ_DESC_14_REG   0x04000d4
#define DEV_ID_PROJ_DESC_15_REG   0x04000d8
#define DEV_ID_PROJ_DESC_16_REG   0x04000dc
#define DEV_ID_PROJ_DESC_17_REG   0x04000e0
#define DEV_ID_PROJ_DESC_18_REG   0x04000e4
#define DEV_ID_PROJ_DESC_19_REG   0x04000e8
#define DEV_ID_PROJ_DESC_20_REG   0x04000ec
#define DEV_ID_PROJ_DESC_21_REG   0x04000f0
#define DEV_ID_PROJ_DESC_22_REG   0x04000f4
#define DEV_ID_PROJ_DESC_23_REG   0x04000f8
#define DEV_ID_PROJ_DESC_24_REG   0x04000fc

// Name: mdio (MDIO)
// Description: MDIO interface
// File: lib/verilog/core/io/mdio/xml/mdio.xml
#define MDIO_PHY_0_CONTROL_REG                                  0x0440000
#define MDIO_PHY_0_STATUS_REG                                   0x0440004
#define MDIO_PHY_0_PHY_ID_HI_REG                                0x0440008
#define MDIO_PHY_0_PHY_ID_LO_REG                                0x044000c
#define MDIO_PHY_0_AUTONEGOTIATION_ADVERT_REG                   0x0440010
#define MDIO_PHY_0_AUTONEG_LINK_PARTNER_BASE_PAGE_ABILITY_REG   0x0440014
#define MDIO_PHY_0_AUTONEG_EXPANSION_REG                        0x0440018
#define MDIO_PHY_0_AUTONEG_NEXT_PAGE_TX_REG                     0x044001c
#define MDIO_PHY_0_AUTONEG_LINK_PARTNER_RCVD_NEXT_PAGE_REG      0x0440020
#define MDIO_PHY_0_MASTER_SLAVE_CTRL_REG                        0x0440024
#define MDIO_PHY_0_MASTER_SLAVE_STATUS_REG                      0x0440028
#define MDIO_PHY_0_PSE_CTRL_REG                                 0x044002c
#define MDIO_PHY_0_PSE_STATUS_REG                               0x0440030
#define MDIO_PHY_0_MMD_ACCESS_CTRL_REG                          0x0440034
#define MDIO_PHY_0_MMD_ACCESS_STATUS_REG                        0x0440038
#define MDIO_PHY_0_EXTENDED_STATUS_REG                          0x044003c
#define MDIO_PHY_0_PHY_EXTENDED_CTRL_REG                        0x0440040
#define MDIO_PHY_0_PHY_EXTENDED_STATUS_REG                      0x0440044
#define MDIO_PHY_0_RX_ERROR_COUNT_REG                           0x0440048
#define MDIO_PHY_0_FALSE_CARRIER_SENSE_COUNT_REG                0x044004c
#define MDIO_PHY_0_RX_NOT_OK_COUNT_REG                          0x0440050
#define MDIO_PHY_0_EXPANSION_1_REG                              0x0440054
#define MDIO_PHY_0_EXPANSION_2_REG                              0x0440058
#define MDIO_PHY_0_EXPANSION_REG_ACCESS_REG                     0x044005c
#define MDIO_PHY_0_SHADOW_18_REG                                0x0440060
#define MDIO_PHY_0_AUX_STATUS_REG                               0x0440064
#define MDIO_PHY_0_INT_STATUS_REG                               0x0440068
#define MDIO_PHY_0_INT_MASK_REG                                 0x044006c
#define MDIO_PHY_0_SHADOW_1C_REG                                0x0440070
#define MDIO_PHY_0_SHADOW_1D_REG                                0x0440074
#define MDIO_PHY_0_TEST_REG                                     0x0440078
#define MDIO_PHY_0_RESERVED_REG                                 0x044007c
#define MDIO_PHY_1_CONTROL_REG                                  0x0440080
#define MDIO_PHY_1_STATUS_REG                                   0x0440084
#define MDIO_PHY_1_PHY_ID_HI_REG                                0x0440088
#define MDIO_PHY_1_PHY_ID_LO_REG                                0x044008c
#define MDIO_PHY_1_AUTONEGOTIATION_ADVERT_REG                   0x0440090
#define MDIO_PHY_1_AUTONEG_LINK_PARTNER_BASE_PAGE_ABILITY_REG   0x0440094
#define MDIO_PHY_1_AUTONEG_EXPANSION_REG                        0x0440098
#define MDIO_PHY_1_AUTONEG_NEXT_PAGE_TX_REG                     0x044009c
#define MDIO_PHY_1_AUTONEG_LINK_PARTNER_RCVD_NEXT_PAGE_REG      0x04400a0
#define MDIO_PHY_1_MASTER_SLAVE_CTRL_REG                        0x04400a4
#define MDIO_PHY_1_MASTER_SLAVE_STATUS_REG                      0x04400a8
#define MDIO_PHY_1_PSE_CTRL_REG                                 0x04400ac
#define MDIO_PHY_1_PSE_STATUS_REG                               0x04400b0
#define MDIO_PHY_1_MMD_ACCESS_CTRL_REG                          0x04400b4
#define MDIO_PHY_1_MMD_ACCESS_STATUS_REG                        0x04400b8
#define MDIO_PHY_1_EXTENDED_STATUS_REG                          0x04400bc
#define MDIO_PHY_1_PHY_EXTENDED_CTRL_REG                        0x04400c0
#define MDIO_PHY_1_PHY_EXTENDED_STATUS_REG                      0x04400c4
#define MDIO_PHY_1_RX_ERROR_COUNT_REG                           0x04400c8
#define MDIO_PHY_1_FALSE_CARRIER_SENSE_COUNT_REG                0x04400cc
#define MDIO_PHY_1_RX_NOT_OK_COUNT_REG                          0x04400d0
#define MDIO_PHY_1_EXPANSION_1_REG                              0x04400d4
#define MDIO_PHY_1_EXPANSION_2_REG                              0x04400d8
#define MDIO_PHY_1_EXPANSION_REG_ACCESS_REG                     0x04400dc
#define MDIO_PHY_1_SHADOW_18_REG                                0x04400e0
#define MDIO_PHY_1_AUX_STATUS_REG                               0x04400e4
#define MDIO_PHY_1_INT_STATUS_REG                               0x04400e8
#define MDIO_PHY_1_INT_MASK_REG                                 0x04400ec
#define MDIO_PHY_1_SHADOW_1C_REG                                0x04400f0
#define MDIO_PHY_1_SHADOW_1D_REG                                0x04400f4
#define MDIO_PHY_1_TEST_REG                                     0x04400f8
#define MDIO_PHY_1_RESERVED_REG                                 0x04400fc
#define MDIO_PHY_2_CONTROL_REG                                  0x0440100
#define MDIO_PHY_2_STATUS_REG                                   0x0440104
#define MDIO_PHY_2_PHY_ID_HI_REG                                0x0440108
#define MDIO_PHY_2_PHY_ID_LO_REG                                0x044010c
#define MDIO_PHY_2_AUTONEGOTIATION_ADVERT_REG                   0x0440110
#define MDIO_PHY_2_AUTONEG_LINK_PARTNER_BASE_PAGE_ABILITY_REG   0x0440114
#define MDIO_PHY_2_AUTONEG_EXPANSION_REG                        0x0440118
#define MDIO_PHY_2_AUTONEG_NEXT_PAGE_TX_REG                     0x044011c
#define MDIO_PHY_2_AUTONEG_LINK_PARTNER_RCVD_NEXT_PAGE_REG      0x0440120
#define MDIO_PHY_2_MASTER_SLAVE_CTRL_REG                        0x0440124
#define MDIO_PHY_2_MASTER_SLAVE_STATUS_REG                      0x0440128
#define MDIO_PHY_2_PSE_CTRL_REG                                 0x044012c
#define MDIO_PHY_2_PSE_STATUS_REG                               0x0440130
#define MDIO_PHY_2_MMD_ACCESS_CTRL_REG                          0x0440134
#define MDIO_PHY_2_MMD_ACCESS_STATUS_REG                        0x0440138
#define MDIO_PHY_2_EXTENDED_STATUS_REG                          0x044013c
#define MDIO_PHY_2_PHY_EXTENDED_CTRL_REG                        0x0440140
#define MDIO_PHY_2_PHY_EXTENDED_STATUS_REG                      0x0440144
#define MDIO_PHY_2_RX_ERROR_COUNT_REG                           0x0440148
#define MDIO_PHY_2_FALSE_CARRIER_SENSE_COUNT_REG                0x044014c
#define MDIO_PHY_2_RX_NOT_OK_COUNT_REG                          0x0440150
#define MDIO_PHY_2_EXPANSION_1_REG                              0x0440154
#define MDIO_PHY_2_EXPANSION_2_REG                              0x0440158
#define MDIO_PHY_2_EXPANSION_REG_ACCESS_REG                     0x044015c
#define MDIO_PHY_2_SHADOW_18_REG                                0x0440160
#define MDIO_PHY_2_AUX_STATUS_REG                               0x0440164
#define MDIO_PHY_2_INT_STATUS_REG                               0x0440168
#define MDIO_PHY_2_INT_MASK_REG                                 0x044016c
#define MDIO_PHY_2_SHADOW_1C_REG                                0x0440170
#define MDIO_PHY_2_SHADOW_1D_REG                                0x0440174
#define MDIO_PHY_2_TEST_REG                                     0x0440178
#define MDIO_PHY_2_RESERVED_REG                                 0x044017c
#define MDIO_PHY_3_CONTROL_REG                                  0x0440180
#define MDIO_PHY_3_STATUS_REG                                   0x0440184
#define MDIO_PHY_3_PHY_ID_HI_REG                                0x0440188
#define MDIO_PHY_3_PHY_ID_LO_REG                                0x044018c
#define MDIO_PHY_3_AUTONEGOTIATION_ADVERT_REG                   0x0440190
#define MDIO_PHY_3_AUTONEG_LINK_PARTNER_BASE_PAGE_ABILITY_REG   0x0440194
#define MDIO_PHY_3_AUTONEG_EXPANSION_REG                        0x0440198
#define MDIO_PHY_3_AUTONEG_NEXT_PAGE_TX_REG                     0x044019c
#define MDIO_PHY_3_AUTONEG_LINK_PARTNER_RCVD_NEXT_PAGE_REG      0x04401a0
#define MDIO_PHY_3_MASTER_SLAVE_CTRL_REG                        0x04401a4
#define MDIO_PHY_3_MASTER_SLAVE_STATUS_REG                      0x04401a8
#define MDIO_PHY_3_PSE_CTRL_REG                                 0x04401ac
#define MDIO_PHY_3_PSE_STATUS_REG                               0x04401b0
#define MDIO_PHY_3_MMD_ACCESS_CTRL_REG                          0x04401b4
#define MDIO_PHY_3_MMD_ACCESS_STATUS_REG                        0x04401b8
#define MDIO_PHY_3_EXTENDED_STATUS_REG                          0x04401bc
#define MDIO_PHY_3_PHY_EXTENDED_CTRL_REG                        0x04401c0
#define MDIO_PHY_3_PHY_EXTENDED_STATUS_REG                      0x04401c4
#define MDIO_PHY_3_RX_ERROR_COUNT_REG                           0x04401c8
#define MDIO_PHY_3_FALSE_CARRIER_SENSE_COUNT_REG                0x04401cc
#define MDIO_PHY_3_RX_NOT_OK_COUNT_REG                          0x04401d0
#define MDIO_PHY_3_EXPANSION_1_REG                              0x04401d4
#define MDIO_PHY_3_EXPANSION_2_REG                              0x04401d8
#define MDIO_PHY_3_EXPANSION_REG_ACCESS_REG                     0x04401dc
#define MDIO_PHY_3_SHADOW_18_REG                                0x04401e0
#define MDIO_PHY_3_AUX_STATUS_REG                               0x04401e4
#define MDIO_PHY_3_INT_STATUS_REG                               0x04401e8
#define MDIO_PHY_3_INT_MASK_REG                                 0x04401ec
#define MDIO_PHY_3_SHADOW_1C_REG                                0x04401f0
#define MDIO_PHY_3_SHADOW_1D_REG                                0x04401f4
#define MDIO_PHY_3_TEST_REG                                     0x04401f8
#define MDIO_PHY_3_RESERVED_REG                                 0x04401fc

#define MDIO_PHY_GROUP_BASE_ADDR   0x0440000
#define MDIO_PHY_GROUP_INST_OFFSET 0x0000080

// Name: dma (DMA)
// Description: DMA transfer module
// File: lib/verilog/core/dma/xml/dma.xml
#define DMA_CTRL_REG                0x0500000
#define DMA_NUM_INGRESS_PKTS_REG    0x0500004
#define DMA_NUM_INGRESS_BYTES_REG   0x0500008
#define DMA_NUM_EGRESS_PKTS_REG     0x050000c
#define DMA_NUM_EGRESS_BYTES_REG    0x0500010
#define DMA_NUM_TIMEOUTS_REG        0x0500014

// Name: nf2_mac_grp (MAC_GRP_0)
// Description: Ethernet MAC group
// File: lib/verilog/core/io_queues/ethernet_queue/xml/ethernet_mac.xml
#define MAC_GRP_0_CONTROL_REG                          0x0600000
#define MAC_GRP_0_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x0600004
#define MAC_GRP_0_RX_QUEUE_NUM_PKTS_STORED_REG         0x0600008
#define MAC_GRP_0_RX_QUEUE_NUM_PKTS_DROPPED_FULL_REG   0x060000c
#define MAC_GRP_0_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG    0x0600010
#define MAC_GRP_0_RX_QUEUE_NUM_PKTS_DEQUEUED_REG       0x0600014
#define MAC_GRP_0_RX_QUEUE_NUM_WORDS_PUSHED_REG        0x0600018
#define MAC_GRP_0_RX_QUEUE_NUM_BYTES_PUSHED_REG        0x060001c
#define MAC_GRP_0_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x0600020
#define MAC_GRP_0_TX_QUEUE_NUM_PKTS_ENQUEUED_REG       0x0600024
#define MAC_GRP_0_TX_QUEUE_NUM_PKTS_SENT_REG           0x0600028
#define MAC_GRP_0_TX_QUEUE_NUM_WORDS_PUSHED_REG        0x060002c
#define MAC_GRP_0_TX_QUEUE_NUM_BYTES_PUSHED_REG        0x0600030

// Name: nf2_mac_grp (MAC_GRP_1)
// Description: Ethernet MAC group
// File: lib/verilog/core/io_queues/ethernet_queue/xml/ethernet_mac.xml
#define MAC_GRP_1_CONTROL_REG                          0x0640000
#define MAC_GRP_1_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x0640004
#define MAC_GRP_1_RX_QUEUE_NUM_PKTS_STORED_REG         0x0640008
#define MAC_GRP_1_RX_QUEUE_NUM_PKTS_DROPPED_FULL_REG   0x064000c
#define MAC_GRP_1_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG    0x0640010
#define MAC_GRP_1_RX_QUEUE_NUM_PKTS_DEQUEUED_REG       0x0640014
#define MAC_GRP_1_RX_QUEUE_NUM_WORDS_PUSHED_REG        0x0640018
#define MAC_GRP_1_RX_QUEUE_NUM_BYTES_PUSHED_REG        0x064001c
#define MAC_GRP_1_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x0640020
#define MAC_GRP_1_TX_QUEUE_NUM_PKTS_ENQUEUED_REG       0x0640024
#define MAC_GRP_1_TX_QUEUE_NUM_PKTS_SENT_REG           0x0640028
#define MAC_GRP_1_TX_QUEUE_NUM_WORDS_PUSHED_REG        0x064002c
#define MAC_GRP_1_TX_QUEUE_NUM_BYTES_PUSHED_REG        0x0640030

// Name: nf2_mac_grp (MAC_GRP_2)
// Description: Ethernet MAC group
// File: lib/verilog/core/io_queues/ethernet_queue/xml/ethernet_mac.xml
#define MAC_GRP_2_CONTROL_REG                          0x0680000
#define MAC_GRP_2_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x0680004
#define MAC_GRP_2_RX_QUEUE_NUM_PKTS_STORED_REG         0x0680008
#define MAC_GRP_2_RX_QUEUE_NUM_PKTS_DROPPED_FULL_REG   0x068000c
#define MAC_GRP_2_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG    0x0680010
#define MAC_GRP_2_RX_QUEUE_NUM_PKTS_DEQUEUED_REG       0x0680014
#define MAC_GRP_2_RX_QUEUE_NUM_WORDS_PUSHED_REG        0x0680018
#define MAC_GRP_2_RX_QUEUE_NUM_BYTES_PUSHED_REG        0x068001c
#define MAC_GRP_2_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x0680020
#define MAC_GRP_2_TX_QUEUE_NUM_PKTS_ENQUEUED_REG       0x0680024
#define MAC_GRP_2_TX_QUEUE_NUM_PKTS_SENT_REG           0x0680028
#define MAC_GRP_2_TX_QUEUE_NUM_WORDS_PUSHED_REG        0x068002c
#define MAC_GRP_2_TX_QUEUE_NUM_BYTES_PUSHED_REG        0x0680030

// Name: nf2_mac_grp (MAC_GRP_3)
// Description: Ethernet MAC group
// File: lib/verilog/core/io_queues/ethernet_queue/xml/ethernet_mac.xml
#define MAC_GRP_3_CONTROL_REG                          0x06c0000
#define MAC_GRP_3_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x06c0004
#define MAC_GRP_3_RX_QUEUE_NUM_PKTS_STORED_REG         0x06c0008
#define MAC_GRP_3_RX_QUEUE_NUM_PKTS_DROPPED_FULL_REG   0x06c000c
#define MAC_GRP_3_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG    0x06c0010
#define MAC_GRP_3_RX_QUEUE_NUM_PKTS_DEQUEUED_REG       0x06c0014
#define MAC_GRP_3_RX_QUEUE_NUM_WORDS_PUSHED_REG        0x06c0018
#define MAC_GRP_3_RX_QUEUE_NUM_BYTES_PUSHED_REG        0x06c001c
#define MAC_GRP_3_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG       0x06c0020
#define MAC_GRP_3_TX_QUEUE_NUM_PKTS_ENQUEUED_REG       0x06c0024
#define MAC_GRP_3_TX_QUEUE_NUM_PKTS_SENT_REG           0x06c0028
#define MAC_GRP_3_TX_QUEUE_NUM_WORDS_PUSHED_REG        0x06c002c
#define MAC_GRP_3_TX_QUEUE_NUM_BYTES_PUSHED_REG        0x06c0030

// Name: cpu_dma_queue (CPU_QUEUE_0)
// Description: CPU DMA queue
// File: lib/verilog/core/io_queues/cpu_dma_queue/xml/cpu_dma_queue.xml
#define CPU_QUEUE_0_CONTROL_REG                         0x0700000
#define CPU_QUEUE_0_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x0700004
#define CPU_QUEUE_0_RX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x0700008
#define CPU_QUEUE_0_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG   0x070000c
#define CPU_QUEUE_0_RX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x0700010
#define CPU_QUEUE_0_RX_QUEUE_NUM_UNDERRUNS_REG          0x0700014
#define CPU_QUEUE_0_RX_QUEUE_NUM_OVERRUNS_REG           0x0700018
#define CPU_QUEUE_0_RX_QUEUE_NUM_WORDS_PUSHED_REG       0x070001c
#define CPU_QUEUE_0_RX_QUEUE_NUM_BYTES_PUSHED_REG       0x0700020
#define CPU_QUEUE_0_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x0700024
#define CPU_QUEUE_0_TX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x0700028
#define CPU_QUEUE_0_TX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x070002c
#define CPU_QUEUE_0_TX_QUEUE_NUM_UNDERRUNS_REG          0x0700030
#define CPU_QUEUE_0_TX_QUEUE_NUM_OVERRUNS_REG           0x0700034
#define CPU_QUEUE_0_TX_QUEUE_NUM_WORDS_PUSHED_REG       0x0700038
#define CPU_QUEUE_0_TX_QUEUE_NUM_BYTES_PUSHED_REG       0x070003c

// Name: cpu_dma_queue (CPU_QUEUE_1)
// Description: CPU DMA queue
// File: lib/verilog/core/io_queues/cpu_dma_queue/xml/cpu_dma_queue.xml
#define CPU_QUEUE_1_CONTROL_REG                         0x0740000
#define CPU_QUEUE_1_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x0740004
#define CPU_QUEUE_1_RX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x0740008
#define CPU_QUEUE_1_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG   0x074000c
#define CPU_QUEUE_1_RX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x0740010
#define CPU_QUEUE_1_RX_QUEUE_NUM_UNDERRUNS_REG          0x0740014
#define CPU_QUEUE_1_RX_QUEUE_NUM_OVERRUNS_REG           0x0740018
#define CPU_QUEUE_1_RX_QUEUE_NUM_WORDS_PUSHED_REG       0x074001c
#define CPU_QUEUE_1_RX_QUEUE_NUM_BYTES_PUSHED_REG       0x0740020
#define CPU_QUEUE_1_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x0740024
#define CPU_QUEUE_1_TX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x0740028
#define CPU_QUEUE_1_TX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x074002c
#define CPU_QUEUE_1_TX_QUEUE_NUM_UNDERRUNS_REG          0x0740030
#define CPU_QUEUE_1_TX_QUEUE_NUM_OVERRUNS_REG           0x0740034
#define CPU_QUEUE_1_TX_QUEUE_NUM_WORDS_PUSHED_REG       0x0740038
#define CPU_QUEUE_1_TX_QUEUE_NUM_BYTES_PUSHED_REG       0x074003c

// Name: cpu_dma_queue (CPU_QUEUE_2)
// Description: CPU DMA queue
// File: lib/verilog/core/io_queues/cpu_dma_queue/xml/cpu_dma_queue.xml
#define CPU_QUEUE_2_CONTROL_REG                         0x0780000
#define CPU_QUEUE_2_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x0780004
#define CPU_QUEUE_2_RX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x0780008
#define CPU_QUEUE_2_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG   0x078000c
#define CPU_QUEUE_2_RX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x0780010
#define CPU_QUEUE_2_RX_QUEUE_NUM_UNDERRUNS_REG          0x0780014
#define CPU_QUEUE_2_RX_QUEUE_NUM_OVERRUNS_REG           0x0780018
#define CPU_QUEUE_2_RX_QUEUE_NUM_WORDS_PUSHED_REG       0x078001c
#define CPU_QUEUE_2_RX_QUEUE_NUM_BYTES_PUSHED_REG       0x0780020
#define CPU_QUEUE_2_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x0780024
#define CPU_QUEUE_2_TX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x0780028
#define CPU_QUEUE_2_TX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x078002c
#define CPU_QUEUE_2_TX_QUEUE_NUM_UNDERRUNS_REG          0x0780030
#define CPU_QUEUE_2_TX_QUEUE_NUM_OVERRUNS_REG           0x0780034
#define CPU_QUEUE_2_TX_QUEUE_NUM_WORDS_PUSHED_REG       0x0780038
#define CPU_QUEUE_2_TX_QUEUE_NUM_BYTES_PUSHED_REG       0x078003c

// Name: cpu_dma_queue (CPU_QUEUE_3)
// Description: CPU DMA queue
// File: lib/verilog/core/io_queues/cpu_dma_queue/xml/cpu_dma_queue.xml
#define CPU_QUEUE_3_CONTROL_REG                         0x07c0000
#define CPU_QUEUE_3_RX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x07c0004
#define CPU_QUEUE_3_RX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x07c0008
#define CPU_QUEUE_3_RX_QUEUE_NUM_PKTS_DROPPED_BAD_REG   0x07c000c
#define CPU_QUEUE_3_RX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x07c0010
#define CPU_QUEUE_3_RX_QUEUE_NUM_UNDERRUNS_REG          0x07c0014
#define CPU_QUEUE_3_RX_QUEUE_NUM_OVERRUNS_REG           0x07c0018
#define CPU_QUEUE_3_RX_QUEUE_NUM_WORDS_PUSHED_REG       0x07c001c
#define CPU_QUEUE_3_RX_QUEUE_NUM_BYTES_PUSHED_REG       0x07c0020
#define CPU_QUEUE_3_TX_QUEUE_NUM_PKTS_IN_QUEUE_REG      0x07c0024
#define CPU_QUEUE_3_TX_QUEUE_NUM_PKTS_ENQUEUED_REG      0x07c0028
#define CPU_QUEUE_3_TX_QUEUE_NUM_PKTS_DEQUEUED_REG      0x07c002c
#define CPU_QUEUE_3_TX_QUEUE_NUM_UNDERRUNS_REG          0x07c0030
#define CPU_QUEUE_3_TX_QUEUE_NUM_OVERRUNS_REG           0x07c0034
#define CPU_QUEUE_3_TX_QUEUE_NUM_WORDS_PUSHED_REG       0x07c0038
#define CPU_QUEUE_3_TX_QUEUE_NUM_BYTES_PUSHED_REG       0x07c003c

// Name: SRAM (SRAM)
// Description: SRAM

// Name: _port (PORT_0)
// Description: Registers for IIP system port
// File: lib/verilog/contrib/iip/_port/xml/_port.xml
#define PORT_0_LOCAL_MAC_HI_REG         0x2000000
#define PORT_0_LOCAL_MAC_LO_REG         0x2000004
#define PORT_0_OTHER_MAC_HI_REG         0x2000008
#define PORT_0_OTHER_MAC_LO_REG         0x200000c
#define PORT_0_ETHER_TYPE_REG           0x2000010
#define PORT_0_NUM_FRAMES_GOOD_REG      0x2000014
#define PORT_0_NUM_FRAMES_BAD_REG       0x2000018
#define PORT_0_PIH_QOS_REG              0x200001c
#define PORT_0_PIH_CAN_REG              0x2000020
#define PORT_0_PIH_DSS_REG              0x2000024
#define PORT_0_PIH_MGT_REG              0x2000028
#define PORT_0_NUM_PHASES_REG           0x200002c
#define PORT_0_PH_0_LENGTH_REG          0x2000030
#define PORT_0_PH_1_LENGTH_REG          0x2000034
#define PORT_0_PH_2_LENGTH_REG          0x2000038
#define PORT_0_PH_3_LENGTH_REG          0x200003c
#define PORT_0_PH_4_LENGTH_REG          0x2000040
#define PORT_0_PH_5_LENGTH_REG          0x2000044
#define PORT_0_PH_6_LENGTH_REG          0x2000048
#define PORT_0_PH_7_LENGTH_REG          0x200004c
#define PORT_0_PH_0_TYPE_REG            0x2000050
#define PORT_0_PH_1_TYPE_REG            0x2000054
#define PORT_0_PH_2_TYPE_REG            0x2000058
#define PORT_0_PH_3_TYPE_REG            0x200005c
#define PORT_0_PH_4_TYPE_REG            0x2000060
#define PORT_0_PH_5_TYPE_REG            0x2000064
#define PORT_0_PH_6_TYPE_REG            0x2000068
#define PORT_0_PH_7_TYPE_REG            0x200006c
#define PORT_0_PH_8_TYPE_REG            0x2000070
#define PORT_0_FAME_OVERHAED_REG        0x2000074
#define PORT_0_MINIMAL_FRAME_SIZE_REG   0x2000078

// Name: _port (PORT_1)
// Description: Registers for IIP system port
// File: lib/verilog/contrib/iip/_port/xml/_port.xml
#define PORT_1_LOCAL_MAC_HI_REG         0x2000100
#define PORT_1_LOCAL_MAC_LO_REG         0x2000104
#define PORT_1_OTHER_MAC_HI_REG         0x2000108
#define PORT_1_OTHER_MAC_LO_REG         0x200010c
#define PORT_1_ETHER_TYPE_REG           0x2000110
#define PORT_1_NUM_FRAMES_GOOD_REG      0x2000114
#define PORT_1_NUM_FRAMES_BAD_REG       0x2000118
#define PORT_1_PIH_QOS_REG              0x200011c
#define PORT_1_PIH_CAN_REG              0x2000120
#define PORT_1_PIH_DSS_REG              0x2000124
#define PORT_1_PIH_MGT_REG              0x2000128
#define PORT_1_NUM_PHASES_REG           0x200012c
#define PORT_1_PH_0_LENGTH_REG          0x2000130
#define PORT_1_PH_1_LENGTH_REG          0x2000134
#define PORT_1_PH_2_LENGTH_REG          0x2000138
#define PORT_1_PH_3_LENGTH_REG          0x200013c
#define PORT_1_PH_4_LENGTH_REG          0x2000140
#define PORT_1_PH_5_LENGTH_REG          0x2000144
#define PORT_1_PH_6_LENGTH_REG          0x2000148
#define PORT_1_PH_7_LENGTH_REG          0x200014c
#define PORT_1_PH_0_TYPE_REG            0x2000150
#define PORT_1_PH_1_TYPE_REG            0x2000154
#define PORT_1_PH_2_TYPE_REG            0x2000158
#define PORT_1_PH_3_TYPE_REG            0x200015c
#define PORT_1_PH_4_TYPE_REG            0x2000160
#define PORT_1_PH_5_TYPE_REG            0x2000164
#define PORT_1_PH_6_TYPE_REG            0x2000168
#define PORT_1_PH_7_TYPE_REG            0x200016c
#define PORT_1_PH_8_TYPE_REG            0x2000170
#define PORT_1_FAME_OVERHAED_REG        0x2000174
#define PORT_1_MINIMAL_FRAME_SIZE_REG   0x2000178

// Name: _port (PORT_2)
// Description: Registers for IIP system port
// File: lib/verilog/contrib/iip/_port/xml/_port.xml
#define PORT_2_LOCAL_MAC_HI_REG         0x2000200
#define PORT_2_LOCAL_MAC_LO_REG         0x2000204
#define PORT_2_OTHER_MAC_HI_REG         0x2000208
#define PORT_2_OTHER_MAC_LO_REG         0x200020c
#define PORT_2_ETHER_TYPE_REG           0x2000210
#define PORT_2_NUM_FRAMES_GOOD_REG      0x2000214
#define PORT_2_NUM_FRAMES_BAD_REG       0x2000218
#define PORT_2_PIH_QOS_REG              0x200021c
#define PORT_2_PIH_CAN_REG              0x2000220
#define PORT_2_PIH_DSS_REG              0x2000224
#define PORT_2_PIH_MGT_REG              0x2000228
#define PORT_2_NUM_PHASES_REG           0x200022c
#define PORT_2_PH_0_LENGTH_REG          0x2000230
#define PORT_2_PH_1_LENGTH_REG          0x2000234
#define PORT_2_PH_2_LENGTH_REG          0x2000238
#define PORT_2_PH_3_LENGTH_REG          0x200023c
#define PORT_2_PH_4_LENGTH_REG          0x2000240
#define PORT_2_PH_5_LENGTH_REG          0x2000244
#define PORT_2_PH_6_LENGTH_REG          0x2000248
#define PORT_2_PH_7_LENGTH_REG          0x200024c
#define PORT_2_PH_0_TYPE_REG            0x2000250
#define PORT_2_PH_1_TYPE_REG            0x2000254
#define PORT_2_PH_2_TYPE_REG            0x2000258
#define PORT_2_PH_3_TYPE_REG            0x200025c
#define PORT_2_PH_4_TYPE_REG            0x2000260
#define PORT_2_PH_5_TYPE_REG            0x2000264
#define PORT_2_PH_6_TYPE_REG            0x2000268
#define PORT_2_PH_7_TYPE_REG            0x200026c
#define PORT_2_PH_8_TYPE_REG            0x2000270
#define PORT_2_FAME_OVERHAED_REG        0x2000274
#define PORT_2_MINIMAL_FRAME_SIZE_REG   0x2000278

// Name: _port (PORT_3)
// Description: Registers for IIP system port
// File: lib/verilog/contrib/iip/_port/xml/_port.xml
#define PORT_3_LOCAL_MAC_HI_REG         0x2000300
#define PORT_3_LOCAL_MAC_LO_REG         0x2000304
#define PORT_3_OTHER_MAC_HI_REG         0x2000308
#define PORT_3_OTHER_MAC_LO_REG         0x200030c
#define PORT_3_ETHER_TYPE_REG           0x2000310
#define PORT_3_NUM_FRAMES_GOOD_REG      0x2000314
#define PORT_3_NUM_FRAMES_BAD_REG       0x2000318
#define PORT_3_PIH_QOS_REG              0x200031c
#define PORT_3_PIH_CAN_REG              0x2000320
#define PORT_3_PIH_DSS_REG              0x2000324
#define PORT_3_PIH_MGT_REG              0x2000328
#define PORT_3_NUM_PHASES_REG           0x200032c
#define PORT_3_PH_0_LENGTH_REG          0x2000330
#define PORT_3_PH_1_LENGTH_REG          0x2000334
#define PORT_3_PH_2_LENGTH_REG          0x2000338
#define PORT_3_PH_3_LENGTH_REG          0x200033c
#define PORT_3_PH_4_LENGTH_REG          0x2000340
#define PORT_3_PH_5_LENGTH_REG          0x2000344
#define PORT_3_PH_6_LENGTH_REG          0x2000348
#define PORT_3_PH_7_LENGTH_REG          0x200034c
#define PORT_3_PH_0_TYPE_REG            0x2000350
#define PORT_3_PH_1_TYPE_REG            0x2000354
#define PORT_3_PH_2_TYPE_REG            0x2000358
#define PORT_3_PH_3_TYPE_REG            0x200035c
#define PORT_3_PH_4_TYPE_REG            0x2000360
#define PORT_3_PH_5_TYPE_REG            0x2000364
#define PORT_3_PH_6_TYPE_REG            0x2000368
#define PORT_3_PH_7_TYPE_REG            0x200036c
#define PORT_3_PH_8_TYPE_REG            0x2000370
#define PORT_3_FAME_OVERHAED_REG        0x2000374
#define PORT_3_MINIMAL_FRAME_SIZE_REG   0x2000378

// Name: pirouter (PIROUTER)
// Description: Registers for example pi router
// File: lib/verilog/contrib/iip/pi_router/xml/pi_router.xml
#define PIROUTER_REGISTER_ONE_REG     0x2000400
#define PIROUTER_REGISTER_TWO_REG     0x2000404
#define PIROUTER_REGISTER_THREE_REG   0x2000408
#define PIROUTER_REGISTER_FOUR_REG    0x200040c
#define PIROUTER_REGISTER_FIVE_REG    0x2000410

// Name: dt_queues (DT_QUEUES_0)
// Description: Registers for drop tail queues
// File: lib/verilog/contrib/iip/drop_tail_fifo/xml/dt_queues.xml
#define DT_QUEUES_0_QUEUE_0_MAX_NUM_PKTS_REG   0x2000480
#define DT_QUEUES_0_QUEUE_1_MAX_NUM_PKTS_REG   0x2000484
#define DT_QUEUES_0_QUEUE_2_MAX_NUM_PKTS_REG   0x2000488
#define DT_QUEUES_0_QUEUE_3_MAX_NUM_PKTS_REG   0x200048c
#define DT_QUEUES_0_QUEUE_4_MAX_NUM_PKTS_REG   0x2000490
#define DT_QUEUES_0_QUEUE_5_MAX_NUM_PKTS_REG   0x2000494

// Name: dt_queues (DT_QUEUES_1)
// Description: Registers for drop tail queues
// File: lib/verilog/contrib/iip/drop_tail_fifo/xml/dt_queues.xml
#define DT_QUEUES_1_QUEUE_0_MAX_NUM_PKTS_REG   0x2000500
#define DT_QUEUES_1_QUEUE_1_MAX_NUM_PKTS_REG   0x2000504
#define DT_QUEUES_1_QUEUE_2_MAX_NUM_PKTS_REG   0x2000508
#define DT_QUEUES_1_QUEUE_3_MAX_NUM_PKTS_REG   0x200050c
#define DT_QUEUES_1_QUEUE_4_MAX_NUM_PKTS_REG   0x2000510
#define DT_QUEUES_1_QUEUE_5_MAX_NUM_PKTS_REG   0x2000514

// Name: dt_queues (DT_QUEUES_2)
// Description: Registers for drop tail queues
// File: lib/verilog/contrib/iip/drop_tail_fifo/xml/dt_queues.xml
#define DT_QUEUES_2_QUEUE_0_MAX_NUM_PKTS_REG   0x2000580
#define DT_QUEUES_2_QUEUE_1_MAX_NUM_PKTS_REG   0x2000584
#define DT_QUEUES_2_QUEUE_2_MAX_NUM_PKTS_REG   0x2000588
#define DT_QUEUES_2_QUEUE_3_MAX_NUM_PKTS_REG   0x200058c
#define DT_QUEUES_2_QUEUE_4_MAX_NUM_PKTS_REG   0x2000590
#define DT_QUEUES_2_QUEUE_5_MAX_NUM_PKTS_REG   0x2000594

// Name: dt_queues (DT_QUEUES_3)
// Description: Registers for drop tail queues
// File: lib/verilog/contrib/iip/drop_tail_fifo/xml/dt_queues.xml
#define DT_QUEUES_3_QUEUE_0_MAX_NUM_PKTS_REG   0x2000600
#define DT_QUEUES_3_QUEUE_1_MAX_NUM_PKTS_REG   0x2000604
#define DT_QUEUES_3_QUEUE_2_MAX_NUM_PKTS_REG   0x2000608
#define DT_QUEUES_3_QUEUE_3_MAX_NUM_PKTS_REG   0x200060c
#define DT_QUEUES_3_QUEUE_4_MAX_NUM_PKTS_REG   0x2000610
#define DT_QUEUES_3_QUEUE_5_MAX_NUM_PKTS_REG   0x2000614

// Name: DRAM (DRAM)
// Description: DRAM



/* ========== Bitmasks ========== */

// Type: dma_iface_ctrl
// Description: DMA interface control register
// File: lib/verilog/core/dma/xml/dma.xml

// Part 1: bit positions
#define DMA_IFACE_CTRL_DISABLE_POS   0
#define DMA_IFACE_CTRL_RESET_POS     1

// Part 2: masks/values
#define DMA_IFACE_CTRL_DISABLE       0x001
#define DMA_IFACE_CTRL_RESET         0x002

// Type: mii_ctrl
// Description: MII control register
// File: lib/verilog/core/io/mdio/xml/mdio.xml

// Part 1: bit positions
#define MII_CTRL_RESET_POS               15
#define MII_CTRL_INTERNAL_LOOPBACK_POS   14
#define MII_CTRL_SPEED_SEL_LO_POS        13
#define MII_CTRL_AUTONEG_ENABLE_POS      12
#define MII_CTRL_PWR_DOWN_POS            11
#define MII_CTRL_ISOLATE_POS             10
#define MII_CTRL_RESTART_AUTONEG_POS     9
#define MII_CTRL_DUPLEX_MODE_POS         8
#define MII_CTRL_COLLISION_TEST_EN_POS   7
#define MII_CTRL_SPEED_SEL_HI_POS        6

// Part 2: masks/values
#define MII_CTRL_RESET                   0x8000
#define MII_CTRL_INTERNAL_LOOPBACK       0x4000
#define MII_CTRL_SPEED_SEL_LO            0x2000
#define MII_CTRL_AUTONEG_ENABLE          0x1000
#define MII_CTRL_PWR_DOWN                0x0800
#define MII_CTRL_ISOLATE                 0x0400
#define MII_CTRL_RESTART_AUTONEG         0x0200
#define MII_CTRL_DUPLEX_MODE             0x0100
#define MII_CTRL_COLLISION_TEST_EN       0x0080
#define MII_CTRL_SPEED_SEL_HI            0x0040

// Type: mii_status
// Description: MII status register
// File: lib/verilog/core/io/mdio/xml/mdio.xml

// Part 1: bit positions
#define MII_STATUS_100BASE_T4_CAPABLE_POS            15
#define MII_STATUS_100BASE_X_FULL_DPLX_CAPABLE_POS   14
#define MII_STATUS_100BASE_X_HALF_DPLX_CAPABLE_POS   13
#define MII_STATUS_10BASE_T_FULL_DPLX_CAPABLE_POS    12
#define MII_STATUS_10BASE_T_HALF_DPLX_CAPABLE_POS    11
#define MII_STATUS_10BASE_T2_FULL_DPLX_CAPABLE_POS   10
#define MII_STATUS_10BASE_T2_HALF_DPLX_CAPABLE_POS   9
#define MII_STATUS_EXTENDED_STATUS_POS               8
#define MII_STATUS_MF_PREAMBLE_SUPPRESS_POS          6
#define MII_STATUS_AUTONEG_COMPLETE_POS              5
#define MII_STATUS_REMOTE_FAULT_POS                  4
#define MII_STATUS_AUTONEG_ABILITY_POS               3
#define MII_STATUS_LINK_STATUS_POS                   2
#define MII_STATUS_JABBER_DETECT_POS                 1
#define MII_STATUS_EXTENDED_CAPABILITY_POS           0

// Part 2: masks/values
#define MII_STATUS_100BASE_T4_CAPABLE                0x8000
#define MII_STATUS_100BASE_X_FULL_DPLX_CAPABLE       0x4000
#define MII_STATUS_100BASE_X_HALF_DPLX_CAPABLE       0x2000
#define MII_STATUS_10BASE_T_FULL_DPLX_CAPABLE        0x1000
#define MII_STATUS_10BASE_T_HALF_DPLX_CAPABLE        0x0800
#define MII_STATUS_10BASE_T2_FULL_DPLX_CAPABLE       0x0400
#define MII_STATUS_10BASE_T2_HALF_DPLX_CAPABLE       0x0200
#define MII_STATUS_EXTENDED_STATUS                   0x0100
#define MII_STATUS_MF_PREAMBLE_SUPPRESS              0x0040
#define MII_STATUS_AUTONEG_COMPLETE                  0x0020
#define MII_STATUS_REMOTE_FAULT                      0x0010
#define MII_STATUS_AUTONEG_ABILITY                   0x0008
#define MII_STATUS_LINK_STATUS                       0x0004
#define MII_STATUS_JABBER_DETECT                     0x0002
#define MII_STATUS_EXTENDED_CAPABILITY               0x0001

// Type: cpu_queue_control
// Description: DMA queue control register
// File: lib/verilog/core/io_queues/cpu_dma_queue/xml/cpu_dma_queue.xml

// Part 1: bit positions
#define CPU_QUEUE_CONTROL_TX_QUEUE_DISABLE_POS   0
#define CPU_QUEUE_CONTROL_RX_QUEUE_DISABLE_POS   1

// Part 2: masks/values
#define CPU_QUEUE_CONTROL_TX_QUEUE_DISABLE       0x001
#define CPU_QUEUE_CONTROL_RX_QUEUE_DISABLE       0x002

// Type: mac_grp_control
// Description: MAC group control register
// File: lib/verilog/core/io_queues/ethernet_queue/xml/ethernet_mac.xml

// Part 1: bit positions
#define MAC_GRP_CONTROL_TX_QUEUE_DISABLE_POS        0
#define MAC_GRP_CONTROL_RX_QUEUE_DISABLE_POS        1
#define MAC_GRP_CONTROL_RESET_MAC_POS               2
#define MAC_GRP_CONTROL_MAC_DISABLE_TX_POS          3
#define MAC_GRP_CONTROL_MAC_DISABLE_RX_POS          4
#define MAC_GRP_CONTROL_MAC_DISABLE_JUMBO_TX_POS    5
#define MAC_GRP_CONTROL_MAC_DISABLE_JUMBO_RX_POS    6
#define MAC_GRP_CONTROL_MAC_DISABLE_CRC_CHECK_POS   7
#define MAC_GRP_CONTROL_MAC_DISABLE_CRC_GEN_POS     8

// Part 2: masks/values
#define MAC_GRP_CONTROL_TX_QUEUE_DISABLE            0x001
#define MAC_GRP_CONTROL_RX_QUEUE_DISABLE            0x002
#define MAC_GRP_CONTROL_RESET_MAC                   0x004
#define MAC_GRP_CONTROL_MAC_DISABLE_TX              0x008
#define MAC_GRP_CONTROL_MAC_DISABLE_RX              0x010
#define MAC_GRP_CONTROL_MAC_DISABLE_JUMBO_TX        0x020
#define MAC_GRP_CONTROL_MAC_DISABLE_JUMBO_RX        0x040
#define MAC_GRP_CONTROL_MAC_DISABLE_CRC_CHECK       0x080
#define MAC_GRP_CONTROL_MAC_DISABLE_CRC_GEN         0x100




#endif

