Return-Path: <antonio@meshcoding.com>
Message-ID: <54D4BF9C.5010409@meshcoding.com>
Date: Fri, 06 Feb 2015 14:20:28 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1423153373-17033-1-git-send-email-sven@narfation.org>
 <54D46C8C.2040800@meshcoding.com> <2688831.HMc8mZG1gy@bentobox>
In-Reply-To: <2688831.HMc8mZG1gy@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="86xD4Raw0UJsTenMj4Fi6UEgsJjTjNerX"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use safer default config for
 optional features
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
--86xD4Raw0UJsTenMj4Fi6UEgsJjTjNerX
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/02/15 13:38, Sven Eckelmann wrote:
> On Friday 06 February 2015 08:26:04 Antonio Quartulli wrote:
>> Could you please be a bit more specific about the issue you are talkin=
g
>> about?
>=20
> I can only talk about the simple two node installation I had when I was=
 forced=20
> to write the wireshark-batman-adv dissector for v15. I just placed them=
 next=20
> to each other and tried to ping the other one (not sure anymore if it w=
as the=20
> node directly or two other devices plugged in the ethernet port of the =

> devices). And I think there was a reboot of one node and a ARP cache fl=
ush=20
> involved. I've expected to see the 4addr packets when capturing on the =

> wireless and then having both nodes talking to each other. This was not=
=20
> working. I could only communicate after disabling DAT... but of course =
the=20
> communication which I wanted to capture wasn't happening.

Thanks for the explanation Sven.

To me this looks like the caching effect of DAT: bat0 is likely to
change MAC address everytime you recreate the interface (unless you
statically assign the MAC) therefore I presume that the other node (the
one which did not reboot) was still caching the old bat0 MAC address
(each entry requires some minutes before being invalidated/refreshed).

This means that any communication willing to contact the rebooted node
was targetting the old address and therefore the two were not be able
talk until the cache was refreshed.

Can this be the case?



Cheers,

--=20
Antonio Quartulli


--86xD4Raw0UJsTenMj4Fi6UEgsJjTjNerX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU1L+mAAoJEJgn97Bh2u9eTV4QAMJ18q7fIg08a+cb2/66LSMT
pNJz5BoqHxviAAtKuVzTGoP46r3hxKGA8SeZWgc+ehLr5ZQG/YDf4yHOJo5V5Qvn
E+oXTbqbL+SFiszNqDYgwhyq1DJyK2+e3qd9hixwiIZ97ZPochVCqELgDnip1YRJ
K0QamtvQxpEGKizKtw0e12xF+HCie25JLC/r/91SUIZvj7wvyFirQnFt3zVUa7YD
H7AznK9SWYSwTPgjPNba0mMDn30EQOjpI7fyj2jiTcGYfHHk6GHfiZWczxvhNTTR
4acXp0G+uaHcnmUCfKqo37zLv1CH6oVe4i7qGmWQ3UY9lBORTcUA6Ft0VIT5rlcc
wsaXiAchBYb1sRJ6QuaQbd8dAjuxRmUmrRm50koZM35Anop984Ir1N/GVUZwBf/I
Vst0Cs45dtbUO8KVAzvWUuUiv9YQ0W1C43SmDG5joY7GeEnBACUwVtvEALdEascu
oIeWX6wkmY7zFVxlqHTiZej68W6qb1ov917zjOKleJ43Z7TcE71WzQcqre9tinSn
1ou3UgUedyLQoYpnNUB+wvleU+GrUYGbjI+SLEtMCAtY8hS75wSh0G2Kjni1fKg5
KphG1j5tedMk/ovoot6vwjqrxDfxwIW9S3HvNP5hu/o232XaF0RD+DHW59buN+9k
l4WZx4qwT9MCSE5bZC8c
=0SE/
-----END PGP SIGNATURE-----

--86xD4Raw0UJsTenMj4Fi6UEgsJjTjNerX--
