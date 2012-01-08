Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 9 Jan 2012 05:29:26 +0800
References: <A677A9FB362B2F499BEFD6F80687FE9722FD1E20@umechphe.easf.csd.disa.mil>
In-Reply-To: <A677A9FB362B2F499BEFD6F80687FE9722FD1E20@umechphe.easf.csd.disa.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201201090529.26914.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] statistics & topology provided by batman-adv
	(UNCLASSIFIED)
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

> I'm a roboticist.  My current project involves creating robots that are
> mobile ad-hoc routers for a network.  The robots are supposed to
> autonomously determine where to move to improve the
> bandwidth/latency/reliability/etc. of a network.  In order for this to
> work, each robot needs to have a rough approximation of the topology of
> the network, so they can measure if their movements are improving or
> worsening the network.  The topology information needs to include not just
> what the network is currently like (which, from the documentation, appears
> to always be a tree), but a complete graph, with measured information
> about the bandwidth/latency/reliability of the links between pairs of
> nodes.  Is it possible to get this information from batman-adv?

a single batman node does not have the information about all links and their 
properties (bandwidth/latency/reliability) in the network. The reason is quite 
simple: The larger the mesh the more outdated your information will be.


> Classification: UNCLASSIFIED

Lucky me.  :-)

Regards,
Marek
