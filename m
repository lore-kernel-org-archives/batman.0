Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 10 Aug 2012 15:44:10 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120810134409.GA18045@pandem0nium>
References: <1344514526-30256-1-git-send-email-montik@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1344514526-30256-1-git-send-email-montik@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [RFC 0/3] GSOC 2012: bandwidth meter project
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Edo,

as discussed already, some general remarks:

 * please squash these patches to one - as far as I can see, the 2 others a=
re mostly
   fixes to the first one
 * Don't turn on debugging in the Makefile - we don't want that by default
 * please also include the batctl patch, it is important for testing

Thanks
	Simon

On Thu, Aug 09, 2012 at 02:15:23PM +0200, Edo Monticelli wrote:
> Hi,
>=20
> I have almost completed my Google Summer of Code project and I'd like to =
have a
> feedback from the batman community. The project is a kernel-space bandwid=
th
> meter, a lightweight tool to measure network performance between batman n=
odes.
> You can find a general project description in the project wiki page:
>=20
> http://www.open-mesh.org/projects/batman-adv/wiki/GSOC2012_BW
>=20
> Any advice is welcome,
> Edo Monticelli
>=20
>=20
> Edo Monticelli (3):
>   batman-adv: bandwidth meter implementation
>   batman-adv: sender retransmission counter
>   batman-adv: seqnumber is wrap around safe
>=20
>  Makefile         |    2 +-
>  Makefile.kbuild  |    1 +
>  bw_meter.c       |  531 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  bw_meter.h       |    7 +
>  icmp_socket.c    |   18 ++
>  main.c           |    2 +
>  packet.h         |   22 ++-
>  routing.c        |   15 ++-
>  soft-interface.c |    5 +
>  types.h          |   38 ++++
>  10 files changed, 634 insertions(+), 7 deletions(-)
>  create mode 100644 bw_meter.c
>  create mode 100644 bw_meter.h
>=20
> --=20
> 1.7.8.6
>=20
>=20

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAlECkACgkQrzg/fFk7axZn6gCfVbzAXsDLlQ+WdYT03O+9FAFY
GW4AmwWwGBG/vC3geE7Z/Q7S1YZ9grtJ
=kZOY
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
