Return-Path: <andrew@lunn.ch>
Date: Sat, 20 Feb 2010 19:04:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100220180411.GA15286@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
	<20100219171905.GA17836@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100219171905.GA17836@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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

On Fri, Feb 19, 2010 at 06:19:05PM +0100, Linus L??ssing wrote:
> Hi Andrew,
> 
> Sorry, didn't have the time to try your patch any earlier, I'm
> right in the middle of my exams :).

Hi Linus

Marek told me. No problems. I remember what its like studying for
exams. However, it is nice to sometimes take a break and do something
totally different. 

> Your patch already looks quite good, I couldn't reproduce any
> memory leaks or crashes here (tried that with three routers and 1
> or 2 vis servers activated, also activating/deactivating them a
> lot, no problems with that). And yes, the slow-path warning has
> gone with your patch.

Great. So we are on the right tracks.

> However, I'm having some weird output when connecting two routers
> over wifi _and_ over ethernet cable. The setup:
> 
> Before plugging in the cable:
> r1-ath1 <-- wifi --> r2-ath1
> ------------
> root@OpenWrt:~# batctl vd dot
> digraph {
>         "r1-ath1" -> "r2-ath1" [label="1.32"]
>         "r1-ath1" -> "r1-hna" [label="HNA"]
>         "r1-ath1" -> "5a:2e:1e:1f:64:6b" [label="HNA"]
>         subgraph "cluster_r1-ath1" {
>                 "r1-ath1" [peripheries=2]
>         }
>         "r2-ath1" -> "r1-ath1" [label="1.11"]
>         "r2-ath1" -> "r2-hna" [label="HNA"]
>         "r2-ath1" -> "82:31:95:f9:14:6f" [label="HNA"]
>         subgraph "cluster_r2-ath1" {
>                 "r2-ath1" [peripheries=2]
>         }
> }
> ------------
> After plugging in the cable:
> r1-ath1 <-- wifi --> r2-ath1 +
> r1-eth0.3 <-- cable --> r2-eth0.3
> ------------
> root@OpenWrt:~# batctl vd dot
> digraph {
>         "r1-ath1" -> "r2-ath1" [label="1.0"]
>         "r1-ath1" -> "r2-eth0.3" [label="1.66"]
>         "r1-ath1" -> "r1-hna" [label="HNA"]
>         "r1-ath1" -> "5a:2e:1e:1f:64:6b" [label="HNA"]
>         subgraph "cluster_r1-ath1" {
>                 "r1-ath1" [peripheries=2]
>                 "r1-eth0.3"
>         }
>         subgraph "cluster_r1-ath1" {
>                 "r1-ath1" [peripheries=2]
>         }
>         "r2-ath1" -> "r1-ath1" [label="1.0"]
>         "r2-ath1" -> "r1-eth0.3" [label="1.15"]
>         "r2-ath1" -> "r2-hna" [label="HNA"]
>         "r2-ath1" -> "82:31:95:f9:14:6f" [label="HNA"]
>         subgraph "cluster_r2-ath1" {
>                 "r2-ath1" [peripheries=2]
>                 "r2-eth0.3"
>         }
>         subgraph "cluster_r2-ath1" {
>                 "r2-ath1" [peripheries=2]
>         }
> }
> root@OpenWrt:~# cat /proc/net/batman-adv/vis_data
> 06:22:b0:98:87:dd,TQ 04:22:b0:98:87:fa 251, HNA 00:22:b0:98:87:dd, HNA 5a:2e:1e:1f:64:6b, PRIMARY, SEC 04:22:b0:98:87:de,
> 06:22:b0:98:87:f9,TQ 06:22:b0:98:87:dd 255, TQ 04:22:b0:98:87:de 251, HNA 00:22:b0:98:87:f9, HNA 82:31:95:f9:14:6f, SEC 04:22:b0:98:87:fa, PRIMARY,

Actually, this vis_data to does not map to the dot above!  There are
the wrong number of HNA, wrong order etc.

Here is what i think your bat-host file contains:
06:22:b0:98:87:dd r1-ath1
06:22:b0:98:87:f9 r2-ath1
00:22:b0:98:87:dd r1-hna
04:22:b0:98:87:de r1-eth0.3
00:22:b0:98:87:f9 r2-hna
04:22:b0:98:87:fa r2-eth0.3

and this is what i get, assuming i got the MAC->name mapping correct:

digraph {
	"r1-ath1" -> "r2-eth0.3" [label="1.15"]
	"r1-ath1" -> "r1-hna" [label="HNA"]
	"r1-ath1" -> "5a:2e:1e:1f:64:6b" [label="HNA"]
	subgraph "cluster_r1-ath1" {
		"r1-ath1" [peripheries=2]
	}
	subgraph "cluster_r1-ath1" {
		"r1-ath1" [peripheries=2]
		"r1-eth0.3"
	}
	"r2-ath1" -> "r1-ath1" [label="1.0"]
	"r2-ath1" -> "r1-eth0.3" [label="1.15"]
	"r2-ath1" -> "r2-hna" [label="HNA"]
	"r2-ath1" -> "82:31:95:f9:14:6f" [label="HNA"]
	subgraph "cluster_r2-ath1" {
		"r2-ath1" [peripheries=2]
		"r2-eth0.3"
	}
	subgraph "cluster_r2-ath1" {
		"r2-ath1" [peripheries=2]
	}
}

batctl parses top-to-bottom, left-to-right. It does not consolidate
the PRIMARY and the SECONDARY into one cluster. It leaves DOT to do
that. Hence there are two cluster statements for each cluster actually
drawn.

> So the second 'subgraph "cluster_r1-ath1"' is obviously
> unnecessary.

Yes, unnecessary, but makes the batctl code easier.

 Also "r1-ath1" -> "r2-eth0.3" looks wrong, should be
> "r1-eth0.3" -> "r2-eth0.3" instead (and the same with r2 a few
> lines later).

These comments i agree with. A wireless and a wired device should not
be neighbours. We don't have any records which originate from the
secondary MAC address. That is guess is the major problem here.

So, did my/Mareks patch break it, or was it broken before?

First i suggest you go back to just before Simon's patch which
introduced receiving using skbufs:

http://open-mesh.org/changeset/1517

That will tell us if we need to go back further, or our patch broke
it. 

If you need to go back further, i would suggest just before:

http://open-mesh.org/changeset/1510

However, if it is our patch then we can chop the patch into two:

Use Mareks patch:

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-January/002261.html

and 

Index: vis.c
===================================================================
--- vis.c	(revision 1575)
+++ vis.c	(working copy)
@@ -444,10 +444,15 @@
 			memcpy(info->packet.target_orig,
 			       orig_node->orig, ETH_ALEN);
 
+spin_unlock_irqrestore(&orig_hash_lock, flags);
+
 			send_raw_packet((unsigned char *) &info->packet,
 					packet_length,
 					orig_node->batman_if,
 					orig_node->router->addr);
+
+spin_lock_irqsave(&orig_hash_lock, flags);
+
 		}
 	}
 	memcpy(info->packet.target_orig, broadcastAddr, ETH_ALEN);

This adds a race condition, which i hope if O.K. for debugging
purposes, but i hope allows the send to happen without the slowpath
errors. If so, we can test Marek's part of the patch.

I'm on vacation for a week now. I will have Internet access some time,
but not much. 

Have fun debugging.

     Andrew
