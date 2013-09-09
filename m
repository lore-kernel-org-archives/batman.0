Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 9 Sep 2013 19:23:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130909172307.GG12716@pandem0nium>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
 <1378741567-25152-7-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Content-Disposition: inline
In-Reply-To: <1378741567-25152-7-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH 7/7] alfred: Allow to switch daemon
 between slave and master
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
Cc: Sven Eckelmann <sven@open-mesh.com>


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 05:46:07PM +0200, Sven Eckelmann wrote:
> The running daemon may need to be switched between from master to slave m=
ode or
> from slave to master mode to increase the efficiency of the data distribu=
tion
> network. This must be possible during runtime to avoid the data loss duri=
ng the
> switch time.
>=20
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
>  alfred.h    |  2 ++
>  client.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  main.c      | 19 ++++++++++++++++++-
>  packet.h    | 24 ++++++++++++++++++++++++
>  unix_sock.c | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 115 insertions(+), 1 deletion(-)
>=20
Applied in revision 06ce1cc with minor modifications (added newlines to
usage text).

Thanks,
    Simon


--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIuA/sACgkQrzg/fFk7axZ9EQCgi9REmn6P+BRa9gOSXSeM2Muc
zlEAoIAL0zJS7pEYSyUDteePP7vDzOvU
=levR
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
