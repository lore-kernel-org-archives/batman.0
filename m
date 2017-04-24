Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 24 Apr 2017 21:27:36 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170424192736.GQ4807@otheros>
References: <20170114212803.GF3254@otheros>
 <1484441452.2998.11.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1484441452.2998.11.camel@decadent.org.uk>
Subject: Re: [B.A.T.M.A.N.] Duplicate #include guards with make-kpkg /
 out-of-tree compile errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>, Manoj Srivastava <srivasta@debian.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, debian-kernel@lists.debian.org, Daniel Borkmann <daniel@iogearbox.net>, "Dmitry V. Levin" <ldv@altlinux.org>

Hi Ben,

Due to the missing response we went for a workaround in the
out-of-tree backports version of batman-adv for now.

However, it seems a similar issue now popped up with 4.11-rc1
again: [0] ("fatal error: sys/socket.h: No such file or directory")

Second try: Manoj, do you see a chance to fix these two issues
([0][1]) in kernel-package or is this package currently
unmaintained?

Anything I can help with for further debugging in kernel-package?

Regards, Linus

[0]: https://www.open-mesh.org/issues/333
[1]: https://www.open-mesh.org/issues/322


On Sun, Jan 15, 2017 at 12:50:52AM +0000, Ben Hutchings wrote:
> kernel-package is maintained by Manoj Srivastava (cc'd), not the kernel
> team.
> 
> Ben.
> 
> On Sat, 2017-01-14 at 22:28 +0100, Linus Lüssing wrote:
> > Hi Ben and others,
> > 
> > Recently we stumbled upon some compile errors when trying to build
> > a backport version of the batman-adv kernel module for a 4.5 kernel
> > [0]:
> > 
> >     "implicit declaration of function ‘G_TC_AT’"
> > 
> > It seems VirtualBox has stumbled over this issue, too [1].
> > 
> > When trying to find the cause of these errors we noticed that the
> > headers directory created via "$ make-kpkg kernel_headers" for 4.5
> > kernel resulted in two differing header files with the same guard,
> > namely __LINUX_PKT_CLS_H:
> > 
> > https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4
> > .5.0%2b/include/uapi/linux/pkt_cls.h
> > https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4
> > .5.0%2b/include/linux/pkt_cls.h
> > 
> > The latter, the non-uapi version, has the "#ifdef __KERNEL__"
> > section stripped, causing the compile issue if it is included
> > before the uapi variant.
> > 
> > Removing this non-uapi version from the unpacked
> > linux-headers .deb package manually afterwards lets
> > a batman-adv compilation succeed again.
> > 
> > Daniel (CC) has helped a lot with debugging so far and he
> > expressed the suspicion that maybe make-kpkg might install
> > "$ make headers_install" into the wrong directory?
> > 
> > Regards, Linus
> > 
> > [0]: https://www.open-mesh.org/issues/322
> > [1]: https://www.virtualbox.org/ticket/15327
> > 
> > PS: make-kpkg was invoked on a Debian Jessie (kernel-package
> > 13.014+nmu1).
> -- 
> Ben Hutchings
> Hoare's Law of Large Problems:
>         Inside every large problem is a small problem struggling to get
> out.
> 


