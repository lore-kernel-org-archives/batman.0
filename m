Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 19 Apr 2013 18:18:47 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130419161847.GA30846@pandem0nium>
References: <1366387621-12718-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1366387621-12718-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 1/2] batman-adv: change VID semantic in
	the BLA code
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Antonio Quartulli <antonio@open-mesh.com>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri, Apr 19, 2013 at 06:07:00PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> In order to make batman-adv fully vlan aware later, the
> semantic used for variables storing the VLAN ID values has
> to be changed in order to be adapted to the new one which
> will be used batman-adv wide.
>=20
> In particular, the VID has to be an "_unsigned_ short int"
> and its 4 MSB will be used as a flag bitfield, while the
> remaining 12 bits are used to store the real VID value
>=20
> Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlFxbmcACgkQrzg/fFk7axa9FwCgzbl5edljNonpExc9ub5/bGV1
UXwAoKrSm3RZxn9CguMrkpzzakHVlJ4T
=tFUY
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
