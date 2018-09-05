Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Sep 2018 18:06:24 +0200
Message-ID: <6769424.zgFbfVuIz9@sven-edge>
In-Reply-To: <20180831130844.5434-1-sven@narfation.org>
References: <20180831130844.5434-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6246751.Rcxx1L4ber";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Avoid probe ELP
 information leak
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

--nextPart6246751.Rcxx1L4ber
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 31. August 2018 15:08:44 CEST Sven Eckelmann wrote:
> The probe ELPs for WiFi interfaces are expanded to contain at least
> BATADV_ELP_MIN_PROBE_SIZE bytes. This is usually a lot more than the
> number of bytes which the template ELP packet requires.
> 
> These extra padding bytes were not initialized and thus could contain data
> which were previously stored at the same location. It is therefore required
> to set it to some predefined or random values to avoid leaking private
> information from the system transmitting these kind of packets.

Added as 6c876e572f59 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/6c876e572f592c31132a55b5fb8427e168e5fb3c
--nextPart6246751.Rcxx1L4ber
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluP/wAACgkQXYcKB8Em
e0bysRAA1XMX8l+xkBMMgZBzrX2VPYiG1a/QNhv3j/+XPOMxgdh/3UzjsSL+eFL6
y832jyY+gt2eyLo5UtqsHA+h6PvSeAd7bndLzJf406tf/8OWWw3iyn9p7jq1Cf+1
x5q7dbFQ851Gb22+nkmSV/acsFTBEpqY+ZRzTON2wFvlkDNyX+thur6MSjMxKhT2
cTmic4tJk8qaOxR2x6OmFD99Ewd+nqeyR19EalvfZmKCubE3j4DReKUDrGKpuZbG
waWdL+Fk38GevvlKmSpqPrSaGwXr8YlQAWZjHU5VhfI6OQY/hiu7Q/NpRCaHyoG8
02TZxdObMGt904WlXuiouhfRoh40Wktr+AvG9E8ouezynWNS/CcNtv5BhAhGfIaQ
kD1JJthIZqGfaHvKokbaSTpSNy10YVorDgAcT/8/MTUjD/WPPHgXyEnjcULH5Hhw
5IoQNCRgu0Vq5bJ+Tph6Zg9zaGIIZS+o0tT2eEX2bfSF624LOr16XjF6UvNMsXck
FKTNKY8tJeNhu7IKG13MD/M4hidvClql3LUDCNPCuqdGAHetCzvK2MGykZYIi4Gn
t8QPaj3qUXch+MQUp+xLmNX6yAWeZl2Xg7BDUmzc3I5OPK+maGvzJN/Tba61szBa
aJfDcd+7x0q3A0PQMgEhPAFG7Apdh1QagOUflCbxE6Nmxss5Tig=
=lpl/
-----END PGP SIGNATURE-----

--nextPart6246751.Rcxx1L4ber--



