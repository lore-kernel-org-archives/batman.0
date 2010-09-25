Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 25 Sep 2010 12:13:08 +0200
References: <20100916235908.51ab3bfc@rechenknecht>
In-Reply-To: <20100916235908.51ab3bfc@rechenknecht>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201009251213.09040.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: unicast fragmentation enhancements
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

> things that changed since the last patch:
> - add support to fragment packets on every node,
>   if outgoing iface mtu is smaller as the packet
> - add support to defragment packets on every node,
>   if outgoing iface mtu is >= original size
> - rename some functions

I just merged your patchset (revision 1810-1815) into the trunk since 
everybody seemed to be happy with it. :-)

Thanks for your work on the fragmentation,
Marek
