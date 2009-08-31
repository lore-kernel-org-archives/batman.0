Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 31 Aug 2009 13:26:29 +0800
References: <20090830013647.GA26017@Linus-Debian>
	<20090830073752.GO16067@lunn.ch>
	<20090830202306.GB2410@pandem0nium>
In-Reply-To: <20090830202306.GB2410@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200908311326.29339.lindner_marek@yahoo.de>
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

On Monday 31 August 2009 04:23:06 Simon Wunderlich wrote:
> Usually we have stable versions (e.g. batman-adv 0.1) with a specific
> format, and an ongoing development in the svn trunk. Maybe we should do the
> same for future kernel development - maintaining one packet and algorithm
> version in the kernel, and further develop the algorithm on our own (e.g.
> in a git tree or with sets of patches)?
> In this case, we should post the current batman-adv to the list when
> 0.2 is stabilized and finished. Mainline algorithm should only be changed
> when we reach a new stable version.

Actually, I came to a similar conclusion:
We "only" submit stable versions to mainline (including stability fixes) 
whereas the development stays outside of the official linux tree. That way we 
can keep our development speed without worrying too much about compatibility. 
When we are getting to the next stable release we can think about how to 
soften the transition. 

More ideas / opinions ?

Regards,
Marek
