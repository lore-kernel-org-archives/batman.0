Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Apr 2019 12:48:14 +0200
Message-ID: <2195799.xoe8fjgBhO@sven-edge>
In-Reply-To: <20190407103702.30435-1-linus.luessing@c0d3.blue>
References: <20190407103702.30435-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1858257.jOoLZtUsC8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 0/2] batman-adv: increase DAT DHT
 timeout
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

--nextPart1858257.jOoLZtUsC8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 7 April 2019 12:37:00 CEST Linus L=FCssing wrote:
> Hi,
>=20
> This is the third attempt to increase the DAT DHT timeout to reduce the
> amount of broadcasted ARP Replies.

Doesn't apply with git-am. And the line:

   .policy =3D batadv_netlink_policy,

doesn't build anymore in net-next.

Kind regards,
	Sven

--nextPart1858257.jOoLZtUsC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlyp1W4ACgkQXYcKB8Em
e0barxAAhAFBs6Ug7yZc1mt7qijBAN6OYQypj9eT7IdVi79+EDcD1A+7CVnQEwt/
ItSZulzTRDp89PqhFnfmQ5szicB6uIdr2re+XBGObPM2yrRDHZsl/X8wyH0Tqv42
um4xngbodWoga7egEFcP6N3O+L3swYf6BpxOfnK5NxMYeQEumMkVKfGchXR83+gq
q69LWgAfabSnEBt/rgA6SXKQ252YXzREzGyzdSdhzTGCYs/Nmwq0hYYaVitnrGU6
H59QE7HgcZgnTh/4XvuzE/QUTE0XeXv08LdNKUdBef/5DLQzfu2h0OsqZLA0d3Si
9TBdp1p5DG9IkHazYdSItE3Lldn7pWoN+4IjkifrOZga6A8vXS5uo2PAm+jsxEaa
sQ48lxBqiy+FDgzrNo5g/iIxHuKMys0UXe/fYMvGxC76CUzVeuj7kNWikANHzIJs
7T307hTRMjITV9pQDypC3dX7sIe9o2/q+42Z5+G0lrRE8LZv+sDo44yxGT6vRQOk
XHT57W6R3RB5b3Vdrhwd9KJm5/2Yvd5NMJmpsO2iKRft1iZlfvj/I4nzj/47PreQ
uv0CNT3BrKcvLMSG6hian3cy653E7fb5HHpjq0YTMigmmp8ER5qakBSQ66JSpDAL
U0/fwP/KuvIDwy1YPvP7jiQpcttteJgKE9XdZC0BqhkMCNijVGk=
=c3jG
-----END PGP SIGNATURE-----

--nextPart1858257.jOoLZtUsC8--



