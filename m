Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 13 Sep 2011 13:18:03 +0200
References: <4E5D69E3.30403@robotech.de>
	<201109062033.17427.lindner_marek@yahoo.de>
	<4E67248D.8040904@robotech.de>
In-Reply-To: <4E67248D.8040904@robotech.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109131318.03320.lindner_marek@yahoo.de>
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


Hi,

> the TP-Links are 1043:
> root@1043-50:~# cat /proc/cpuinfo
> system type             : Atheros AR9132 rev 2
> machine                 : TP-LINK TL-WR1043ND
> processor               : 0
> cpu model               : MIPS 24Kc V7.4
> BogoMIPS                : 265.42
> wait instruction        : yes
> microsecond timers      : yes
> tlb_entries             : 16
> extra interrupt vector  : yes
> hardware watchpoint     : yes, count: 4, address/irw mask: [0x0000,
> 0x0ff8, 0x0ff8, 0x0ff8]
> ASEs implemented        : mips16
> shadow register sets    : 1
> kscratch registers      : 0
> core                    : 0
> VCED exceptions         : not available
> VCEI exceptions         : not available

thanks for providing the info. So far, we can't spot the issue no matter how 
long we stare at the code. I'd like to make some patches that will spit out 
additional debug info to isolate the cause. As we can't reproduce the problem 
at our end we depend on you to test these patches. Will it be possible for you 
to have a mix of your nodes running in debug mode ?

Cheers,
Marek
