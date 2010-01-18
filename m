Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 18 Jan 2010 19:31:22 +0800
References: <20100104182710.GA24091@pandem0nium>
	<20100117201558.GA8696@pandem0nium>
In-Reply-To: <20100117201558.GA8696@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201001181931.22344.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add bonding functionality
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

> i've just committed this patch in revision 1551, as no further comments and
>  critiques came in. I would consider this patch rather simple, and as
>  experimental feature it is switched off by default anyways ... :)
> 
> I've changed only a small thing in the committed patch: When neighbors are
>  purged, the bonding candidate list gets updated instead of bonding
>  switched off.

did not have the time to go through your patch in much detail. I just scrolled 
over it and stumbled over routing.c line 1018. I guess you wanted to write:
spin_*un*lock_irqsave(&orig_hash_lock, flags);

Regards,
Marek
