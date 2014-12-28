Return-Path: <mpa@pengutronix.de>
Date: Sun, 28 Dec 2014 12:08:54 +0100
From: Markus Pargmann <mpa@pengutronix.de>
Message-ID: <20141228110854.GC10331@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-3-git-send-email-mpa@pengutronix.de>
 <2142909.IG44WrIDPs@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <2142909.IG44WrIDPs@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 02/26] batman-adv: Separate logging
	header
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Sun, Dec 28, 2014 at 10:33:58AM +0800, Marek Lindner wrote:
> On Friday 26 December 2014 12:41:19 Markus Pargmann wrote:
> > This patch creates a separate header file for logging related functions
> > and definitions.
>=20
> Martin's comment still stands. Your commit message states the obvious wit=
hout=20
> giving any clue as to why this is desired or wanted ..

Didn't see Martin's comment as my email somewhere was lost in the to
list.

However I am doing this because I think it is better to remove as much
code from main.c/h as possible that is not used for init/shutdown.
Logging functions are not interesting for the reader of main.c, so I
think it should be moved to a separate file.

I will add some similar explanation to the commit message.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUn+TFAAoJEEpcgKtcEGQQC94P/2yeZlfmtvksl0DUnIB7ztuB
4Xf6RrMjqfIQEvaj3SJzkve5k/gdlGo5SG79PQQzfB/pBRq5TwJiaARd0l3+3nPg
fhblfsQsRu3YE8QagYTIbL0GJFdjOJeH79eQ8c2+5nhtDaBh9A8YmjQxFntHIoOF
2RLBDUtm6rqX2UScMLDYv9rL9c9XkUhgoyLfK24a9vQsEoiV1n2/78j8HOboPgJB
mZl3cQmAhyBaguJYMpFx0mYpWduaWExsnsKE4X99gyqzeCZW/t7rEdV766pIFgzQ
IS4l+WlzrYp/NvSZF4f+kpMlIu/N3UcUld8ia9mhcuZIIwCFdUbgtMyGuWn/Dww/
xKgbmqTErUAy8lyJ0K6gCWLkx3fcHWBWSD4w9kbCe8Owus7PvJrd+s45HQ9h1AP4
qoZHi0UbMcRqiXHBxPvn6SfMz2k2SDaJorkEmQAKMwEGREw+Zo6NSnq5cvvSuUFA
gWT75LBN2+2XQBW6Flqm7/89gU4Z+Zc4KqIF+T1BSDFL59vq6ogIBRUs6z64iAum
iG31fEv/xYgJ4Je08HNzp9rbEZErl7yixrk8JJRLoPpjdWvjo4xk9iEn+m8hLbFB
FQijq8H55iGeMBS5GeKol8W6vXYOGEMGeE9/s10MM4UfoCf0YNHn4i+lcpP9NEoq
4/yNU/rxaAdODDEkCzTI
=hZkp
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
