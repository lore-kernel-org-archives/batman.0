Return-Path: <ordex@autistici.org>
Date: Mon, 15 Jul 2013 09:52:15 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130715075215.GA3491@ritirata.org>
References: <51E35AEF.1070600@wirelesspt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <51E35AEF.1070600@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] wpa/wpa2 adhoc + batman-adv not working
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: OpenWrt Development List <openwrt-devel@lists.openwrt.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2013 at 10:14:07PM -0400, cmsv wrote:
> Tested with:
> Attitude Adjustment r37270
>=20
> Batman-adv 2013.2 (current stable release )
>=20
> I have tested wpa* and it is currently not working with batman-adv.
> The ssid for the mesh is encrypted but batman-adv/batctl is unable to
> see/ping any nodes.
>=20
> I tested with wpa, wpa2 and without encryption.
> without encryption i was able to get the other nodes to join the mesh
> and have them communicate with each other.
>=20
> I believe someone has once mentioned about a patch that was related to
> this problem and i wonder if it is already included in these software
> releases or not and if other people are experiencing this same problem.

Patches for making IBSS-RSN (WPA2 for ADHOC) work correctly are still pendi=
ng on
the hostapd/wpa_supplicant mailing list...I hope they get merged soon.

If they are not merged in the upstream hostapd, I'll try to push them to
openwrt.

Also a small change to mac80211 is required (this has already been merged
upstream)

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR46ovAAoJEADl0hg6qKeONxwQAIPChn0j+tJIBAGz/b964UkA
uAunb5HopXC5lOXLIoF8bShUZ0iusN82PCfSwmeaN+yFznOuixy+5Eyqs+qrWqvv
T4WwZ4vb4SfJa0WShrARU4Mw+GGx1r7Eq+KcGKzYzMoaHYXdoyPbHQVFqpJNxzF2
CNvZvN5H2UjHrk61SmN1d8okJ2wQegMCClPTQRHqOThvyJNMJsFTUfBKhQd/+EJj
v4jexf2elSTFSR2Y1h3zBz02KvitpnAiMN9u8H1f1MLj+7nlvMmpe1t1EkQII4qS
jwOOPLd0WQFqw1bRQU1BArsPXLSky9X+tVDLzBY6ExrNlcZFiJWZnaoP6tSwjtou
P2VE1/vxN1NcfM4a/UvI/Neal38vLJr/kY2WVmnOKo5rQUxOY40CT71USfP7k0ZG
duufQEUfypvaoIvVbs8yv/3zgGBaN5q7r44N+ltxJWv6V2bZ4yXwFXheNuwMsIfS
ZawuTW6F/6krVM/2V5uJMbmIK6PMKcSuZpXsJ3QOYLeiavy+QlUTiw8LCmlV9DrE
Xq/CIGV7zuxWENk3AxPmR4bQf3z9dtNTtOLHOZLhdu1BW/tHdps2/BSg3z+hQvuV
ewxHN1bAzPmztStiNcG7yxFlrCxmZZOXEtTMgrMjtKWVf34VxsDVrFmm6mJR0eTT
qs11FA01aI1WbhfEqoGx
=wa6x
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
