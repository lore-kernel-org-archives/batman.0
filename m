Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Apr 2010 18:27:58 +0800
References: <1272237853-26242-1-git-send-email-sven.eckelmann@gmx.de>
	<201004261659.20055.lindner_marek@yahoo.de>
	<201004261124.19573.sven.eckelmann@gmx.de>
In-Reply-To: <201004261124.19573.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004261827.58948.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Update pointer to ethhdr
	after skb_copy
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

On Monday 26 April 2010 17:24:13 Sven Eckelmann wrote:
> They are not really needed, but just wanted to have them in for later
>  usage  and to have it more consistent (otherwise copy and paste easily
>  leads to funny effects for some people which cannot be reproduced by the
>  maintainers). So it could be removed in recv_icmp_packet and
>  recv_unicast_packet if you prefer it.

Ok, I somehow figured that this was meant to combat copy & paste but I wanted 
to make sure.  :-)
Your patch was applied in revision 1640.

Thanks,
Marek
