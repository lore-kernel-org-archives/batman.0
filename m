Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 08 Nov 2016 17:17:59 +0100
Message-ID: <14643446.7b3p1n7s48@prime>
In-Reply-To: <1637163.TC9CcXIrIP@sven-edge>
References: <1637163.TC9CcXIrIP@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2237193.vhmcgHuGmt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: Revert coccinelle compat
	support
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

--nextPart2237193.vhmcgHuGmt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, October 31, 2016 8:35:40 AM CET Sven Eckelmann wrote:
> Hi,
> 
> it seems that the coccinelle package in Debian Jessie is not able to parse
> semantic patches [1]. This basically breaks the batman-adv build on many
> stable systems and thus makes the out-of-tree module unusable on these
> systems.
> 
> I have currently no better idea than reverting these patches.

Commited in be1dd23..c941add

Thanks,
     Simon
--nextPart2237193.vhmcgHuGmt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYIfq3AAoJEKEr45hCkp6h/3UP/1CF4R4QVK+m9RDNGsWvSqKJ
i54yZ2bE6uX/ol/zzK4o6+deBKw5eK+4zCSlpuiXJ793VzzuiwffeThJyvGHRMpR
9aNkWChlmJqT1Sl0vWLs7bgVs1wEdFpuH/GkHIUnAkrNFBVJqXRIyTTfTf+PSyae
bS2btwqmAmunulMgqykPkNiYCSt4Mg2CcOIUoefStOayOp4u81K8TquxjJsKG7/J
ejvHeIYOpM2SzfTHoaDAsWfO2HgHWCC0mi3bnQik2DXwgYrJp10h1fkYepABv713
F6xbrjm0gw1U51SlKgcLZCcMec01wDae7TrUf0Sr1pJQLTiSD9jlbk+RcHrnAQJC
KPUdaDgn6FBgRcPQ5VoxCkwJ8Cvc6ZLcNXBUQAFBXaZNwEgZBpBx9VikgG2ZMPpX
TjbWPMLt3gxsfx8ZHghIANtZi7aiZYSTJJyznvxqyWSjnWVaShopM3PSiXrFNerw
iDg3xikVVKC5cW0q5hXbcKf2vFyaxAdMEmMqm35hqiolyUxrS2I2LN0UL8jfGiP+
AQDGqt2WQgq16aQ3kBbxcSpBofusFXS/7MSUxvnx4mVb4dz0mVZNft8lU/TnyWWK
DJJ0ztOheotT8ODn4ULa2VKTdL1I1UX20QbY/5CMjnAoW+mpKvCro8G8vV4y+YDN
ReqcBOJ6nAvdda5dQtgP
=N/hW
-----END PGP SIGNATURE-----

--nextPart2237193.vhmcgHuGmt--

