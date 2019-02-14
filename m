Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Feb 2019 00:16:31 +0800
Message-ID: <2119814.DADNbvlFmJ@rousseau>
In-Reply-To: <20190214155100.10070-1-linus.luessing@c0d3.blue>
References: <20190214155100.10070-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5621251.52MJTOeceK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: allow snooping gratuitous
 ARP Replies
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Daniel Ehlers <sargon@toppoint.de>

--nextPart5621251.52MJTOeceK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, 14 February 2019 23:51:00 HKT Linus L=FCssing wrote:
> So far, gratuitous ARP Replies were ignored for DAT processing as it
> contains a broadcast MAC address. This patch changes this and allows
> snooping such ARP messages, too.

> Gratuitous ARP Replies were ignored since this commit:
> ab361a9ccc5 ("batman-adv: filter ARP packets with invalid MAC addresses i=
n=20
DAT")

You're kind enough to mention when the filter was introduced but fail to=20
explain why the filter introduced in the past was has outlived its usefulne=
ss=20
or how the new behavior addresses the  previous concerns.

Cheers,
Marek

--nextPart5621251.52MJTOeceK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlxllF8ACgkQU1VOj+62
HMCAGQf7BLlhdNYY6YXI8nJNH37neE1dX+6TPYkG8dtSs6N74IKXckT5G1OVifSg
ByUZg7eHWyBH9zsZzhOzcxl9xoqK5UbKmdXxCIjlehkHVXUPRPEiSLqtrT43zXxP
MD3sAEeVQfBo4xcTGVYvydm8t7akL95lOm5j02/L9CiU7D0EaCRkRh1AJtyGRhQd
2msQj8guJSeI+yf2u/jp/+V+Gv0lVeyOLroNI/FusIgCdzX3QZjRPK4BO2ezT3jK
v3JN1GL+SDmT+jY3PQTdpayOjxgJfA5WGRefYJy9ru8mlgiVcs4k9Uvh8PjLl8AL
mXOTAKqhWc9Csbvefci3FiYzcD3dOA==
=FHf4
-----END PGP SIGNATURE-----

--nextPart5621251.52MJTOeceK--



