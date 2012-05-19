Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 19 May 2012 15:45:28 +0800
References: <1337267913-14693-1-git-send-email-sven@narfation.org>
	<63684276.bozYGFlTKx@sven-desktop.home.narfation.org>
	<2747952.xVrmVMOGXq@sven-laptop.home.narfation.org>
In-Reply-To: <2747952.xVrmVMOGXq@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205191545.28651.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Revert Distributed ARP Table
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

On Saturday, May 19, 2012 14:53:16 Sven Eckelmann wrote:
> > merge.patch -- this is the patch that can be used to create the merge of
> > next into merge after all remaining namespace patches are applied and
> > "batman- adv: Revert Distributed ARP Table" *is applied in next after
> > ccf1183f53baa879cd5a808dbb904f6053fa40f3*.
> >
> > 
> >
> > $ git merge --no-commit -s ours next
> > $ git apply --index merge.patch
> > $ git commit
> 
> I've attached the updated patch that is compatible with your changes in 
> distributed-arp-table.c to my patches.

Applied in revision 206af11.

Thanks,
Marek
