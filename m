Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 21 Mar 2014 16:27:05 +0800
Message-ID: <2312292.LyzPD9iOC6@diderot>
In-Reply-To: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3111234.gE4qTDOtJz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next 01/11] batman-adv: remove useless
	goto
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart3111234.gE4qTDOtJz
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 19 March 2014 18:55:37 Antonio Quartulli wrote:
> There is no need to use a label and a goto for code that is
> used once only.
> Moreover having a goto for a single return statement should
> always be avoided.
>=20
> Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
> ("batman-adv: Multicast Listener Announcements via Translation Table"=
)
>=20
> Cc: Linus L=FCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>=20
> Changes from v3:
> - simply has_bridge() function even more
>=20
> Changes from v2:
> - added compat code change to 2/11 to accommodate new use of
>   netdev_master_upper_dev_get_rcu()
>=20
> Changes from v1:
> - change "we are out of memory" to "in case of memory allocation fail=
ure" in
> 3/11
> - fix commit message in 10/11
>=20
>=20
>  multicast.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied in revision 6f54268.

Thanks,
Marek

--nextPart3111234.gE4qTDOtJz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTK/fcAAoJEFNVTo/uthzAGJQH/3h7ZZbJkKysRqLq+VUM6+gw
CfviOEPFrnWtX47NIQzOukMiXatnLYNCNsYEz528rzmE1uJNZHTmP8mfZOZyTiKv
3vCK37kl6A1DjEHS2aeUTpXZc/bNPm4+cqhqTOF4NK2vnVNjr23rF9+exP5PEe6/
syfunl4UIC2sjYIL63ENpKFv1Yvo0E++u40wRttPC5coLWISvDVwBlbO9FfxEey+
3PhDnfF7DRM4zipUJhh/vi6bxNcrghW4NXTpa/QOIUHBdnTALgq23RVQbQT6wyG2
u8b3dyLr4mPMyuAOPJeGeFDSaFFHOyL2z3FaRC71RHWWumZ7Via9M4yszv5aNYY=
=CU/X
-----END PGP SIGNATURE-----

--nextPart3111234.gE4qTDOtJz--

