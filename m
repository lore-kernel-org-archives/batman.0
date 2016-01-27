Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 27 Jan 2016 11:13:53 +0100
Message-ID: <1988230.TvXLEl4ULW@bentobox>
In-Reply-To: <1453312110-32683-4-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2328265.UkrK26o2yr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
	in a different netns
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2328265.UkrK26o2yr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 January 2016 18:48:29 Andrew Lunn wrote:
> nameplace, so also retrieve the parents name space when finding the

s/nameplace/namespace/ ?

> Additionally, veth devices come in pairs and they are each others
> parents. Don't infinitely recurse in this situation.

Can we have this part as extra patch so Antonio can ask David for a stable 
backport?

Thanks,
	Sven
--nextPart2328265.UkrK26o2yr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWqJhhAAoJEF2HCgfBJntGVT0QAK9XPdLwiRmRVPzyVI8+A13V
tpThT+jFG61RDrFEY1WeRA4MS8BNCJKhx9bFbcvyP8uwqDL5toXz8jAJPmJxs1Tm
+ea1wnOLQgqFBpU06naE4spiqB57/Bk71WJ/Vibknsr7Doxt4RFYAOfRL1Tx21SK
SpORftvKXZNwBkl8dLz1TfXMAb8EIJJQ1Rhw0+WbkXIXdMrRmuWbVAJv2Ffe/gHe
DCQiWRUL9+1kPXFzIRl8M9tlNEWKxiYntMBYFPLdmmctgwsnMcLL14yupsQ3VGno
mR/ctyNdi/1sx5XqF1jWMtF2/aF1u9iMV1t/UQvh/M7inBqUDFwAmiZF0ulNOidq
QFLzoHzYea51bT252NLZuE+Hl7E86ITYs3g3o0boXZIFpOSaRvfhnpFd4YuIHoUT
g/KPN4pu6Y70REGaDQueB/KF6uH0TnksYzEohc9Lr4Y9T2P2p783NIpRlMDOcxs+
958xqNjaBkog8iiFp9fCx30qipZ+VNKH8dPpzLY+23RcW+PIdRv8rIq7am5Onj1y
SUh5bpMkMM9awpdxrwYDz6xBbe4f0CgD9/Y8D6jo/qnK6EmddXMKz5lPJHPVm2mN
8b1ggot3S3JymasV/QqFMcBo97UKolp2UwlIQ3WSOPGSzQ4PIQl+hNfDbt2aZ+KY
JB6kBhrZFZRajuX0QAlU
=HNUq
-----END PGP SIGNATURE-----

--nextPart2328265.UkrK26o2yr--

