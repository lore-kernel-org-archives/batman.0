Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Mar 2016 08:17:46 +0100
Message-ID: <1852174.4KT7d4xAq4@sven-edge>
In-Reply-To: <20160313224047.GA14976@lunn.ch>
References: <3465881.llCNFeNLl4@sven-edge> <20160313224047.GA14976@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9171430.TDn8nQeNsI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/6] batman-adv: Add network name
	space support
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

--nextPart9171430.TDn8nQeNsI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 March 2016 23:40:47 Andrew Lunn wrote:
> > v3:
> >  - Added new system to add patches to the build (in case the build against
> >  an>  
> >    older kernel is not possible otherwise)
> >  
> >  - Rearranged the retrieval of the link netns
> >  - Rearranged the retrieval netns id for debugfs
> >  - Fix header includes
> >  - Add compat-include for linux/ns_common.h
> >  - Add compat-patch for netdev->rtnl_link_ops->get_link_net
> >  - Add compat-patch for net->ns.inum
> >  - Fix alignment errors
> 
> Hi Sven
> 
> This all looks good. Thanks.
> 
> Which old kernels does this support? Has it forced some old ones to
> be dropped from the supported list?

I have only tested to build against kernel 3.2-4.4. But it should still 
support 2.6.29 (untested).

Kind regards,
	Sven
--nextPart9171430.TDn8nQeNsI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5mWaAAoJEF2HCgfBJntGvbMQAIuKgJ8i57emvUUYGWwoJXSh
2qHQOTodnjAT73JNXOUBB4sD7V0uPr7rN5bkMG3RboAHNioNj4n5zNopW+NeQkkA
bI+z1qHU+IZkwzgImjQG5Wo6bIKhXYj+HXAQ3Dr9x5/P7092XzCN62rCy4ib+MCU
c5idsgpPvWoKSCURZ8a+0qo+g4jD6xtXwPLcCmI6ZC+YoVFQ1x2y0BT8GgOhYZAM
UxljO9ScnTTsk0e6eoQdvo8k+a3N301T3CRaUoukzBX4a3Mq1MteJ9cqbykWo3zP
dcCplPbF/qY8qGAeUmb5spcWPwSKqtOcl6DrGFXsGjytpEyz+6CE6GAnkq85DUaZ
twA9PGz1gUGJAEeYzAKNpaG1ICBeA9tOSFW72XFQ7tgu6bMtR+veD2JIWAXd/6b0
FIyq6grn9xA1IIioxR66heaA7fklL33bsXZ6eXb3tQ3O9qagHfTD/OISELWRKYMC
sDoMDBBXJewiL3yDKVEl5GO5zzPZz6aFwzKeR2wBAKgq7Wb0K2zOpS9To8XK/B7Y
jmxANhFuOi6QzW7DeRSWfoYz3a6quLKmUlRx5QABTZvypjPhmnGNkD0ad6aDf3+q
I2qNLyRg6p70LKQvCezFXm1GSL/w94nuZwwKC/EbAFw44mkLKduEINySqBgfBpig
WgczX26mU6r8v/joffdq
=ANZ9
-----END PGP SIGNATURE-----

--nextPart9171430.TDn8nQeNsI--

