Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 9 Apr 2012 00:38:49 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120408223849.GB10101@pandem0nium>
References: <1333832769-28493-1-git-send-email-ordex@autistici.org>
	<1333832769-28493-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <1333832769-28493-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix comments ending style
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 07, 2012 at 11:06:07PM +0200, Antonio Quartulli wrote:
> @@ -732,7 +732,7 @@ static int handle_claim(struct bat_priv *bat_priv,
>  }
> =20
>  /**
> - *
> + * @bat_priv: the bat priv with all the soft interface information
>   * @bat_priv: the bat priv with all the soft interface information
>   * @hw_src: the Hardware source in the ARP Header
>   * @hw_dst: the Hardware destination in the ARP Header

guess this line was duplicated by accident ...

Cheers,
	Simon

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk+CE3kACgkQrzg/fFk7axa/qgCfafIGsXREzC1KyxUOc/+ZcW2w
F3oAnjxjEXHDszNs+WbE5eU0gfcmmmed
=Q5oO
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
