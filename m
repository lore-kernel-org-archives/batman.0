Return-Path: <a@unstable.cc>
Subject: Re: batman_v default throughput
References: <dc998970-a36c-cbb5-8de5-2ed2a3833d57@web.de>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <44509c82-e60d-c94c-e686-faf08e0ec875@unstable.cc>
Date: Fri, 9 Aug 2019 10:26:24 +0200
MIME-Version: 1.0
In-Reply-To: <dc998970-a36c-cbb5-8de5-2ed2a3833d57@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pMny40ZXftePLb0kM9PvM3pVhEKYqg36i"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Moritz Warning <moritzwarning@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMny40ZXftePLb0kM9PvM3pVhEKYqg36i
Content-Type: multipart/mixed; boundary="o6l2p4jw4F9qTmghCwgmIO0WpsW4p06bF";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Moritz Warning <moritzwarning@web.de>
Message-ID: <44509c82-e60d-c94c-e686-faf08e0ec875@unstable.cc>
Subject: Re: batman_v default throughput
References: <dc998970-a36c-cbb5-8de5-2ed2a3833d57@web.de>
In-Reply-To: <dc998970-a36c-cbb5-8de5-2ed2a3833d57@web.de>

--o6l2p4jw4F9qTmghCwgmIO0WpsW4p06bF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Moritz,

On 08/08/2019 23:05, Moritz Warning wrote:
> Hi,
>=20
> the Freifunk network in Ulm has a batman_V network of >80 nodes. [0]
>=20
> For the map, we use the link throughput value from batman-adv to calcul=
ate a link value (capped at 40 MBit/s for 100%).
> The default for VPN connections seem to be 1 MBit/s - when batman-adv d=
oesn't know the throughput from the driver.
>=20
> Is there a way to the set this throughput or can batman-adv measure it?=

>=20

I think we discussed this topic in all its details (with Marek) during
WMBv10, no?

However, if you need to refresh the concept, you can look at the
function that takes care of selecting the throughput:
batadv_v_elp_get_throughput() in bat_v_elp.c


The function is invoked for each neighbour/link across a given interface
and can be summarized as follows:
- if any throughput_override was set by the user for this iface, just
use this value;
- otherwise, if the iface is wifi, ask the wifi stack for the
expected-throughput (computed by minstrel for ath9k and other SoftMAC
drivers);
- otherwise, ask the ethtool module if there is a known link speed for
this iface;
- otherwise, if none of the above worked, use the default throughput
(1Mbps).


As also mentioned at WBMv10, Marek and I had worked on a patchset that
enables the tp_meter to measure the speed of a link, when no other
throughput is available (i.e. for VPN or other virtual links). The
patchset is still pending here [1].

We suggested you to manifest your interest about that patchset, so that
the discussion could move on, but it seemed you were not motivated
enough (at least back then).

Maybe you could take this chance to revive that thread? :-)


Cheers,


[1]
https://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg17833.htm=
l


> Thanks!
>=20
> [0]: https://map11.freifunk-ulm.de/meshviewer
>=20

--=20
Antonio Quartulli


--o6l2p4jw4F9qTmghCwgmIO0WpsW4p06bF--

--pMny40ZXftePLb0kM9PvM3pVhEKYqg36i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAl1NLjMACgkQ9FVsWUWD
Dm1J7g/+MMIZ7MKbzmLTwJe3NJz6+yRrkpUO0XzTD6QYzK1GQfPOYFYrCvGn7p1j
TMynLJyeNN1+xAk/W59F1mp8xrUQ13eOTxu+6kztxJcrADqjgnE6siWs0vKuVtdB
ZFQHmiil+w46QrlBWEUgQDk0m73r2XHSGCeNGOPQYqOogzlg4v4hHu5nI7TM6xQU
eVzROr2UBH5mqNdnp2QjTMQp/pR6vx7wWJuTWpdNKD2IW0s47QpKTjFB3A0F4rYG
wKdCBN9lZO/ALHAxW0g6so+RYnWOViZrZ8NDNSiw5b3zCo6j8RvZbkcSi3HMf5CG
1fA6nPoMZH7NzD9CJt7/IqfO7r870OWL7MEXN6a//CRIUVi0CgXFJNuFeaoPbbse
ySF6rprW7ir2O6VX1dxm5Fnkhx53qDVoZ0FRiP3O+IyzB8ce1etkKacHhE4qd4mQ
wfkMNnQ1F729+N3bLXBRXLjw/t3gffO38Cqr5f3AMgImW9tNEohRbhNKBxL3+VIf
nYVutnM4qdJLn5SkQimTDTgJLAYA3jrRm8vrYIvZPYLdZZ1gbj0QQW6t6iGA7Gc1
wmtHVCy82V/J42OPUA10E5eLiUJRboy7nK1zQquEtCws1QplODoPIpTFCGkxZ0kq
/+MUdOoDEBCvYpzU7/2hPea6O7f5rRW2NXlRKR3WstcUI050qHE=
=csha
-----END PGP SIGNATURE-----

--pMny40ZXftePLb0kM9PvM3pVhEKYqg36i--
