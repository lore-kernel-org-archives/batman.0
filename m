From: Carcellelist <carcellelist@free.fr>
Date: Tue, 5 May 2009 19:34:35 +0200
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
In-Reply-To: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905051935.03639.carcellelist@free.fr>
Subject: Re: [B.A.T.M.A.N.] batman-adv use in Manchester NH
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi Arc,

> What kind of traffic throughput is the kernel module capable of?  Does the
> module multithread properly for multicore utilization?  Would a FPGA
> variant be needed to have a "mesh switch" or would a high-end multicore ARM
> be reasonably able to handle say an 8-port gigabit mesh switch?

Concerning the multithreading of the batman daemon, if batman supports multi-
threads, you can distribute this on different cores definitely:

Concerning FPGA and the batman daemon (both userspace and kernelspace), it 
will depend on the FPGA you want to use (FPGAs from the two major vendors, 
Xilinx and Altera, are divided into two families based on the number of 
logical gates they have - huge Xilinx VIRTEX5 and coming 6 are even embarking 
one or event 2 PowerPCs next to the FPGA gates). Large FPGAs could embark part 
of the daemon in the CPU hardwired in the chip and the rest (for instance 
intensive functions like packet routing and filtering). Small FPGAs would run 
the daemon in the softcore (OpenRISC, Microblaze, aEMB) either "userspace" or 
"kernelspace" in the softcore or directly with the daemon in low level langage 
(VHDL or VERILOG) after porting the C code into this HDL langages. Core-
networking routers from CISCO, JUNIPER are loaded with FPGAs to process the 
packet filtering and routing the closest from the physical layer.

Concerning ARM and 8-port gigabit mesh switch, the power of even a coming 
multicore ARM13 would not be sufficient to run the packet routing and 
filtering for the 8xGigabits ports. ARM had been primarly developed for 
embedded devices and not for powerful applications such as switching and 
routing.

Xavier.
