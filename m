Return-Path: <a@unstable.cc>
References: <1451992006-13191-1-git-send-email-sven@narfation.org>
 <1451992006-13191-20-git-send-email-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <5693D351.8010708@unstable.cc>
Date: Tue, 12 Jan 2016 00:07:45 +0800
MIME-Version: 1.0
In-Reply-To: <1451992006-13191-20-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f0rBkE5Td4HMWjc4bT61hqkPJm53jVArB"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 20/31] batman-adv: Convert
 batadv_dat_entry to kref
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f0rBkE5Td4HMWjc4bT61hqkPJm53jVArB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/01/16 19:06, Sven Eckelmann wrote:
> batman-adv uses a self-written reference implementation which is just b=
ased
> on atomic_t. This is less obvious when reading the code than kref and
> therefore increases the change that the reference counting will be miss=
ed.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Antonio Quartulli <a@unstable.cc>


--=20
Antonio Quartulli


--f0rBkE5Td4HMWjc4bT61hqkPJm53jVArB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk9NRAAoJENpFlCjNi1MR+hUQAIQ+Jq73UvX+q+TIEahUCYTh
9OdupnsLF1UX+Dq8P0LdbpfCw2tMJFnUMNIUV02plZjqEarDg2aaUgscpujwbIDN
EWKwvpajNJFHLIRQFdZXE9mCWISTqCFSkei2XfRVKMRT+ik5z6RoewexYk9za9lY
nD4UVscFXeE8T/Swu3IgzmdUqojUJb9rTFIR6+YKBAwKx7VPT5k8U7IbsnWm2P1X
14j01gveiGebXFi0EQDnOJQtDO8G8bgT1q3dkXKUS4hSWi7eGQ1+qsX4ksvo5RH5
WO7cCXcJLt5NH1MrqvKsaYbOIMmLZ8MB1Vlx4hJArSvuzeSE5OTUU+aSk3AH5PEv
XejpOjq5ktWIdm1EC56zE74RgwR11YWmbmIdR7DO+cI4Q/eyp0v6fVCco667P/2H
eKfv3GcyhJnxsfwGr+bsID4VZ9Mj8ZYherVVox3zwc5t3C9L+SBCPJCikgrGVzWz
2HoLcmy5Zpf4WHaVPZ8wchyWg+5C7YHNvv6uXBfbWI+d/9BjLDam07sZQUaG3/QZ
cwZETR8nbLMYPAGAy+is4Uqy+Q84OpIpWwpEvErRJgVWhD0fKH0x10JMnxGOl2z7
WgDcTKdquE0ej+uZh7dsq4g2pUN9pcqi7L8S2xXYxN/ll4ua+uKuMWIAf7HU4a6F
QsF7/4kMei1r2DujdLtb
=L0ps
-----END PGP SIGNATURE-----

--f0rBkE5Td4HMWjc4bT61hqkPJm53jVArB--
