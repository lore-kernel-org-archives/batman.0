Return-Path: <tracer@robotech.de>
Message-ID: <4E67248D.8040904@robotech.de>
Date: Wed, 07 Sep 2011 10:00:13 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
	<201109051006.13844.lindner_marek@yahoo.de>
	<4E65E286.7080600@robotech.de>
	<201109062033.17427.lindner_marek@yahoo.de>
In-Reply-To: <201109062033.17427.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Am 06.09.2011 20:33, schrieb Marek Lindner:
>
> Can you tell us what TP-Link model you are using (name, hardware revision,
> etc). Or post the output of /proc/cpuinfo ?

Hi Marek,

the TP-Links are 1043:
root@1043-50:~# cat /proc/cpuinfo
system type             : Atheros AR9132 rev 2
machine                 : TP-LINK TL-WR1043ND
processor               : 0
cpu model               : MIPS 24Kc V7.4
BogoMIPS                : 265.42
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0000, 
0x0ff8, 0x0ff8, 0x0ff8]
ASEs implemented        : mips16
shadow register sets    : 1
kscratch registers      : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

and 841:
root@841-52:~# cat /proc/cpuinfo
system type             : Atheros AR7241 rev 1
machine                 : TP-LINK TL-WR741ND
processor               : 0
cpu model               : MIPS 24Kc V7.4
BogoMIPS                : 265.42
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 4, address/irw mask: [0x0000, 
0x08f8, 0x07c0, 0x0ba8]
ASEs implemented        : mips16
shadow register sets    : 1
kscratch registers      : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

the others are Fonera2100:
root@fon-53:~# cat /proc/cpuinfo
system type             : Atheros AR2315
processor               : 0
cpu model               : MIPS 4KEc V6.4
BogoMIPS                : 183.50
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : no
ASEs implemented        :
shadow register sets    : 1
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

Tobias

