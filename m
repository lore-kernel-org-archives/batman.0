Return-Path: <ylonen@gmx.net>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 20 Jan 2010 14:12:34 +0100
From: =?iso-8859-1?Q?=22Juha_Yl=F6nen=22?= <ylonen@gmx.net>
In-Reply-To: <201001201015.59477.lindner_marek@yahoo.de>
Message-ID: <20100120131234.4760@gmx.net>
MIME-Version: 1.0
References: <20100119145806.275330@gmx.net>
	<201001201015.59477.lindner_marek@yahoo.de>
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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


-------- Original-Nachricht --------
> Datum: Wed, 20 Jan 2010 10:15:59 +0800
> Von: Marek Lindner <lindner_marek@yahoo.de>
>
> Before we dive into debugging the code I'd suggest you send us your
> complete 
> interface configuration. Maybe the problem is much more simple than it
> seems. 
> Complete configuration means: brctl show, ifconfig, cat /proc/net/batman-
> adv/interfaces (or batctl if) and ping output. 

Here we go:
---
##x> brctl show
bridge name     bridge id               STP enabled     interfaces
##> cat interfaces 
[  active] eth1 00:11:f6:83:af:ab 
##> ifconfig 
bat0      Link encap:Ethernet  HWaddr 32:21:CA:8E:37:DC  
          inet addr:10.0.1.39  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1476  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:468 (468.0 B)

eth1      Link encap:Ethernet  HWaddr 00:11:F6:83:AF:AB  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:179 errors:0 dropped:0 overruns:0 frame:0
          TX packets:268 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:6086 (5.9 KiB)  TX bytes:10450 (10.2 KiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

##> route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
10.0.0.0        *               255.0.0.0       U     0      0        0 bat0
##> ping 10.0.1.40
PING 10.0.1.40 (10.0.1.40): 56 data bytes

--- 10.0.1.40 ping statistics ---
10 packets transmitted, 0 packets received, 100% packet loss
---

I also checked the return value for dev_queue_xmit in send.c and it was 0. 

-Juha

-Juha
-- 
Jetzt kostenlos herunterladen: Internet Explorer 8 und Mozilla Firefox 3.5 -
sicherer, schneller und einfacher! http://portal.gmx.net/de/go/chbrowser
