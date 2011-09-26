Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Sep 2011 17:26:37 +0200
References: <3131360.5iACvcvJX2@ostrea>
	<201109261137.00207.lindner_marek@yahoo.de>
	<9545431.T6PA3XuY7H@mytilus>
In-Reply-To: <9545431.T6PA3XuY7H@mytilus>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201109261726.38951.lindner_marek@yahoo.de>
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

On Monday, September 26, 2011 14:33:57 Bjoern Franke wrote:
> We did not enable bridge loop avoidance, IIRC we did not run batman on the
> bridge interface due to overhead on the vpn links.
> 
> But we'll enable it on the nodes we have access to.

Please give it a try. It sounds like a bridge loop.
We are working towards an enhanced bridge loop mechanism which aims to reduce 
the overhead. Are you interested in testing it when it gets ready ?

Regards,
Marek
