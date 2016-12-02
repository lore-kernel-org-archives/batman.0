Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 02 Dec 2016 10:22:11 +0100
Message-ID: <2904592.QTHgNB2zL4@prime>
In-Reply-To: <20161130204709.16257-1-sven@narfation.org>
References: <20161130204709.16257-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1564855.pMcn1FGhG8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Check for alloc errors
	when preparing TT local data
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
Cc: a@unstable.cc

--nextPart1564855.pMcn1FGhG8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, November 30, 2016 9:47:09 PM CET Sven Eckelmann wrote:
> batadv_tt_prepare_tvlv_local_data can fail to allocate the memory for the
> new TVLV block. The caller is informed about this problem with the returned
> length of 0. Not checking this value results in an invalid memory access
> when either tt_data or tt_change is accessed.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in 9890c9f.

Thanks!
     Simon
--nextPart1564855.pMcn1FGhG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlhBPUMACgkQoSvjmEKS
nqFqOg/+MgVwCeOn8HDmcfyHQzw8/7YyBCcU+m1w1TR4zv71uO/w3PxtDRiQMLbb
iyGBHJ5NSYPWgZMi62jpJdrAFj4axINg6w6tQ3kL/gvsod1T7US8d99YteMU2mGQ
bVwc9r6pvMGhqQEt4VLkxdVorGN8nxWTev0ORQBR1Bd7N+23oYe1hEOrmnxxrGxp
WCVSA5Nt/fYwOUOxBKu96tj6qtthzaX1CyRDY6rZjK8Hf4B8o6iYwctIajDXlJlF
CVjgMMoicwt/FnzyRUGS/EtEF1o4T0QSxdHSKjU2Z8gHUrOZhFKIHpE3VS09CoSm
gtbUKYPn0TvavOv5gbqs8zOTl9QAIXgjNP4P7H6RSRb0y9ZYDZd4JAcCy2Y0M0aL
pBIX8yWMzx9vby7AufzJMDNiytx3f+hQLtSaMvVOkcoCvaMO0vOIfUoMue/rHQQq
CMUrfsdL2Ew4+73WB5j1Dhnf0et7U71j8IpPmUYp2bjMR3U3O4jsGCA1Z8+LzCJs
lPA6mg4GkMBYdAHCWqSj4CQoJCtUkAeGKZJ0sY9NFVrZLh4uZyDZ9hOKMRlQ/Yhw
sO5vI6uzHBxCAB7wJsR1EyIMQ7HNquNzeSbp+0o8pTFThFPUJMhpn5tIC3vK0uYG
2jI4y1dYBL/lyMmUGzu3FtEfzBOYdmV+Yg7z1TT5WMGyVsCe/9U=
=Riy8
-----END PGP SIGNATURE-----

--nextPart1564855.pMcn1FGhG8--

