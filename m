Return-Path: <gmazzurco89@gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Date: Thu, 13 Oct 2011 14:57:49 +0200
References: <201110131334.59408.gmazzurco89@gmail.com>
	<4797016.P1FaBRmtyJ@sven-laptop.home.narfation.org>
In-Reply-To: <4797016.P1FaBRmtyJ@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110131457.49798.gmazzurco89@gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv version
Reply-To: gmazzurco89@gmail.com,
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

mmm
batman-adv openwrt version is 2011.3.0 that seems included in 3.1 kernel but 
latest kernel available in gentoo is 3.0.6

the other way to install batman-adv in gentoo is the gentoo ebuild but seems 
more outdated 2011.1.0  :|

do you think is a good idea to compile latest batman-adv and load it as module 
on my actual kernel ( 2.6.39 ) ?

On Thursday 13 October 2011 13:42:18 Sven Eckelmann wrote:
> On Thursday 13 October 2011 13:34:59 Gioacchino Mazzurco wrote:
> > Yesterday I have build an openwrt image with batman adv but i see that
> > this version is not complatible with past version, sniffing packets i
> > see batman adv v 14 instead of 12
> > 
> > Now i can update all openwrt nodes but the problem is that some nodes 
are
> > gentoo based, how to see the batman version and in what version of 
gentoo
> > kernel i can find the same as openwrt ?
> 
> There is a page which gives a rough overview about the compat versions [1]
> and the download page contains a complete mapping between kernel 
versions
> and standalone versions. We will _not_ create a separate list of gentoo
> (or any other distribution) patched kernels.
> 
> Kind regards,
> 	Sven
> 
> [1] http://www.open-mesh.org/wiki/batman-adv/Compatversion
> [2] http://www.open-mesh.org/wiki/open-mesh/Download
