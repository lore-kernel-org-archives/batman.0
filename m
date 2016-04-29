Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 14:59:21 +0200
Message-ID: <13794357.HqoOAIfBmV@bentobox>
In-Reply-To: <20160429121427.GB4053@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1580619.BbQOVpWRpd@sven-edge> <20160429121427.GB4053@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9748751.GRvadz3E6O";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Handle parent
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart9748751.GRvadz3E6O
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 14:14:27 Andrew Lunn wrote:
> On Fri, Apr 29, 2016 at 07:52:42AM +0200, Sven Eckelmann wrote:
> > On Thursday 28 April 2016 22:37:19 Andrew Lunn wrote:
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
> > 
> > You are unfortunately reverting back to an older version of the patch
> > which is harder to make compile on older kernels.
> 
> Hi Sven
> 
> Please point me at the version you would prefer.

Partially this one: https://patchwork.open-mesh.org/patch/15921/

I know that your current submission doesn't contain the compat-patches part
(which I find rather ugly) but this version has only a single function
handling the batadv_getlink_net and thus could be easier to create some wild
#defines working around the compat problem on older versions. But it will most
likely end with a warning and being a big NOP on older kernels.

It is something like (untested):

    /* WARNING dirty hack for batadv_getlink_net */
    #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
    	#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
    #endif

It is the version of the "share your drugs" hack from earlier compat hacks.

Kind regards,
	Sven
--nextPart9748751.GRvadz3E6O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI1qpAAoJEF2HCgfBJntGe6QQAJVNzX2n343aLAGxFqq0thaP
WRuNeTJHVpcCLe1l0oYahzBEwPqpQ12tEm/P/aMPWBh5cuU/7PTnSoWsBxuZxLDj
eBHvAPC2V750udAOMyhlchnkNg2necLPj/nmLvu0SwH7udEs6090pIQa4U1TgsKD
ttj6yeq1xiIpn6hTL/gg3j5hfwosmGZBAMMYTvfwM2UWw6CxDSNe+TnNWx39alRd
HbWQhtR5qF1UzPiU88J8JYk82PCkj4FlcCbrKFQOHgfT0WIA7yNuVVrJz4OYq5Qd
st/I3DooFkcB5zTFSpBtrI7WbXoOyNTiKwkM+XfZFpwuWniJLm5O5Wddu6lT7bhf
xlGEtAFtHpI+vfyezbYGw4YWRCceotzSkcr6yo/+0DufDrvC+//0QQ1vvoNjNy/M
A/WiCDP7jXahrDqF/k5WWEQ86yKEZinaMUbMIaF1fJr8l0GRx7DW3hTxHECuBfWz
Csw7Va3iw6Z8ePhfLXbIfTaiZCeYygunyFLLVKGlMrCVnyutuCmCDiBZVyNhK7zy
4wTXAMxPf7h7ezc4QSGc0MAiac1OU4BWwnnNGozHHPysN7i+6ZyYCmArKySVXbyN
mq8ptw1MZ7lIgeMMqmja8l11sKkKjbIUlnR1pOUgfy9x3HcfvGaRqvD9fYkYgF/L
mqVdBAkOiwxPfm6GV06C
=+NKr
-----END PGP SIGNATURE-----

--nextPart9748751.GRvadz3E6O--

