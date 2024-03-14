
    // sodor_tb.v

// `define DESIGN_REGS_RANDOMIZE

    module ibex_tb();
        parameter CLK_CYCLE_TIME = 10;
        parameter IMEM_INTERVAL = 80;
        parameter SIM_CYCLE = 100; // 100000000;
        parameter SIM_TIME = SIM_CYCLE * CLK_CYCLE_TIME * 2;

        reg [31:0] 			CLK_CYCLE;
        reg 				clk;
        reg 				reset;
        wire [31:0]         instr_data;
        reg [2:0]           instr_addr;
        reg                 instr_valid;
        
        initial begin
            clk = 1;
            forever #CLK_CYCLE_TIME clk = ~clk;
        end

        initial begin
            reset = 0;
            // #IMEM_INTERVAL reset = 1;
            #IMEM_INTERVAL reset = 1;
        end
        
        initial begin
            CLK_CYCLE = 32'h0;
        end
        
        always @(posedge clk) begin
            CLK_CYCLE <= CLK_CYCLE + 1;
        end
        

        initial begin
            $dumpfile("ibex_wave_pipeline.vcd");
            $dumpvars(0, ibex_tb);
        end

        
        initial begin
            #IMEM_INTERVAL;
            #SIM_TIME;
            $finish;
        end
        
        always @(posedge clk) begin
            instr_valid <= port_instr_req_o;
            instr_addr <= port_instr_req_o ? (instr_addr + 1) : instr_addr;
        end

    // Program array
wire [31:0] program_array [0:7];

assign program_array[0] = 32'h00000013; // nop : 00000013
assign program_array[1] = 32'h00000013; // nop : 00000013
assign program_array[2] = 32'h00000013; // nop : 00000013
assign program_array[3] = 32'h00000013; // nop : 00000013
assign program_array[4] = 32'h00000013; // nop : 00000013
assign program_array[5] = 32'h00000013; // nop : 00000013
assign program_array[6] = 32'h00000013; // nop : 00000013
assign program_array[7] = 32'h3B169073; // csrw : pmp0


    // Forcing values
    

    assign instr_data = program_array[instr_addr];
            // (!CLK_CYCLE[0]) ? 32'h04002283 : 
            // (CLK_CYCLE < 4'd5) ? 32'h00200313 : 32'h;

	wire port_clk_i;
    assign port_clk_i = clk;
	wire port_rst_ni;
    assign port_rst_ni = reset;
	
    wire port_test_en_i; // 0
    assign port_test_en_i = 0;
	wire [9:0] port_ram_cfg_i; // 0
    assign port_ram_cfg_i = 0;
	wire [31:0] port_hart_id_i; // 0
    assign port_hart_id_i = 0;
	wire [31:0] port_boot_addr_i; // 0
    assign port_boot_addr_i = 0;

	wire port_instr_req_o;
	assign port_instr_gnt_i = instr_req_o;
	wire port_instr_rvalid_i;
    assign port_instr_rvalid_i = instr_valid;
	wire [31:0] port_instr_addr_o;
	wire [31:0] port_instr_rdata_i;
    assign port_instr_rdata_i = instr_data;
    // Integrity checker
    wire [6:0] port_instr_rdata_intg_i;
    assign port_instr_rdata_intg_i = 0;
	wire port_instr_err_i;
    assign port_instr_err_i = 0;
	
    wire port_data_req_o;
    wire port_data_gnt_i;
    assign port_data_gnt_i = 0;
	wire port_data_rvalid_i;
    assign port_data_rvalid_i = 0;
	wire port_data_we_o;
	wire [3:0] port_data_be_o;
	wire [31:0] port_data_addr_o;
	wire [31:0] port_data_wdata_o;
	wire [6:0] port_data_wdata_intg_o;
    wire [31:0] port_data_rdata_i;
    assign port_data_rdata_i = 0;
	wire [6:0] port_data_rdata_intg_i;
    assign port_data_rdata_intg_i = 0;
	wire port_data_err_i;
    assign port_data_err_i = 0;
	
    wire port_irq_software_i;
    assign port_irq_software_i = 0;
	wire port_irq_timer_i;
    assign port_irq_timer_i = 0;
	wire port_irq_external_i;
    assign port_irq_external_i = 0;
	wire [14:0] port_irq_fast_i;
    assign port_irq_fast_i = 0;
	wire port_irq_nm_i;
    assign port_irq_nm_i = 0;
	wire port_scramble_key_valid_i;
    assign port_scramble_key_valid_i = 0;
	wire [127:0] port_scramble_key_i;
    assign port_scramble_key_i = 0;
	wire [63:0] port_scramble_nonce_i;
    assign port_scramble_nonce_i = 0;
	wire port_scramble_req_o;
	wire port_debug_req_i;
    assign port_debug_req_i = 0;
	wire [159:0] port_crash_dump_o;
	wire port_double_fault_seen_o;
	wire port_rvfi_valid;
	wire [63:0] port_rvfi_order;
	wire [31:0] port_rvfi_insn;
	wire port_rvfi_trap;
	wire port_rvfi_halt;
	wire port_rvfi_intr;
	wire [1:0] port_rvfi_mode;
	wire [1:0] port_rvfi_ixl;
	wire [4:0] port_rvfi_rs1_addr;
	wire [4:0] port_rvfi_rs2_addr;
	wire [4:0] port_rvfi_rs3_addr;
	wire [31:0] port_rvfi_rs1_rdata;
	wire [31:0] port_rvfi_rs2_rdata;
	wire [31:0] port_rvfi_rs3_rdata;
	wire [4:0] port_rvfi_rd_addr;
	wire [31:0] port_rvfi_rd_wdata;
	wire [31:0] port_rvfi_pc_rdata;
	wire [31:0] port_rvfi_pc_wdata;
	wire [31:0] port_rvfi_mem_addr;
	wire [3:0] port_rvfi_mem_rmask;
	wire [3:0] port_rvfi_mem_wmask;
	wire [31:0] port_rvfi_mem_rdata;
	wire [31:0] port_rvfi_mem_wdata;
	wire [31:0] port_rvfi_ext_mip;
	wire port_rvfi_ext_nmi;
	wire port_rvfi_ext_debug_req;
	wire [63:0] port_rvfi_ext_mcycle;
	wire [319:0] port_rvfi_ext_mhpmcounters;
	wire [319:0] port_rvfi_ext_mhpmcountersh;
	wire port_rvfi_ext_ic_scr_key_valid;
    wire [3:0] port_fetch_enable_i;
    assign port_fetch_enable_i = 5;
	wire port_alert_minor_o;
	wire port_alert_major_internal_o;
	wire port_alert_major_bus_o;
	wire port_core_sleep_o;
	wire port_scan_rst_ni;
    assign port_scan_rst_ni = 1;

        ibex_top itop (
            .clk_i(port_clk_i),
            .rst_ni(port_rst_ni),
            .test_en_i(port_test_en_i),
            .ram_cfg_i(port_ram_cfg_i),
            .hart_id_i(port_hart_id_i),
            .boot_addr_i(port_boot_addr_i),
            .instr_req_o(port_instr_req_o),
            .instr_gnt_i(port_instr_gnt_i),
            .instr_rvalid_i(port_instr_rvalid_i),
            .instr_addr_o(port_instr_addr_o),
            .instr_rdata_i(port_instr_rdata_i),
            .instr_rdata_intg_i(port_instr_rdata_intg_i),
            .instr_err_i(port_instr_err_i),
            .data_req_o(port_data_req_o),
            .data_gnt_i(port_data_gnt_i),
            .data_rvalid_i(port_data_rvalid_i),
            .data_we_o(port_data_we_o),
            .data_be_o(port_data_be_o),
            .data_addr_o(port_data_addr_o),
            .data_wdata_o(port_data_wdata_o),
            .data_wdata_intg_o(port_data_wdata_intg_o),
            .data_rdata_i(port_data_rdata_i),
            .data_rdata_intg_i(port_data_rdata_intg_i),
            .data_err_i(port_data_err_i),
            .irq_software_i(port_irq_software_i),
            .irq_timer_i(port_irq_timer_i),
            .irq_external_i(port_irq_external_i),
            .irq_fast_i(port_irq_fast_i),
            .irq_nm_i(port_irq_nm_i),
            .scramble_key_valid_i(port_scramble_key_valid_i),
            .scramble_key_i(port_scramble_key_i),
            .scramble_nonce_i(port_scramble_nonce_i),
            .scramble_req_o(port_scramble_req_o),
            .debug_req_i(port_debug_req_i),
            .crash_dump_o(port_crash_dump_o),
            .double_fault_seen_o(port_double_fault_seen_o),
            .rvfi_valid(port_rvfi_valid),
            .rvfi_order(port_rvfi_order),
            .rvfi_insn(port_rvfi_insn),
            .rvfi_trap(port_rvfi_trap),
            .rvfi_halt(port_rvfi_halt),
            .rvfi_intr(port_rvfi_intr),
            .rvfi_mode(port_rvfi_mode),
            .rvfi_ixl(port_rvfi_ixl),
            .rvfi_rs1_addr(port_rvfi_rs1_addr),
            .rvfi_rs2_addr(port_rvfi_rs2_addr),
            .rvfi_rs3_addr(port_rvfi_rs3_addr),
            .rvfi_rs1_rdata(port_rvfi_rs1_rdata),
            .rvfi_rs2_rdata(port_rvfi_rs2_rdata),
            .rvfi_rs3_rdata(port_rvfi_rs3_rdata),
            .rvfi_rd_addr(port_rvfi_rd_addr),
            .rvfi_rd_wdata(port_rvfi_rd_wdata),
            .rvfi_pc_rdata(port_rvfi_pc_rdata),
            .rvfi_pc_wdata(port_rvfi_pc_wdata),
            .rvfi_mem_addr(port_rvfi_mem_addr),
            .rvfi_mem_rmask(port_rvfi_mem_rmask),
            .rvfi_mem_wmask(port_rvfi_mem_wmask),
            .rvfi_mem_rdata(port_rvfi_mem_rdata),
            .rvfi_mem_wdata(port_rvfi_mem_wdata),
            .rvfi_ext_mip(port_rvfi_ext_mip),
            .rvfi_ext_nmi(port_rvfi_ext_nmi),
            .rvfi_ext_debug_req(port_rvfi_ext_debug_req),
            .rvfi_ext_mcycle(port_rvfi_ext_mcycle),
            .rvfi_ext_mhpmcounters(port_rvfi_ext_mhpmcounters),
            .rvfi_ext_mhpmcountersh(port_rvfi_ext_mhpmcountersh),
            .rvfi_ext_ic_scr_key_valid(port_rvfi_ext_ic_scr_key_valid),
            .fetch_enable_i(port_fetch_enable_i),
            .alert_minor_o(port_alert_minor_o),
            .alert_major_internal_o(port_alert_major_internal_o),
            .alert_major_bus_o(port_alert_major_bus_o),
            .core_sleep_o(port_core_sleep_o),
            .scan_rst_ni(port_scan_rst_ni)
        );
    endmodule
    