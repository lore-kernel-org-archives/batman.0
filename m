Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 14 Jan 2017 22:28:03 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170114212803.GF3254@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Duplicate #include guards with make-kpkg /
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
To: ben@decadent.org.uk
Cc: b.a.t.m.a.n@lists.open-mesh.org, Daniel Borkmann <daniel@iogearbox.net>, debian-kernel@lists.debian.org

Hi Ben and others,

Recently we stumbled upon some compile errors when trying to build
a backport version of the batman-adv kernel module for a 4.5 kernel [0]:

    "implicit declaration of function ‘G_TC_AT’"

It seems VirtualBox has stumbled over this issue, too [1].

When trying to find the cause of these errors we noticed that the
headers directory created via "$ make-kpkg kernel_headers" for 4.5
kernel resulted in two differing header files with the same guard,
namely __LINUX_PKT_CLS_H:

https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4.5.0%2b/include/uapi/linux/pkt_cls.h
https://metameute.de/~tux/batman-adv/net-sched-issues/linux-headers-4.5.0%2b/include/linux/pkt_cls.h

The latter, the non-uapi version, has the "#ifdef __KERNEL__"
section stripped, causing the compile issue if it is included
before the uapi variant.

Removing this non-uapi version from the unpacked
linux-headers .deb package manually afterwards lets
a batman-adv compilation succeed again.

Daniel (CC) has helped a lot with debugging so far and he
expressed the suspicion that maybe make-kpkg might install
"$ make headers_install" into the wrong directory?

Regards, Linus

[0]: https://www.open-mesh.org/issues/322
[1]: https://www.virtualbox.org/ticket/15327

PS: make-kpkg was invoked on a Debian Jessie (kernel-package
13.014+nmu1).
