Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 14 Oct 2016 15:33:29 +0200
Message-ID: <3064838.z1RyzPRFv5@prime>
In-Reply-To: <20161013090310.9619-1-sven.eckelmann@open-mesh.com>
References: <20161013090310.9619-1-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1653172.ix56Bl4dk7";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Keep order of interfaces from
	commandline
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1653172.ix56Bl4dk7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, October 13, 2016 11:03:10 AM CEST Sven Eckelmann wrote:
> The first (valid) interface mac address will be used as source mac for an
> dataset. But alfred added the commandline parameters for a multi-interface
> master in reverse order.
> 
> Keep the list in the same order as the commandline to fulfill the
> user expectations when checking the source entries of datasets.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>

Applied in revision f21f747

Thanks!
     Simon
--nextPart1653172.ix56Bl4dk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYAN6pAAoJEKEr45hCkp6hpcAP/1T7q3mLDE4NNIBEH8i1QdnT
8yXioKRJ+/jyzDL2usJDdYzIKJa2oRywmbzaG0cThVvXnLu/wQVAUqLXUzFIuCMJ
nnohms2ZwtsDg4MyuHCHsAuuKL2pDgiE2i3Zml0olGxdljBIeoK7OXxsWmWUYJdC
dR3X2yWUTFxD1Rjsh0aM6/3ZHs5AXoV3BHfZ70wZXbZ4XVzwGESj11/WpuWdGDha
oQGviAxLGEDNGqgNQ4RydnvDsYgLwS0lUCdhvDOjdoGei7i5vepe4yA3XQQ8M4dm
vQ9/ydkuUT22GVC/qvOIMb8DH5qhjgmJXioFfMh+htgqz2GAoFhHLy2S77+1lXcD
sSm+umWimvrEpLw+J8lBHWyMYJwuDt76nrCncccF6yG3zuVje+7caSDfJyRVkBCT
/EY01nbEHKKl0aWjzEMqeVT8zJu1d0vTrIfWaXeeL1szv53pg38iw/NJW9ya6fJ3
lLrDApAL0dCNvWGoRyQ9ncrFvS4MCzKHDb/wJ2tFYNgoLewbmjkVUC7Qv2gkUBNA
dHEi3soNaJmfrzPgGQIVpFfflGGVbK10wDczzz4Iv8TsgGhIGFwyIolPzp7ePVLS
dYUxN2IyKgssDchALEQUIynwFZ4CjoJRCprxSVxUrTChlyN5vLRUHRekzNjZY8Di
oOcFyf0/eLvxQlGus1Rg
=K7IE
-----END PGP SIGNATURE-----

--nextPart1653172.ix56Bl4dk7--

