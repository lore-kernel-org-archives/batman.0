Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 May 2013 00:39:33 +0800
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
 <1369382549-8787-4-git-send-email-linus.luessing@web.de>
 <20130528154054.GC14466@pandem0nium>
In-Reply-To: <20130528154054.GC14466@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305290039.34391.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: Modified forwarding
	behaviour for multicast packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Tuesday, May 28, 2013 23:40:54 Simon Wunderlich wrote:
> You can safe an indendation below if you return -1 immediately here
> if the statement above is false. Also multiple statements might be better
> for readability and later changes, e.g.
> 
> if (!atomic_read(&bat_priv->mcast_group_awareness))
>         return 1;
> 
> if (atomic_read(&bat_priv->mcast.num_non_aware))
>         return 1;
> 
> if (ntohs(ethhdr->h_proto) != ETH_P_IPV6)
>         return 1;

A quick hint from my end: The kernel maintainer don't like code that returns 
"random" values like 1/0/-1. Either use bool or meaningful defines instead of 
raw numbers.

Cheers,
Marek
