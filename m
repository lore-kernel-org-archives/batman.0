Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 1/2] batman-adv: BATMAN_V: introduce per hard-iface
 OGMv2 queues
Date: Sun, 04 Aug 2019 20:29:04 +0200
Message-ID: <10033691.AcQlIsoWXg@sven-edge>
In-Reply-To: <20190804180632.489-2-linus.luessing@c0d3.blue>
References: <20190804180632.489-1-linus.luessing@c0d3.blue>
 <20190804180632.489-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart65207975.omPGRG4tHD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart65207975.omPGRG4tHD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 4 August 2019 20:06:31 CEST Linus L=FCssing wrote:
> +static inline unsigned int batadv_v_ogm_len(struct sk_buff *skb)
> +{

Please drop the inline here.

Kind regards,
	Sven
--nextPart65207975.omPGRG4tHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl1HI/AACgkQXYcKB8Em
e0bQVRAAwX8zbHEGy5luT1IP5rR0NpYfo7r4UY699FMUNdQe2zpgo4szzY3MhVtP
GK5Zu6LytyaagXxb9SuwaMeo1YWqGEMPU8nmE3Ay+uxLuHYksqMcPI3KbYyQO+mT
ogU77hxv1/7+mrd1T6kc2i+7eAoeVpV3v2Qqq4zQYLxv5ZVKKD/FxCUbcL6c7OF2
1lQf5LVqf3kiaTKboF5FKgVmZ9bKUVik92cunVWnshwxquwjK7yBs62fiXBriDqW
dU1oHkLsruVMY3SVrTX90SrRQE/0liU5ynpg1RfwVLk8uGe0gL0gSuSFNuZMen0f
hCKNWK96ZuU597Ufw8Jp/3nefZX+UA2oXMxI83NM5gtaILH2Er2IJRgl55Daxa2D
O9hM/NPLZ9Ypo0Hx4m0tye/poDLEgP4QeDzoJbemJovjnUNGrgmCeXvXCrkYJ74I
PpBdJCtTsuC8Jwx8Fy1wDs49DcNrc0o5kJo61z9vMEvrKs7BYQdRVUQOiTrCJ3kQ
JoF+lo+7FMoeXBiaZMmLNvB9R4c2lJbdWII5Kg+GVgIT4zpzT+stmQ7//OlCMTk2
5oWHQh6E1KbL9+8N4RT+/mR8givV0UTFylMD6zhkxll2UQskHLjQ8de3Z7GxHbpu
RbVpklxwEceMMyPQ3lq34e/jSmfOTsEfy1L1KlhlTJ9OvxpCmhY=
=0X7u
-----END PGP SIGNATURE-----

--nextPart65207975.omPGRG4tHD--



