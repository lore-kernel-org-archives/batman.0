Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Apr 2012 23:11:08 +0300
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120324081407.GA30000@ritirata.org>
	<20120324202117.GH5662@lunn.ch>
In-Reply-To: <20120324202117.GH5662@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204052311.09200.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/5] batman-adv: ELP - creating neighbor
	structures, updating LQs
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

On Saturday, March 24, 2012 22:21:17 Andrew Lunn wrote:
> I'm assuming the choice of algorithm is linked to the soft interface,
> i.e, bat0 could be using a different algorithm to bat1. So i think
> multiple algorithms are possible at the same time.

Correct.


> I have been thinking about this a bit more, and also about this bit of
> code:
> 
> +       elp_packet = (struct batman_elp_packet
> *)skb_push(hard_iface->elp_skb, +                                         
>                BATMAN_ELP_HLEN); +       memset(elp_packet, 0,
> BATMAN_ELP_HLEN);
> +
> +       elp_packet->header.packet_type = BAT_V_ELP;
> +       elp_packet->header.version = COMPAT_VERSION;
> +       elp_packet->header.ttl = 0;
> 
> Marek, what are your plans for COMPAT_VERSION? Will there be a
> COMPAT_VERSION_IV and COMPAT_VERSION_V sometime soon?

Currently, that is not planned. We hoped to keep the compat numbers in sync 
across the various protocols. Otherwise we all could end up in compat hell.


> Maybe when registering a receive function, you can pass both the
> packet_type and version. So a received ELP packet with
> COMPAT_VERSION_IV would automatically get tossed away, and an ELP with
> COMPAT_VERSION_V would get dispatched.

What would be the use case of ELP COMPAT_VERSION_IV vs ELP COMPAT_VERSION_V ? 
BATMAN IV does not have ELP at all .. maybe I misunderstand ?

Regards,
Marek
