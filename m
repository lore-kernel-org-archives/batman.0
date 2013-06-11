Return-Path: <ordex@autistici.org>
Date: Tue, 11 Jun 2013 16:17:12 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130611141712.GG1466@ritirata.org>
References: <1370932501-3937-1-git-send-email-ordex@autistici.org>
 <1370932501-3937-2-git-send-email-ordex@autistici.org>
 <1370959770.1954.3.camel@bwh-desktop.uk.level5networks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
In-Reply-To: <1370959770.1954.3.camel@bwh-desktop.uk.level5networks.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: wait for rtnl in
 batadv_store_mesh_iface instead of failing if it is taken
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
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, Marek Lindner <lindner_marek@yahoo.de>


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2013 at 03:09:30PM +0100, Ben Hutchings wrote:
> On Tue, 2013-06-11 at 08:34 +0200, Antonio Quartulli wrote:
> > From: Matthias Schiffer <mschiffer@universe-factory.net>
> >=20
> > The rtnl_lock in batadv_store_mesh_iface has been converted to a rtnl_t=
rylock
> > some time ago to avoid a possible deadlock between rtnl and s_active on=
 removal
> > of the sysfs nodes.
> >=20
> > The behaviour introduced by that was quite confusing as it could lead t=
o the
> > sysfs store to fail, making batman-adv setup scripts unreliable.
>=20
> I think what you actually wanted was ERESTARTNOINTR.  But the real
> problem is that neither of these error codes is valid unless the system
> call is aborted due to a signal.

Well, it should have been handled differently from the beginning..the other
problem was that ERESTARTSYS was propagated to userspace while this is not
supposed to happen.

However, with this patch the initialisation does not fail anymore. So we do=
n't
need to care about the error code anymore :-)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRtzFoAAoJEADl0hg6qKeOa2gP/1iZYohYNUv7z5pDnUVTlIF3
nw7R4M2tL872mcncCr4gdcs7TsyQ9RKgejyMKDKQ3FzcAOpZVBfLy+RHo0Eawz8S
S6Jfn9keau3kdkq/CqQiICK3ewMjQ2HhSC+9YiHk3d4Dhnpj9WhMtQrpYXfbGhrK
vcVhLzysGe/xpBU1epp+7GxLh76hRfsRoF6rvnb5aNwVA2Jkvf2Y7SEm6GKOdNsb
4MXkkC2FwqRtvAUr72MH/KQ7TzQ+s5kmlmuYT9qiN76y/GUDGgHrcQTbTMYVd1UO
i3J0NxyKvPNcd+L2OJNbIPylwVSn74IdTE4zDhwz7uFdFTcqeefVX4JG1CmS1J8I
/i1lfdTIvyaa6KLJt8rg+pqO3cvn3XPargpiBHInzSKwO07v17qjlIvg4y2se+W9
5OlHrj+7N3OpZD618t/WNvFF6CkIZ1JEN6GMlSH4KIH0eigZLOMOfalwku3xt8Hd
Mss37vITtpDw6c5zt+GxY4GyOfYpOsPuRqOnr3W3Op8Sn1LSH/foq00XE4zgSI94
fh3PSIkuAc/A1nfbYDCNZuXkPb0vRtMb6RW84NQ4nj3TGMoBg+TpF3SznNyM90bI
5qWMDuUrBw+s3xu0Q7tdnRf4KWWyYwcKuRBpKx1b/TL721/zE2Bpe08s35q/kQ7h
HR/zByHgs/iZqz9cT42P
=QAR+
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
