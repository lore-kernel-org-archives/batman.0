Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 27 Feb 2010 13:44:36 +0800
References: <1267235382-4026-1-git-send-email-linus.luessing@web.de>
	<20100227021157.GA4116@Linus-Debian>
In-Reply-To: <20100227021157.GA4116@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201002271344.36630.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: only modify hna-table on
	active module
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

nice patch and this time well formatted.  ;-)
Applied in 1578.

> Just for some more clarification about this bug (have a look at
> the attached call trace): It always occurs when I haven't put an
> interface into batman-adv and when I'm then changing the
> mac-address of bat0. I've now added a little check in
> interface_set_mac_addr() which seems to work nicely here in my
> setup. I'm also wondering if we should add another sanity check
> somewhere in hna_local_add() to directly avoid any racy null
> pointer dereferences in there.

I'm not sure it is a good place to put such a check since hna_local_add() is 
more of a library function which does not know much about the context. 
However, it could check whether the hna_local_hash had been initialized.

Cheers,
Marek
