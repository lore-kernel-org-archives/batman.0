Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 31 Aug 2011 11:55:27 +0200
References: <4E5D69E3.30403@robotech.de>
In-Reply-To: <4E5D69E3.30403@robotech.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201108311155.27490.lindner_marek@yahoo.de>
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

> At first everything seemed to work. A node on the one end could ping a
> node on the other end over the mesh-network. The ping was hopping from
> node to node as expected.
> 
> But sometimes some paths do not work anymore.
> 
> Some nodes can only reach their direct neighbors via a "normal ping". A
> ping to a node via one hop does not work. A "batctl ping" does work!
> 
> This only happens to parts of the network and is not permanent. If i
> wait it will recover, but then the problem appears at another node.

since "batctl ping" works I'd say your mesh works fine - you have a problem in 
your higher layers. Maybe a mac address collision or an ARP timeout ?

Can you provide specific examples we can go through ? For instance, provide 
the batctl ping output to the neighbor in question, the ping error message 
(does it say timeout / host could not be found / etc), a batctl traceroute to 
the neighbor in question and the output of the global translation table.

Are you trying to ping a 'fixed' node or a node that is roaming ?

Regards,
Marek
 
