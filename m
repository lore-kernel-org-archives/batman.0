Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Jun 2014 09:52:56 +0800
Message-ID: <1415723.SePSTUQJgy@diderot>
In-Reply-To: <1402415431-30190-1-git-send-email-gaul@web-yard.de>
References: <1402415431-30190-1-git-send-email-gaul@web-yard.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2133480.SjckAxclOm";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: remove unnecessary logspam
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?ISO-8859-1?Q?Andr=E9?= Gaul <gaul@web-yard.de>


--nextPart2133480.SjckAxclOm
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 10 June 2014 17:50:31 Andr=E9 Gaul wrote:
> This patch removes unnecessary logspam which resulted from superfluou=
s
> calls to net_ratelimit(). With the supplied patch, net_ratelimit() is=

> called after the loglevel has been checked.
>=20
> Signed-off-by: Andr=E9 Gaul <gaul@web-yard.de>
> ---
>  main.h    | 20 ++++++++++++++------
>  routing.c | 18 +++++++++---------
>  2 files changed, 23 insertions(+), 15 deletions(-)

Applied in revision 11b7925.

Thanks,
Marek

--nextPart2133480.SjckAxclOm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTm6r4AAoJEFNVTo/uthzAVjIH/3sGx952Eb3Z7dmgH2Unt//U
un48ED1/QoFkBR350xeRziAr25X7Iq6Vdt44jRU/lR40WUwUEskOBzX2bTZegqLW
eWvRGlecCrneLXV9RDFZKJ1lWTJR/F/3KL8IeXdPj5Er8VA3o1cPcssNOtu23Azg
5VIUg/VNXIEpioQOh92uVlLE72phXTBQTyuj1bvWTZpSP3v8ZsW+68G2yrrjSf+I
bUK/spWY6XGybZRTZC/LHZ9E+ng7cxXSOavl91KcFRWu0lt3yHtHHmYLg/RzU+wo
M4Hx8b+GvOSY3lBw3hOM/C1jZYPCQKaMGr/cAfBGvxEes9gDiWC3eZ3mfgtGKpQ=
=MZhT
-----END PGP SIGNATURE-----

--nextPart2133480.SjckAxclOm--

