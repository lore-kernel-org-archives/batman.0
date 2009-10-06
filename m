Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Oct 2009 15:52:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091006135231.GE6646@lunn.ch>
References: <200910061328.04894.holger@layer-acht.org>
	<200910061355.49409.sven.eckelmann@gmx.de>
	<200910062127.42925.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200910062127.42925.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Re: Debian extra modules
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

> > Parts which are important:
> >  * TODO list for staging inside batman-adv folder
> >  * removed compat.h and remaining LINUX_VERSION_CODE (net_device_ops,
> >    unregister_chrdev)
> >  * clean Makefile and Kconfig
> >  * anyone who says how the further development should be done
> >  * anyone who sends the patch to Greg (probably Marek)
> 
> I think most of the things listed here are already done. It just
> needs to come together. I'm confident that this will happen soon.

I have Makefile and Kconfig in my git tree. My tree is also up to date
with respect to SVN on 09/27/09 02:21:54 which was the last commit to
batman-adv. I would like to push some of the changes out of my git
tree and into SVN, just to make it simpler for merging backwards and
forwards. I guess i will mail Marek a diff sometime today.

          Andrew
