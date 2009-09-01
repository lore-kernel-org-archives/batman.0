Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 2 Sep 2009 02:47:06 +0800
References: <20090830013647.GA26017@Linus-Debian>
	<200908311326.29339.lindner_marek@yahoo.de>
	<20090831055007.GR16067@lunn.ch>
In-Reply-To: <20090831055007.GR16067@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200909020247.06730.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] development flow
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Monday 31 August 2009 13:50:07 Andrew Lunn wrote:
> I would say we have around three months to get 0.2 finished and into
> 2.6.32 staging. For 2.6.33 we don't break compatibility any more and
> aim to finish the cleanup and get into the main tree.

That sounds like a plan. Let me add our own versions to make things clear:

* 2.6.32 gets our 0.2 stable
* 2.6.33 get 0.2.5 which is 0.2 stable + linux mainline changes (no packet 
format changes, etc will happen here)

After we released the 0.2 stable we start our 0.3 development branch which 
contains the new ideas to improve the routing and other stuff. When this branch 
gets included into mainline is unclear at this point.


> I would also suggest we post our patches as soon as possible, so we
> start getting feedback from the kernel community about what else needs
> adding to the TODO list etc.

Yes, when and where should we post it ? Should the mailing list be migrated at 
that point (I felt a consensus concerning the ml move) ?

It might be a good idea to maintain the ToDo list in the wiki - what do you 
think ?

Regards,
Marek
