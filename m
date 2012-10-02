Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 2 Oct 2012 11:37:13 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121002093712.GA18558@pandem0nium>
References: <1347712461-9031-1-git-send-email-ordex@autistici.org>
 <1349124808-15995-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <201210021316.40830.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <201210021316.40830.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: dirty hack to recompute
 mac_len in the rx path
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


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Marek,

On Tue, Oct 02, 2012 at 01:16:40PM +0800, Marek Lindner wrote:
> On Tuesday, October 02, 2012 04:53:28 Simon Wunderlich wrote:
> > +#define skb_share_check(skb, b) \
> > +       skb_share_check(skb, b); \
> > +       if (skb) \
> > +               skb_reset_mac_len(skb)
> > +
> > +#endif /* < KERNEL_VERSION(3, 8, 0) */
>=20
> Has this patch been tested ? Our skb_share_check() call is this:
> skb =3D skb_share_check(skb, GFP_ATOMIC);
>=20
> Now we replace this function call with 2 function calls and 2 return valu=
es ?

I have not tested in a real machine, but only the first function will
return the skb. The second part is a separate statement. I've checked
it with gcc -E (preprocessor only), these lines in main.c will expand to:

 hard_iface =3D ({ const typeof( ((struct batadv_hard_iface *)0)->batman_ad=
v_ptype ) *__mptr =3D (ptype); (struct batadv_hard_iface *)( (char *)__mptr=
 - __builtin_offsetof(struct batadv_hard_iface,batman_adv_ptype) );})
                       ;
 skb =3D skb_share_check(skb, ((( gfp_t)0x20u))); if (skb) skb_reset_mac_le=
n(skb);


 if (!skb)
  goto err_out;

As you can see, the skb =3D skb_share_check() statement stays at it is, and
the reset_mac_len() is done afterwards.

Cheers,
	Simon


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBqtcgACgkQrzg/fFk7axYwqwCfXIpTeqUPrkiwnzzJxCkI/66F
MREAn1Oi11lP2z4QezZ63WZVXJC1hnF1
=vmgj
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
