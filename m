Return-Path: <a@unstable.cc>
References: <20171129095042.12587-1-sven.eckelmann@openmesh.com>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <a1a9b230-a53f-4b1c-1494-0f472aea21d2@unstable.cc>
Date: Wed, 29 Nov 2017 18:36:27 +0800
MIME-Version: 1.0
In-Reply-To: <20171129095042.12587-1-sven.eckelmann@openmesh.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3wx3jrW8CWpNOO4dgjKPmOpsoWhTolwtN"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix check of retrieved
 orig_gw in batadv_v_gw_is_eligible
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven.eckelmann@openmesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3wx3jrW8CWpNOO4dgjKPmOpsoWhTolwtN
Content-Type: multipart/mixed; boundary="xx1cTXQEUebsJCiLEG3ABlVPDvVls03QA";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>,
 Sven Eckelmann <sven.eckelmann@openmesh.com>
Message-ID: <a1a9b230-a53f-4b1c-1494-0f472aea21d2@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix check of retrieved orig_gw
 in batadv_v_gw_is_eligible
References: <20171129095042.12587-1-sven.eckelmann@openmesh.com>
In-Reply-To: <20171129095042.12587-1-sven.eckelmann@openmesh.com>

--xx1cTXQEUebsJCiLEG3ABlVPDvVls03QA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 29/11/17 17:50, Sven Eckelmann wrote:
> The batadv_v_gw_is_eligible function already assumes that orig_node is =
not
> NULL. But batadv_gw_node_get may have failed to find the originator. It=

> must therefore be checked whether the batadv_gw_node_get failed and not=

> whether orig_node is NULL to detect this error.
>=20
> Fixes: 80b2d47be2c7 ("batman-adv: B.A.T.M.A.N. V - implement GW selecti=
on logic")
> Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>

Acked-by: Antonio Quartulli <a@unstable.cc>



--=20
Antonio Quartulli


--xx1cTXQEUebsJCiLEG3ABlVPDvVls03QA--

--3wx3jrW8CWpNOO4dgjKPmOpsoWhTolwtN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloejasACgkQB6U8WA7y
zXQKzhAAjbFqAc5FNv59ojIbmji5Z1WIQFgQEv1wY1mHy3rKVsmP0//xtuc26s/y
w8esutxtLaEEwCep2uReFjeBlxy6VV6FfAmW7RMmgT0xWCrnyUKo15Pga9i3bgop
vwAcdarzN4sV9NMmBorXfKoJxjPReLPgSlr5MwYrir2vYiSMHzWLxlbS0J4H4R10
xJo4R+w9lxxvIYAXhnYIjk3GG/H+AdivK9iSSg2PgD9jL7aUpT3C0oLigE9aVmQ0
uDR/qo4PhMA31n5gyaFW6EHNKISaJwM425vhTpxzyDJvYAoH81drGMknpzHSbkwo
QW9GSxCsBLA64zFIC3gWIiy766Na+YD/eHB/TpXtDWJHBM+2rFc5/M3J8E97E4BQ
etOFHXUhJPg3gY4JH0i4XjEILU2JCx6ABzflTBj8aidUT0QccFEvSBojMsSJnbnM
Ymx6sstaJQM9SVdEZwUigZ7v6w1x0kZ7PQtRZSbt4gPL3gIW9nTgGnItCzjh/vP9
Rnqm+JOrWz9dpoLb7ezkmtxccwG3y3UyqFV3DmJrDXSsvX34wR88Bc0sNQBOz+M0
3jyaGno4I3qnVhv4LDIn53k8Rda1IzWsol3Ep8amWMVNW8mZGiSA1faZuIPNcXrP
1pEMSgT3eODv6Li7iiKxfCfhHsP21eDI/Yp5cE8ndOq8PBT+tAA=
=BeDk
-----END PGP SIGNATURE-----

--3wx3jrW8CWpNOO4dgjKPmOpsoWhTolwtN--
