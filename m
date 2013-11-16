Return-Path: <antonio@meshcoding.com>
Date: Sat, 16 Nov 2013 11:43:10 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131116104309.GK1663@neomailbox.net>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
 <1384360685-366-3-git-send-email-antonio@meshcoding.com>
 <6858187.HqJ4FjDvbE@diderot> <20131116091108.GJ1663@neomailbox.net>
 <5287431F.2000205@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <5287431F.2000205@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/6] batman-adv: mark a local client as
 isolated when needed
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2013 at 11:04:15AM +0100, Martin Hundeb=C3=B8ll wrote:
> On 2013-11-16 10:11, Antonio Quartulli wrote:
> > On Sat, Nov 16, 2013 at 01:31:11PM +0800, Marek Lindner wrote:
> >> On Wednesday 13 November 2013 17:38:01 Antonio Quartulli wrote:
> >>> @@ -474,7 +474,7 @@ static void batadv_tt_global_free(struct batadv_p=
riv
> >>> *bat_priv, * Returns true if the client was successfully added, false
> >>> otherwise. */
> >>>   bool batadv_tt_local_add(struct net_device *soft_iface, const uint8=
_t
> >>> *addr, -                        unsigned short vid, int ifindex)
> >>> +                        unsigned short vid, int ifindex, uint32_t ma=
rk)
> >>>   {
> >>>          struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> >>>          struct batadv_tt_local_entry *tt_local;
> >>
> >> Kernel doc ?
> >
> > argh, I tried to escape the kerneldoc tradition :D
>=20
> We should make a patch to checkpatch to check for kerneldoc :)

why not :) we can have "per-path" rules. So we can specify our rules for
net/batman-adv/...Thanks for volunteering!

Cheers,


--=20
Antonio Quartulli

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSh0w9AAoJEADl0hg6qKeO9iQP/2WzHPxymoL63w6Dr2Jqy2+b
CLdshQr9EHsp61KbY6XtEs4dy6N7G4bFusz436GnZn6Ua8oucn8KZf668h+0gnNT
QmNdk7nQNneGjHfiChbKKxgCfAKRFHXqT9fTmg7UvAquvfn8jfJ2C/FLasP+VvSI
zou4/oy8/vYkXkzaT7eZxRhFxkWoR3Wjrmx/7AsmE0kDkQMMjS5TgfONVLl5QJag
/r0J1CG8uXrn3b8GaVkxLZhpXO5xT5YISy56ImjT0OeeGj5V5KSkE0Dmm0Fmxu5R
UzOa4LEDW9NsXQrZ7nP9r328egyoL1roOBkG9HRHSBlkCQ6DYsJpiNxnG2hRitXp
Gj4lMRcdfIlC2eW9cADr2AtWqVieYgav5AWgKWjcqm8qwdZL3v2bzUO4qVeYXYgU
arJwGh/1IkXJVfnc0ebKrKV8qqJWM84IzIWUW9p3+nrHcXNMC4prTkw6/H7NmTqP
a09la5bWaXtsVqHDYVavz/v+fMsFTAFr15P8/uyR7CoiCJW+D9goNYQ2SuZZpt/L
pZB81BjA4nsjyaecK3boo93iVe/qy+tZE7D/Cd8ZjG7IdOFinS9Tq8owSGdcvFh5
aeX2dEC/e2t8Wm8kTt8PzhjA093BH4uVDO0hKZhR0+icznMV1hmDpc/RpyJcmoQB
mzkjZFvI6P/ZN0B1TzDC
=nxvw
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
