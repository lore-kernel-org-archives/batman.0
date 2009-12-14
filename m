Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 14 Dec 2009 23:25:50 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091214222550.GC2155@pandem0nium>
References: <1260471657-25962-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <1260471657-25962-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] [batman-adv] Remove NULL pointer
	check	before calling kfree
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

thank you, applied in svn revision r1493.

best regards
	Simon

On Thu, Dec 10, 2009 at 08:00:57PM +0100, Sven Eckelmann wrote:
> It is safe to call kfree(NULL) which makes this extra check unneeded. It
> was found using checkpatch.pl from linux-2.6
>=20
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  batman-adv-kernelland/hard-interface.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/hard-interface.c b/batman-adv-kernella=
nd/hard-interface.c
> index e9cb977..28d02f6 100644
> --- a/batman-adv-kernelland/hard-interface.c
> +++ b/batman-adv-kernelland/hard-interface.c
> @@ -399,8 +399,7 @@ int hardif_add_interface(char *dev, int if_num)
>  	return 1;
> =20
>  out:
> -	if (batman_if->packet_buff)
> -		kfree(batman_if->packet_buff);
> +	kfree(batman_if->packet_buff);
>  	kfree(batman_if);
>  	kfree(dev);
>  	return -1;
> --=20
> 1.6.5.4
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksmu24ACgkQrzg/fFk7axZ+AgCg00/Fvs/ElwWlTneccJbS3DBW
D50An192TITSvLioGz9Llwn7ax8vn2ks
=ZkxL
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
