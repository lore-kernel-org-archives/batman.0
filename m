Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 1 Oct 2012 23:06:50 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121001210650.GB15826@pandem0nium>
References: <CAK+uisD5AddOnF+o5U4LdFu+7CAnNCJna8wBZL1huHqZyeLOfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <CAK+uisD5AddOnF+o5U4LdFu+7CAnNCJna8wBZL1huHqZyeLOfg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv on ethernet
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


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Donald,

please don't do that, at least batman-adv will print a warning:

You are about to enable batman-adv on 'eth0' which already is part of a bri=
dge. Unless you know exactly what you are doing this is probably wrong and =
won't work the way you think it would.

batman-adv won't send any batman-adv frames (it checks for its Ethertype),
so batman-on-batman is filtered out, so that is not the problem (can happen
in other scenarios as well).=20

However using an interface as bridge port and something else (batman-adv, I=
P,
etc) is just wrong in any case and will most probably lead to unexpected be=
haviour.
I'd strongly discourage to do that.

You may want to explain your scenario, maybe we can come up with a solution=
 together.

Cheers,
	Simon

On Tue, Oct 02, 2012 at 09:53:08AM +1300, Donald Gordon wrote:
> Hi
>=20
> What happens if I add an interface to batman-adv (on which to exchange
> mesh frames), and add that same interface to a bridge with bat0?  E.g.
> on an openwrt, br-lan contains eth0, bat0 and wlan0; batman-adv is
> exchanging mesh frames on wlan1 and eth0.
>=20
> Will I end up with BATMAN-on-BATMAN or will batman-adv filter out the
> batman frames it sees on bat0?
>=20
> thanks
>=20
> donald
>=20

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBqBeoACgkQrzg/fFk7axbWHQCdFIyCgxjbxkTb6IAaZhMIPOHD
BgsAoL6Jwp1mQSnftD7yFEs2b4o/+AYi
=LYNk
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
