Return-Path: <bjo@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Mon, 26 Sep 2011 14:33:57 +0200
Message-ID: <9545431.T6PA3XuY7H@mytilus>
In-Reply-To: <201109261137.00207.lindner_marek@yahoo.de>
References: <3131360.5iACvcvJX2@ostrea>
	<201109261137.00207.lindner_marek@yahoo.de>
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


> STP is no solution. Did you try enabling the bridge loop avoidance ?
> http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance
> 
> You might need to upgrade to a later batman-adv version though.
> 
> Regards,
> Marek

We did not enable bridge loop avoidance, IIRC we did not run batman on the 
bridge interface due to overhead on the vpn links.

But we'll enable it on the nodes we have access to.

thx
bjo
-- 
jabber: bjo@schafweide.org
bjo.nord-west.org | nord-west.org | freifunk-ol.de
