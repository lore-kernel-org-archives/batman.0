Return-Path: <mpa@pengutronix.de>
Date: Sat, 27 Dec 2014 18:03:17 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141227170317.GB10331@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
 <549EC29D.1070408@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <549EC29D.1070408@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 25/26] batman-adv: packet.h,
 add some missing includes
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

On Sat, Dec 27, 2014 at 03:30:53PM +0100, Antonio Quartulli wrote:
> Hi Markus,
>=20
> first of all you should know that I really appreciate your hard work.
> Thank you very much for this!
>=20
> On 26/12/14 12:41, Markus Pargmann wrote:
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  packet.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/packet.h b/packet.h
> > index facd1feddd4e..5fd0d814b6de 100644
> > --- a/packet.h
> > +++ b/packet.h
> > @@ -18,6 +18,11 @@
> >  #ifndef _NET_BATMAN_ADV_PACKET_H_
> >  #define _NET_BATMAN_ADV_PACKET_H_
> > =20
> > +#ifdef __KERNEL__
> > +#include <linux/bitops.h>
> > +#include <uapi/linux/if_ether.h>
> > +#endif /* __KERNEL__ */
>=20
> Unfortunately we can't do this :-(
>=20
> Patches sent to the kernel cannot contain conditional code on being in
> the kernel or not (same is true for checks against a particular kernel
> version - such code can't be in the kernel).
>=20
> Patches sent to the kernel must assume that they are only for the kernel
> (and for that particular version we are sending the patches against).

Oh, I checked by grepping through the kernel before changing the patch
like this.
	git grep "^#if.*def.*__KERNEL__" | grep -v include | wc -l
	145

So there are 145 uses of an ifdef __KERNEL__ outside of include
directories (I excluded include directories as they may be exported to
userspace). So I thought it would be ok.

> Of course this makes everything a bit trickier for us since we share
> files between kernel and userspace .....
>=20
> This is one of the reasons why we have compat.c/h in the batman-adv
> package: you will see that in those files we had to implement all sort
> of hackish/dirty tricks in order to keep the code in the other files
> clean (compat.h/c are not sent to the kernel but are part of the
> batman-adv out-of-the-tree package).

Yes I saw that. I still don't really understand why this whole out of
tree package is necessary. But I am wondering if it wouldn't be easier
to develope and build directly in the kernel tree.

>=20
> However, as far as I know, you should be able to simply do:
>=20
> #include <linux/if_ether.h> (without the uapi subfolder)
>=20
> and this should happily work for both the kernel and the userspace. Have
> you tried that? I might be wrong - it's quite some time I haven't used
> uapi headers.

Yep, that works for the kernel, thanks. However, bitops.h remains as we
don't have bitops.h for the userspace.

> Otherwise we might need to find a different solution - or live we what
> we have now :)

Yeah it works normally as the includes leak through other include files.
But I prefer explicit includes. I am thinking about some solution for
the bitops.h

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUnuZVAAoJEEpcgKtcEGQQ6qUP/RaZghIYQTxTOvwxNom/z+ej
ZkqWjAKacB5D4MKKrkS66YNoFVG61fg2oqafPHYmhMh0lVNuD3aSpEZVldKPX6ag
nqz0kdqD50L6xgkFlVRHEGGBTC1jRJITHV30gu14cRL5KF6ASlSrLZd0Zu9Bdghe
GoKAkdTtkN7es/I3sTlEjQ+EPeyBNmdke8w8QpJuzZ13oqhwovLIuGl10sxC8Q6A
Gheg9y24/yubAf0JFvhOZi4ShihRx5qI//z2HPWFYHMF3hpytdhYCLwPAZVhTykC
Rap9YLQOoXdphKHs/DCrqbBD4AFiCtHPmW9oLApJFN94A1mrKoJRCrG8xAjSLbW/
hHZ/wQtlGg414Fvmc2HsmLWMvnVrC4KIpbRW085JrTLfH/Ur65mnInv3JJz3nEDr
3laPfpvGKVEXsVo2IEnf8b+L5hRisIyknDcQUQgQbUWntRemATmyMIm5DZppkzx6
26w0Cxi1dNey1vkuTeNavVLjQ8wDgKPv+mfa3JgHwTcVGSN+Cj+OddM20a6clsWU
3E74VOfre7aBHg0thjF4beqdKBX+6QdjCicAkul9kzRu+mPmPRxyMLqTVvUMKV9r
shH3nXeC71VnhKOV3NbttNs7AQ+oXOKva5vwgXIWlDHGOXdx8Ju2ZpHkjpiJI6NK
bmnXUtj26bghFHODf162
=/gC7
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
