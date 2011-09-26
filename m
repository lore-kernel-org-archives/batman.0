Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Sep 2011 11:36:59 +0200
References: <3131360.5iACvcvJX2@ostrea>
In-Reply-To: <3131360.5iACvcvJX2@ostrea>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201109261137.00207.lindner_marek@yahoo.de>
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


Hi,

> B.A.T.M.A.N. advanced 2011.0.0 (compatibility version 12)
> 
> ath1 (ad-hoc) as batman-adv-interfaces
> ath0 (ap), tap0, eth0.1 and bat0 as a bridge
> 
> stp is enabled for the bridge.

STP is no solution. Did you try enabling the bridge loop avoidance ?
http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance

You might need to upgrade to a later batman-adv version though.

Regards,
Marek
