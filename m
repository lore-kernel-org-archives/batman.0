Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 17 Apr 2013 18:32:05 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130417163205.GA22685@pandem0nium>
References: <1365412636-26039-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1365412636-26039-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: change VID semantic in the
 BLA code
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Just a small thing which can be adjusted when merging:

On Mon, Apr 08, 2013 at 11:17:16AM +0200, Antonio Quartulli wrote:
> @@ -909,8 +910,9 @@ static int batadv_bla_process_claim(struct batadv_priv *bat_priv,
>  				       ethhdr);
>  	if (ret == 1)
>  		batadv_dbg(BATADV_DBG_BLA, bat_priv,
> -			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %d ...(hw_src %pM, hw_dst %pM)\n",
> -			   ethhdr->h_source, vid, hw_src, hw_dst);
> +			   "bla_process_claim(): received a claim frame from another group. From: %pM on vid %u ...(hw_src %pM, hw_dst %pM)\n",
> +			   ethhdr->h_source, vid, hw_src,
> +			   hw_dst);


This could be put on one line.

Cheers,
	Simon


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlFuzoUACgkQrzg/fFk7axbOwgCeLs81Lkx4B4W5OcWO9XzuZl9h
5IoAnAvA8HyWJhxZrGmzxLVLkW86Pu1G
=t4NI
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
