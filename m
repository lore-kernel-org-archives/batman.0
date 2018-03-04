Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 17:41:26 +0100
Message-ID: <3744465.nJcBpx8pQg@sven-edge>
In-Reply-To: <20180227081016.13122-1-linus.luessing@c0d3.blue>
References: <20180227081016.13122-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4273957.lTyZPo0Oj8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add DAT cache netlink
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

--nextPart4273957.lTyZPo0Oj8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 27. Februar 2018 09:10:15 CET Linus L=FCssing wrote:
> +       if (nla_put_u32(msg, BATADV_ATTR_DC_ADDRESS, ip) ||
> +           nla_put(msg, BATADV_ATTR_DC_HWADDRESS, ETH_ALEN,
> +                   dat_entry->mac_addr) ||
> +           nla_put_u16(msg, BATADV_ATTR_DC_VID, dat_entry->vid) ||
> +           nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
> +               genlmsg_cancel(msg, hdr);
> +               return -EMSGSIZE;

Just found that there is a function to send IPv4 addresses=20
(BATADV_ATTR_DC_ADDRESS) to userspace: nla_put_in_addr. It requires that yo=
u=20
provide the IPv4 address in __be32 format and not in host format.  It is ma=
ybe=20
a good idea to use it and keep it more consistent with the rest of the kern=
el.=20

Don't forget to also adjust the batctl code (remove the htonl).

Kind regards,
	Sven
--nextPart4273957.lTyZPo0Oj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqcIbYACgkQXYcKB8Em
e0Ymew//Yf2O0waFaIWgVHNl66Kqrs8Qi9Ftk9Pzhkwh1Js5c7bDIiG52XEKdVk/
Yj7bdrNlEDlD01diG1a9cdtbC+kLF7z0F8vnnMJPsulFbTG6cC86eOqelFcYRJ+q
/51Pbt7JFqEDiN+LSei5BKDuUebb/hxY1UpyZSepbIQFjCXgswyGtmHcsqwknq8N
29D0mCloAyOoyZD65xrX3gqc3v3TKzemQqXXiXimE0+0eSQFr3hrcvj29jRuRk1H
A38hKKs2eaFiLNjzuTAcc0HBxJdntnCjoBDJLhpVRBbzrWyWyYimJALK8n0qCCvk
NugmM2Je/5zGjJO7yV/izmrCupTRYYxWiKT56v3QjuxzzFY4Oq4nZODNEqA8Z8uo
nBDIPBTI+1i9bO6JS/JX7+j63T+UepD4XJz5ZGQ6lzkMJzQDRSex62GLgTdCU6EE
ijDbECPG2Ixvbf4P/59ShMDUbeX7+g5ofDCV/dZYwSOpikFBwX1jr/J6XmJdksBE
LjB4fJEGkFpLWNNRaetdR39X7l1lf8xKjLkatYs6YHlByVmMSWyztZkIQIF25Bvk
HKgosqnDyaPpQmJT/dcGG3c52qoQ5+7ModQsS2arMJ5CM+n+ztfZ3tlgjJn1G65X
9gw6Jkro5oqm3QkoSNV94F+h171QTiujY4aaW8n5VhlwITPaepQ=
=weus
-----END PGP SIGNATURE-----

--nextPart4273957.lTyZPo0Oj8--

