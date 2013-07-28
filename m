Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 28 Jul 2013 21:53:01 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130728195301.GB3746@pandem0nium>
References: <CAKEO+ThzTfEKT_20E-z677iUaxOzsLUV+c9scskBZ2asRSN-8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <CAKEO+ThzTfEKT_20E-z677iUaxOzsLUV+c9scskBZ2asRSN-8Q@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Important warnings from alfred 2013.3.0 release
 source
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


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2013 at 09:10:33PM +0200, Braden Aran wrote:
> Hi,
>=20
> I get following important warnings when compiling alfred 2013.3.0
>=20
> unix_sock.c: In function =E2=80=98unix_sock_req_data_finish=E2=80=99:
> unix_sock.c:261:7: warning: ignoring return value of =E2=80=98write=E2=80=
=99, declared
> with attribute warn_unused_result [-Wunused-result]
>   write(client_sock, &status, sizeof(status));
>        ^
> unix_sock.c: In function =E2=80=98unix_sock_req_data_reply=E2=80=99:
> unix_sock.c:187:8: warning: ignoring return value of =E2=80=98write=E2=80=
=99, declared
> with attribute warn_unused_result [-Wunused-result]
>    write(client_sock, buf, sizeof(push->header) + len);
>         ^

Thanks for bringing that to our attention ... yes, that should be fixed.
This might become a problem if an alfred client is not reading fast enough =
and
there is too much data who fill up the internal socket buffers. This will
probably not be too problematic now, but might become later. :)

Would you like to propose a patch? Otherwise I'll probably fix it soon ...

Thanks,
	Simon

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlH1dp0ACgkQrzg/fFk7axYIFwCaA/x15yrPDaUO+nqWj/RL6OtG
JsEAoMUfu4/4kBt6oQr6FEHhr01Y0AlK
=Zzo1
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
