Return-Path: <clang@gateworks.com>
From: Chris Lang <clang@gateworks.com>
In-Reply-To: <201010251444.38251.lindner_marek@yahoo.de>
References: <clang@gateworks.com>
	<1287988488-10533-1-git-send-email-clang@gateworks.com>
	<201010251444.38251.lindner_marek@yahoo.de>
Content-Type: text/plain
Date: Mon, 25 Oct 2010 08:36:30 -0700
Message-Id: <1288020990.5210.35.camel@chris-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Re-Enable
	Interface	alternating and bonding
Reply-To: clang@gateworks.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

On Mon, 2010-10-25 at 14:44 +0200, Marek Lindner wrote:
> On Monday 25 October 2010 08:34:48 Chris Lang wrote:
> > r1765 incidentally disabled bonding of packets first entering the
> > mesh along with also disabling interface alternating regardless
> > of where the packet came from. This re-enables these options.
> 
> Wow - what a catch! :-)
> We might have to reword your commit message to get your patch accepted by the 
> Linux stable maintainers. I offer to do the job if you don't mind.
> 
> Cheers,
> Marek

Marek,

I don't have any issue with you rewording the commit message. I just
didn't think about making the commit message linux friendly.

Thanks,

-- 
Chris Lang
Gateworks Corporation
3026 S. Higuera, San Luis Obispo, CA 93401
Ph: 805-781-2000 Fax: 805-781-2001
Email: clang@gateworks.com
Web: www.gateworks.com

