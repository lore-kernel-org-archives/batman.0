Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 28 Jul 2013 21:44:14 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130728194413.GA3746@pandem0nium>
References: <CAKEO+ThRiXtRyek2AJBbfkgwzJODSDn7mOSiVLLRfww=kfE_tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <CAKEO+ThRiXtRyek2AJBbfkgwzJODSDn7mOSiVLLRfww=kfE_tQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] A.L.F.R.E.D.+vis manpages missing
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


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Braden,

thanks for your feedback!

On Sun, Jul 28, 2013 at 09:02:36PM +0200, Braden Aran wrote:
> Hi,
>=20
> it seems the A.L.F.R.E.D. component and his vis is getting released
> soon http://git.open-mesh.org/alfred.git/commit/fac591b6d8a8a9eaca33a0d76=
14433cbca23f55f

Actually, alfred was just release a couple of hours ago, although the
announcement is to come soon after.

>=20
> But where are the man pages? Don't you think it would be nice for
> people when they can read how it is used in a standard unix way? At
> least they need to use it because this functionality is removed in
> batman-adv soon.
> http://www.open-mesh.org/projects/open-mesh/wiki/2013-07-29-batman-adv-20=
13-3-0-release?version=3D1

There is quite a lot of information in the README to get going, but yes,
a manpage would be great. If there is anyone who could contribute one,
I would be very happy, if not I'll write one myself prior to the next
release.

> I can't find the manpages for both binaries in the tarball
> http://downloads.open-mesh.org/batman/stable/sources/alfred/alfred-2013.3=
=2E0.tar.gz

There won't be one for now. Please stick to the README for now.

> And isn't the name vis potentially problematic and bad named after
> all? "vis" doesn't tell anyone about the connection to batman-adv and
> it sounds more like a GUI program to visualize stuff (mathematical
> equations?). And it clashes directly with the vis of batmand. So I
> cannot install both on the same system in a unix manner.

I don't know if it sounds like a GUI program, we have used that name
for years in the various iterations and no complaints so far. The
clash with the old batmand-vis is true however. I'm not sure if anyone
still uses that, but I'm open to suggestions how to handle that.

Is there anyone using the old vis? I'd appreciate any ideas, discussions,
comments. :)

Cheers,
	Simon



--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH1dI0ACgkQrzg/fFk7axYttQCggCNOLUgO6M/WAjQI84xqwPF1
1fIAoOYk6wpvh+aCBfH+87EcKfn7o8FS
=dk+W
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
