Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 17 Jan 2017 20:11:13 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170117191113.GI5514@otheros>
References: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
 <4570303.DAXUuCGGu2@bentobox> <1484667540.3000.7.camel@sdl.usu.edu>
 <1560076.ER48KEDWps@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1560076.ER48KEDWps@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] IPv4 multicast distribution support.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tue, Jan 17, 2017 at 05:54:57PM +0100, Sven Eckelmann wrote:
> > I did download the kernel source, but when I try to run the script it
> > either tells me that I don't have a valid kernel tree (when using the
> > sources for my Xubuntu kernel) or that the file I'm trying to scan
> > isn't part of the tree (when using the latest from kernel.org).  I've
> > never used that tool in the past - can you send me a usage example for
> > scanning a file in the alfred tree?
> 
> Just did this from my linux-next.git checkout:
> 
>     ./scripts/checkpatch.pl --strict --ignore=LONG_LINE_STRING \
>       --ignore=LONG_LINE --ignore=LONG_LINE_COMMENT \
>       --ignore=FSF_MAILING_ADDRESS \
>       -f ../alfred/main.c
> 
> or:
> 
>     ./scripts/checkpatch.pl --strict --ignore=LONG_LINE_STRING \
>       --ignore=LONG_LINE --ignore=LONG_LINE_COMMENT \
>       --ignore=FSF_MAILING_ADDRESS \
>       ../alfred/0001-IPv4-multicast-distribution-support.patch

Not 100% sure whether it's needed, but if you still have issues
try to at least call "make scripts" (or even "make prepare") in the
kernel source directory first.

Also, maybe simply use the vanilla tree from Torvalds with a
  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Should have a more up-to-date checkpatch.pl than the Ubuntu source
directory anyway.
