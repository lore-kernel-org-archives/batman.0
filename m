Return-Path: <onelektra@gmx.net>
Date: Fri, 16 Mar 2012 18:51:15 +0100
From: Elektra <onelektra@gmx.net>
Message-Id: <20120316185115.6ef5d0f2565bf89f4ec709c3@gmx.net>
In-Reply-To: <201203170034.59126.lindner_marek@yahoo.de>
References: <CABYe4MeeMfsLTM7stwwz1bikHtGsP+7ytUbbiz-ipMLJxuCHkA@mail.gmail.com>
	<CABYe4MeCJTf6L3ZgvhveqRX8Pm1RpG1yHODCnfx7wW1z=dah1w@mail.gmail.com>
	<20120316172727.67b623974207c4ac772ccaf1@gmx.net>
	<201203170034.59126.lindner_marek@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Meshlinux Download Link - Error 404
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi -

the wiki already stated quite clearly that this project is old, outdated and unmaintained. The only "new" development is that the link to http://zolder.scii.nl/~elektra is broken.  

http://wiki.c-base.org/coredump/MeshLinux still works and has the ISO image.

The wiki now reads as follows:

MeshLinux

Meshlinux is outdated and really old. The project hasn't been updated in a long time. It is unlikely that anyone will take up development on it again. We recommend to use OpenWrt for X86 platform.  The only purpose we can think of today is software archaeology or the use of very old legacy WiFi hardware.

Nothing is as outdated as old software. Meshlinux was created in the early days of mesh networking at the Freifunk community in 2004. It is a CD-Image that can be used to convert old PCs into wireless supernodes. There is a old Meshlinux version based on Linux (Kernel 2.4.26) available at (http://wiki.c-base.org/coredump/MeshLinux)
This old version is based on Slackware and not maintained anymore. However it works nicely with old Atmel USB wireless devices (which is a problem nowadays with recent kernels), Prism-based Chipsets and Orinoco. But you won't find any modern mesh routing protocol implementations in it. If you want to build a meshrouter with nothing better than a 486 CPU and this kind of old wireless devices because you have them lying around and want to do something useful with it, you may still use it and install a recent version of Layer 3 B.A.T.M.A.N. - you can download a statically compiled version from this server. You can not use Batman-advanced, since this would require a recent Linux kernel. Some userland mesh protocol daemons like OLSR might still work with it.

Sooner or later this information will be removed. 



Cheers,
Elektra

