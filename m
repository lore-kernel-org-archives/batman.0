Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Apr 2010 13:44:09 +0800
References: <4BB9FDFE.25617.3ED974FA@pbeddy.treverton.co.za>
In-Reply-To: <4BB9FDFE.25617.3ED974FA@pbeddy.treverton.co.za>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201004061344.10152.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Multiple gateways and WRT54GL's
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

> I manage a campus network which runs a fibre backbone between critical
>  points. I wish to  impliment a wireless mesh to link non-critical points
>  and "fill-the-gaps" so to speak. It is thus possible that more than one
>  wireless point could act as a gateway to the main network. I understand
>  that the B.A.T.M.A.N. protocol offers the most promising means of
>  achieving this objective.

you can use meshing to build a chain of wireless routers covering a certain 
area. If you only have a single AP at the end of your fibre there is no need to 
mesh.


> 1: Do I have to use the Advanced version of B.A.T.M.A.N. to make this
>  possible, of will the  "standard" version work?
> 
> 2: I have purchased a few WRT54GL-EU routers with which to test the
>  implimentation. Are  there any pre-compiled versions of the binaries
>  available, or do I have to use a PC running Linux to compile my own
>  binaries?

Both implementations can be used to build the mesh but it is a bit hard to 
give advice on which might be more suitable for your setup since we don't have 
much information regarding your requirements. The "standard" batman operates 
on layer 3 whereas advanced operates on layer 2 (each having its advantages & 
disadvantages). 

Note: As batman-adv is a kernel module it heavily depends on the kernel 
version you run on the nodes. A linux not older than 2.6.20 is required. AFAIK 
the WRT54G still depends on the precompiled proprietary wifi driver only 
available for linux 2.4.20. OpenWRT tries to move to the open driver but I 
don't know how well it works.

Regards,
Marek
