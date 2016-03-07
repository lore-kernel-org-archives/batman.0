Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 Mar 2016 15:45:23 +0100
Message-ID: <2628096.3OTlO1qax0@bentobox>
In-Reply-To: <20160307143130.GB15541@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <121426826.jDACy89axc@bentobox> <20160307143130.GB15541@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2046204.feIz2xlyM5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
	interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart2046204.feIz2xlyM5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 07 March 2016 15:31:30 Andrew Lunn wrote:
> On Fri, Mar 04, 2016 at 01:35:01PM +0100, Sven Eckelmann wrote:
> > On Tuesday 01 March 2016 22:19:07 Andrew Lunn wrote:
> > > batman-adv tries to prevent the user from placing a batX soft
> > > interface into another batman mesh as a hard interface. It does this
> > > by walking up the devices list of parents and ensures they are all
> > > none batX interfaces. iflink can point to an interface in a different
> > > namespace, so also retrieve the parents name space when finding the
> > > parent and use it when doing the comparison.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > Acked-by: Antonio Quartulli <a@untable.cc>
> > > ---
> > >  net/batman-adv/hard-interface.c | 31 ++++++++++++++++++++++++-------
> > >  1 file changed, 24 insertions(+), 7 deletions(-)
> > 
> > Include missing in net/batman-adv/hard-interface.c
> > 
> >     #include <net/rtnetlink.h>
> 
> Hi Sven
> 
> How are you determining this? It compiled fine for me, which is my
> usual test.

https://git.open-mesh.org/build_test.git/blob/a246d227882b7bc03ae602b41cf65053397f9cc8:/checkstuff.sh#l311

> > 
> > Does anyone (not only Andrew) have a proposal regarding the compat code?
> > Patch 1+2 should be unproblematic (maybe these can already be applied?).
> 
> I've not much history with netns. One thing which might be interesting
> it know, is when did it become mature enough to the usable? Maybe for
> kernels older than v4.0, deny that netns exists, and find a way for
> functions like get_link_net() to return the default net.
> compat.h could contain
> 
> #if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
> #if IS_ENABLED(CONFIG_NET_NS)
> #error Network Namespaces not support with this vintage of kernel. Please disable
> #endif
> #endif
> 
> You then know everything is going to be in the default namespace for
> these old kernels.

I think it is a good idea to deactivate it for too old kernels. But it
will explode in everyones face when build against the distro kernel.
But maybe letting some of the functions "fail" for old kernels might
be possible.

[...]
> #if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
> #define dev->rtnl_link_ops->get_link_net true
> #define dev->rtnl_link_ops->get_link_net(dev) init_net
> #endif
[...]
> #if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
> #define init_net.ns.inum 42
> #define net->ns.inum 42
> #endif

These defines should not work (I haven't actually tested them but they
should not work with all the . and ->). The preprocessor should fail
because it ends the preprocessor macro name with init_net and then
doesn't expect '.' to follow (only '(' or tab/space).

Kind regards,
	Sven
--nextPart2046204.feIz2xlyM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW3ZQDAAoJEF2HCgfBJntGfg4P/juYBQohBMIKSykF8oKQx4wc
zKAn8Lyyar9FlMTzxLD+lNGTdxVa/qS3zvekoq6pf1CjCvRHpjRKB/9tThV9LgAE
qeNFEtNAaw74eVQQ+9t9kBsS5gxrX3kNDa7COnRhPDdvA6PXFtg1VdNfrh0Nu904
7og2HHHXL1deHb1L/O1OStkMTeo5Lc+G2IFyxfq11DkC7E9iIDLNh7BnuYZHu2t7
ZjnPS0S/R/xjypAXmAAqPz2ZIPRzgfP1qBGGZbscOjzjGw8ww8aRR34/1xapnSl1
Q3V2eKvVAOGhdxbHm/ZGgRDZnicx6EFxUv7vd3S0l56tv6nPPldjHToR67cr9TXt
YAx/S03s2bUXGOxs6Bg8hH6vJB4Qe7wk709LrAYUbTsogoMx+ADL3g1w8tjxtsVr
ckLbZcstAg2/OnBvmhVixIBVlxyhzSrJFYIBnuQmZ2lrmqG5eULbb4XLcHzn4qIL
9eQVK0GX92FSx/HKbtqQes+uawFcSnC4EGK0XrPcvXyWAhNbk6r46hsB8F5k21ez
A+DQHg0NlIpAYxA1WuBuMMNPgh4pHTKJPZ3utcpV/npizkgtWEFLKVDps630EnaA
CbQp1j65XxpmfytwUB+lKTjCYrEvB0MMTVlJhwmM4FJxZRp8U/92Nvs+buKRkNSq
2fxfzjl5P9Z3mr5aReJh
=9/Dl
-----END PGP SIGNATURE-----

--nextPart2046204.feIz2xlyM5--

