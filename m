Return-Path: <hannes.harms@tu-bs.de>
From: "Harms, Hannes" <hannes.harms@tu-bs.de>
Message-ID: <5757ED74.2010109@tu-bs.de>
Date: Wed, 8 Jun 2016 12:03:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] How to compile BATMAN V against linux backports
	cfg80211
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


Hi,

I want to test the new batman V with throughput based metric, but I
could not find out how to compile batman-adv against cfg80211 from linux 
backports.

At the moment first I am compiling cfg80211 and ath10k from the 
backports tree.
After that I manually copy the created Modules.symvers from backports 
build dir to the batman-adv folder
and running make with  KBUILD_EXTRA_SYMBOLS, because otherwise I am 
getting a warning that the
cfg80211_get_station symbol is missing.

Then batman-adv compiles fine.
After loading the module I am getting an error with 
batadv_v_elp_throughput_metric_update :

[  150.332710] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
[  150.341079] pgd = 80004000
[  150.343900] [00000000] *pgd=00000000
[  150.347735] Internal error: Oops: 80000007 [#1] SMP ARM
[  150.347768] Modules linked in: batman_adv(O) bluetooth 6lowpan_iphc 
arc4 sky2 ath10k_pci(O) ath10k_core(O) ath(O) mac80211(O) ftdi_sio 
usbserial cfg80211(O) compat(O)
[  150.347779] CPU: 0 PID: 21 Comm: kworker/u4:1 Tainted: G           O 
3.14.48+yocto+g36eba1d #1
[  150.347836] Workqueue: bat_events 
batadv_v_elp_throughput_metric_update [batman_adv]
[  150.347841] task: 9c0c5f80 ti: 9c1e4000 task.ti: 9c1e4000
[  150.347848] PC is at 0x0
[  150.347851] LR is at 0x0
[  150.347857] pc : [<00000000>]    lr : [<00000000>] psr: 20070013
[  150.347857] sp : 9c1e5f08  ip : 0000001e  fp : 9c004400
[  150.347861] r10: 9c1e4008  r9 : 00000000  r8 : 9c004400
[  150.347865] r7 : 00000000  r6 : 9de20500  r5 : 00000002  r4 : 9c1bc980
[  150.347868] r3 : 96a0ee38  r2 : 00000001  r1 : 00000000  r0 : 96a0ee00
[  150.347874] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[  150.347878] Control: 10c53c7d  Table: 2697804a  DAC: 00000015
[  150.347882] Process kworker/u4:1 (pid: 21, stack limit = 0x9c1e4238)
[  150.347886] Stack: (0x9c1e5f08 to 0x9c1e6000)

Regards Hannes
