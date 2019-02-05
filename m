Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 05 Feb 2019 18:04:51 +0100
Message-ID: <1851509.cZK8r6as2N@prime>
In-Reply-To: <1895931.G10psR3j26@sven-edge>
References: <20190119155626.6414-1-sven@narfation.org>
 <1895931.G10psR3j26@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart172156632.1EuqQE1ssQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, netdev@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>

--nextPart172156632.1EuqQE1ssQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 26, 2019 11:47:20 AM CET Sven Eckelmann wrote:
> Aggregated OGM is currently defined as:
> 
> 
> * according to batctl manpage:
> 
>     aggregation|ag [0|1]
>            If no parameter is given the current aggregation setting
>            is displayed. Otherwise the parameter is used to enable or
>            disable OGM packet aggregation.
> 
> * according to sysfs ABI:
> 
>     What:           /sys/class/net/<mesh_iface>/mesh/aggregated_ogms
>     Date:           May 2010
>     Contact:        Marek Lindner <mareklindner@neomailbox.ch>
>     Description:
>                     Indicates whether the batman protocol messages of the
>                     mesh <mesh_iface> shall be aggregated or not.
> 
> So sysfs is only one possible backend for the batctl command. There is 
> currently nothing which I would assume to be aggregatable beside OGMs but
> let  us assume for now that there is now something and some way to
> aggregate things beside OGMs in a save and backward compatible way. Let's
> call this FOO - so we have BATADV_ATTR_AGGREGATION_OGM_ENABLED and
> BATADV_ATTR_AGGREGATION_FOO_ENABLED. Or we have BATADV_ATTR_AGGREGATION as
> an  u32 and just use the second bit as marker for FOO (and of course the
> first bit as marker for OGM).
> 
> Would it now be more preferable to use BATADV_ATTR_AGGREGATION_OGM_ENABLED
> as  u8 (boolean) or to to switch to BATADV_ATTR_AGGREGATION (u32) & assign
> single bits to packet types.

I'd prefer BATADV_ATTR_AGGREGATION_OGM_ENABLED (as we have your patchset now). 
Although it may be technically possible to aggregate other things (e.g. 
broadcasts), I don't think this will be implemented anytime soon, if at all. 
And if we do, we can just make another BATADV_ATTR_AGGREGATION_FOO_ENABLED 
flag.

Cheers,
       Simon
--nextPart172156632.1EuqQE1ssQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlxZwjMACgkQoSvjmEKS
nqHR1w//ZXnTIOOEiq9ldBdn5wj/fY1Xawy83lPq8x3W7IeFdfxwzHWA3dnz7O/I
Hmt1/c7idoNCLGIhAuTH4sBHGmvf+tdVFX06vfUtcK4hDE+6D1r8ujlNAQWab6np
quoofnlURz7KfE/vY9p4XFpVoGg1CMSwjyw9qAYzjvx4J+5rdQvX/mzRwxYAtABp
YxOH62M8hrGc2xrH5JFn3SPvHte0XDEwkEyDOl7t1EaVcIR4RAgKHp08PyR3/YyE
i/YE1j7/hEBAEyIQUo7wdBGfs7NaFbiyU4B3dyLUWHRZB9nL+LO70UQjS+B3HoMp
ydt/HuyqNupSR8E5hCkHGxPKH6T+2oPVv79MESi87KPqgQn+JpzwFdynGRrHCXVR
T+m3ILMftMg7FvSi/1JLIJhLMyV7Gs6j784CqnSZ86ljfQBTPYvaq8ii1iAwMA6v
rY3gO2s+EtDZ7WhyMu7UtvM4HnjJ/InnXE/NNKpWqvblEpC1HuqygSHWVKkL0v51
gjEe+6hU64o10+ePu8fSUJMUlfoAmx/du5GWtXSkFKJLDJ45xcnMloRIDwlb2aNH
VBz+dOnvEc3qtG7dm/0qdNHMVK/KxmiaCEfKV8Vc75Nle9Vt17bNq3E8VGoUpnkZ
45ZHx6XOmA0k2sIlJ6rVACsii0o3QjC1sK1r+oW1KmkmJAj+K5U=
=Vu+P
-----END PGP SIGNATURE-----

--nextPart172156632.1EuqQE1ssQ--

