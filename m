Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Tue, 27 Sep 2011 12:45:01 +0200
Message-ID: <1997296.MKzYFvRXTH@mytilus>
In-Reply-To: <201109261726.38951.lindner_marek@yahoo.de>
References: <3131360.5iACvcvJX2@ostrea> <9545431.T6PA3XuY7H@mytilus>
	<201109261726.38951.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] batman-adv: loop caused by tinc and wifi
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

Am Montag, 26. September 2011, 17:26:37 schrieb Marek Lindner:
> On Monday, September 26, 2011 14:33:57 Bjoern Franke wrote:
> > We did not enable bridge loop avoidance, IIRC we did not run batman on
> > the bridge interface due to overhead on the vpn links.
> > 
> > But we'll enable it on the nodes we have access to.
> 
> Please give it a try. It sounds like a bridge loop.

Ok, we have running now the following setup:

ath1 (ad-hoc) as batman-interface
br-mesh (ath0 (ap-mode), eth0.1, tap0, bat0) as batman-interface

batman complains about the mtu 1500 of br-mesh, but it can't be set to 1527 
because bat0 does not like any mtu setting.

> We are working towards an enhanced bridge loop mechanism which aims to
> reduce the overhead. Are you interested in testing it when it gets ready ?
> 

Yes, this would be nice :)

regards
Bjoern

-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de
