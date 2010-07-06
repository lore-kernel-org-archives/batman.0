Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Jul 2010 21:50:28 +0200
References: <20100706175814.6927f767@rechenknecht>
	<20100706185729.GB18453@lunn.ch>
	<201007062113.12980.sven.eckelmann@gmx.de>
In-Reply-To: <201007062113.12980.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201007062150.29068.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
	fragmentation
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Tuesday, July 06, 2010 21:13:11 Sven Eckelmann wrote:
> He didn't say that it will take all available system memory. There is still
> the problem that the 6 slots per originator (so the memory per originator)
> could be full when we have a bad link and a too big waiting time for
> missing fragments.

I also think the timeout could be a bit smaller but just to make sure we all 
agree on one thing: The fragmentation should never be used over lossy links.

Imagine we have a link with 50% packet loss and fragmentation enabled which 
makes out of every packet 2 packets. Now, we have a pretty high probability 
that one of these 2 packets gets lost during transit. Therefore batman-adv can 
not reassemble the packet on the other side which will lead to a 
retransmission that has the same chance of success as the previous packet ...

Regards,
Marek
