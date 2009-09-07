Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 7 Sep 2009 21:02:57 +0800
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909070147.05443.lindner_marek@yahoo.de>
	<4AA4DD8F.8000705@rsm-freilassing.de>
In-Reply-To: <4AA4DD8F.8000705@rsm-freilassing.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909072102.57854.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Monday 07 September 2009 18:16:47 Michael Rack wrote:
> I got these numbers by "/sbin/ip addr show dev gate0".
> 
> gate0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1431 qdisc
> pfifo_fast qlen 500
>      link/[65534]
>      inet 169.254.0.0/32 scope global gate0
> 
> MTU is set to 1431 bytes.

And what is the MTU of the interface batman is running on ?

Did the iptables command I posted help you to fix your MSS problem ?


> IP-Host #1: 123.205.12.0 / 32
> IP-Host #2: 123.205.12.4 / 32
> 
> IP RULES ON "HOST #2":
> ~ $ /sbin/ip rule show
> 6600:    to 123.205.12.4 lookup batman_hosts [66]
> 6601:    from all lookup batman_networks [65]
> 6700:    to 123.205.12.4 lookup batman_unreach [67]
> 
> Host #1 (123.205.12.0) is in the routingtable of batman_hosts [66].
> 
> But i can not ping 123.205.12.0, because the kernel will not enter the
> rule 6600.
> 
> When i configure my Host #2 to a /24 network, all went fine. Then the
> rule will setuped as follow:
> 
> 6600:    to 123.205.12.4/24 lookup batman_hosts [66]

Ok, I see your problem. Batman could easily detect whether the host is part of 
any existing network and if not modify the routing rules. I see 2 options:
* adding more rules to jump in table 66
* adding the node to table 65 instead of 66

What did you do to make it work ?

Regards,
Marek
