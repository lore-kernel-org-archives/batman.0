Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 19 Feb 2013 16:13:36 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130219151336.GA26780@pandem0nium>
References: <1361284606-17565-1-git-send-email-antonio@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <1361284606-17565-1-git-send-email-antonio@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: in recv_alfred_packet() add
 break at the end of the case block
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
To: Antonio Quartulli <antonio@open-mesh.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, siwu@hrz.tu-chemnitz.de


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 03:36:46PM +0100, Antonio Quartulli wrote:
> In recv_alfred_packet() a "break" statement is missing at the end of a ca=
se
> block and the function is returning -1 instead of 0 even if the packet ty=
pe was
> known. Add a break to let the function behave correctly.
>=20
> However this bug is harmless at the moment because the return value of the
> function is not checked anywhere.
>=20
> Signed-off: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  recv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/recv.c b/recv.c
> index 0170695..ffabba5 100644
> --- a/recv.c
> +++ b/recv.c
> @@ -416,6 +416,7 @@ int recv_alfred_packet(struct globals *globals)
>  	case ALFRED_STATUS_TXEND:
>  		process_alfred_status_txend(globals, &source.sin6_addr,
>  					    (struct alfred_status_v0 *)packet);
> +		break;

Applied (git rev 274133d)

Thanks,
	Simon

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlEjlp8ACgkQrzg/fFk7axaDYgCfT48YFFA/FURgb/VEADlN4UXR
ZmYAoNzVYBD9u38pDlt7huDmshRbs5Di
=BlQZ
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
