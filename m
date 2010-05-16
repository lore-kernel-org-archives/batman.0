Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 17 May 2010 03:37:44 +0800
References: <20100508170755.GA27599@ritirata.org>
	<21142356.1006178.1273698170378.JavaMail.fmail@mwmweb072>
	<f31ad2968a9884d5bda6eebde3a01b21@localhost>
In-Reply-To: <f31ad2968a9884d5bda6eebde3a01b21@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201005170337.45135.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Blocking OGMs from a node for testing purpose
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


Hey,

> The problem seems to be that iptables filters only packets that are sent
> to IP layer and over..so any packet intended for a protocol living on a
> layer lower than IP is not recognized (e.g. batman frame).

I'd say you are right here.


> Ebtables instead works only on eth bridges...I tried it because I thought
> that bat0 was acting like a bridge indeed but this is not the case...The
> only solution I thought could be this: create a bridge-if br0, attach wlan0
> to it and then attach br0 to bat0 and then you could let ebtables work
> between wlan0 and br0....maybe it could work...
> But attaching a wlan-if to a eth-bridge-if is not actually possible.

At the WCW we sat together to discuss the issue. The easiest thing to test 
would be this: You create a bridge "br0" and add the wifi interface batman 
usually runs on (e.g. wlan0). Then you configure batman-adv to run on the 
bridge instead on wlan0 directly (batctl if add br0). Since the packets travel 
through the bridge interface first, it might be possible to drop them there. 

Be sure to create an individual bridge interface for each wifi interface you 
want to run batman-adv on. The purpose of the bridge interface is to allow 
packet filtering, not to bridge interfaces.

Please let us know how it goes.  :-)

Cheers,
Marek
