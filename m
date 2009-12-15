Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 15 Dec 2009 19:51:04 +0800
References: <14202394.464551260869728978.JavaMail.coremail@bj126app27.126.com>
In-Reply-To: <14202394.464551260869728978.JavaMail.coremail@bj126app27.126.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200912151951.04568.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Does batman-adv  support gateway ?
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

On Tuesday 15 December 2009 17:35:28 wu xiaofei wrote:
> Does batman-adv  support gateway ? Should all nodes' interfaces(batman-adv
>  interface , non batman-adv interface) be in the same network(e.g.
>  192.168.1.0/24)   or  use "HNA" to announce different networks? (some
>  nodes have multi interfaces)
> 
> Olsrd can use "HNA" to announce  'non-olsrd interface' in different network
>   from 'olsrd interface' , so other nodes know how to get to that network.
> 
> How to config the IP address of a node with two interfaces running
>  batman-adv at the same time?


Hey,

are sure you want to know about batman-adv ? Advanced operates on layer 2 (mac 
address layer) and does not care about IP addresses. If you want to let non-
batman nodes join the network you simply bridge the interfaces. No (manual) 
HNA settings are needed.

If you are interested in the batman daemon (layer 3 - ip layer) I suggest you 
read through our documentation: http://www.open-mesh.net/wiki/UserDocs

Regards,
Marek
