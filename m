Return-Path: <mpa@pengutronix.de>
Date: Wed, 14 Jan 2015 17:27:49 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20150114162749.GE11698@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
 <549EC29D.1070408@meshcoding.com>
 <20141227170317.GB10331@pengutronix.de>
 <54A4388D.40202@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <54A4388D.40202@meshcoding.com>
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>, Sven Eckelmann <sven@narfation.org>


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2014 at 06:55:25PM +0100, Antonio Quartulli wrote:
> Markus,
>=20
> On 27/12/14 18:03, Markus Pargmann wrote:
> > Hi Antonio,
> >=20
> > On Sat, Dec 27, 2014 at 03:30:53PM +0100, Antonio Quartulli wrote:
> >> Hi Markus,
> >>
> >> first of all you should know that I really appreciate your hard work.
> >> Thank you very much for this!
> >>
> >> On 26/12/14 12:41, Markus Pargmann wrote:
> >>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> >>> ---
> >>>  packet.h | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/packet.h b/packet.h
> >>> index facd1feddd4e..5fd0d814b6de 100644
> >>> --- a/packet.h
> >>> +++ b/packet.h
> >>> @@ -18,6 +18,11 @@
> >>>  #ifndef _NET_BATMAN_ADV_PACKET_H_
> >>>  #define _NET_BATMAN_ADV_PACKET_H_
> >>> =20
> >>> +#ifdef __KERNEL__
> >>> +#include <linux/bitops.h>
> >>> +#include <uapi/linux/if_ether.h>
> >>> +#endif /* __KERNEL__ */
> >>
> >> Unfortunately we can't do this :-(
> >>
> >> Patches sent to the kernel cannot contain conditional code on being in
> >> the kernel or not (same is true for checks against a particular kernel
> >> version - such code can't be in the kernel).
> >>
> >> Patches sent to the kernel must assume that they are only for the kern=
el
> >> (and for that particular version we are sending the patches against).
> >=20
> > Oh, I checked by grepping through the kernel before changing the patch
> > like this.
> > 	git grep "^#if.*def.*__KERNEL__" | grep -v include | wc -l
> > 	145
> >=20
> > So there are 145 uses of an ifdef __KERNEL__ outside of include
> > directories (I excluded include directories as they may be exported to
> > userspace). So I thought it would be ok.
>=20
> these are probably pieces of code that have not yet been cleaned up.
> Still, this does not allow us to introduce more code like this: David
> (the networking tree maintainer) would refuse such additions.

Okay, thanks. I removed the bitops.h include for the moment as I don't
have an idea how to keep the header usable for the userspace
application.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtpkFAAoJEEpcgKtcEGQQDxwP/2ptRGwGln6pWAeN+vDfa96Y
fTkv73YATXqDtvORmVtH49+JJ4nPi5glI0yeWU92xN+Et/BA52W6VBgAu8n1/bC8
iy4p35zbevnVDbNp4a5up5+YAWU0bSd7mjZnHDanZ3bNjOw797voz5PVq0J7HGq/
3C0dLoWxvL2MkN40PHDyc8qaJC4a0bFEKsdoxupZXcBjcHIWuxpr7FFPRQuo1VKc
NePlOt/8NgDjyFOgHLgL889tIgwOiaQY4J0lg6yQTltr8Yim2cDPNy1z5oCDT2A6
tszgqUwVzG4jCvwWl5PwIl0t+k0JyssMkjKOI5WWFvyRFQoMO57DrZzvsHzomgXz
whfK6gXDxZGm5kf/LyxlBPFrnTSkt6IU3cfhsjm1X3f90N6Jc+ny5DhsB2F1hDGA
EMNOi4gOELw/RCbqEW6+woIIhTnd11v+p6yGJRxHpnWRZuVGQ0IMcuFY6TJbXDqE
DdSWFNsY39oVD2w378d4d47+dmMl48fhUKZXjvqBE3ZrwHND9Z2+2uM4ZKSoOPfp
E9i1b/JbFh9RZv1AKkSLRdLen01D28D4WwpLYWVS+JeBsRE3zQ9nvjfSq27CkKb/
/3pp/ep9ty5pZpd2n6W8LeX0yWZ/17CojVKRNNv2/STIQBL7HCbp2Rmf++q+3f/t
g5uaeMSU7FR2SiWTMBNy
=99tZ
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
