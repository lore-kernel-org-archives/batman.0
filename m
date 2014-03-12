Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 12 Mar 2014 15:32:37 +0800
Message-ID: <1411989.q42HG6dQ0k@diderot>
In-Reply-To: <1394568273-1117-2-git-send-email-linus.luessing@web.de>
References: <1394568273-1117-1-git-send-email-linus.luessing@web.de>
 <1394568273-1117-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6708146.GZnu4rnXZc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batctl: add unicast/multicast
	address filter option for TT output
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


--nextPart6708146.GZnu4rnXZc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday 11 March 2014 21:04:33 Linus L=FCssing wrote:
> This patch adds the new "-u" and "-m" options for the local and globa=
l
> translation table output to only display announced unicast or multica=
st
> mac addresses to enhance readability.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
> v3: unchanged
>=20
>  debug.c      |   32 +++++++++++++++++++++++++++++++-
>  functions.c  |   22 ++++++++++++++++++++++
>  functions.h  |    2 ++
>  man/batctl.8 |    2 ++
>  4 files changed, 57 insertions(+), 1 deletion(-)

Applied in revision 6202831.

Thanks,
Marek

--nextPart6708146.GZnu4rnXZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTIA2YAAoJEFNVTo/uthzANl0H/3OrXwJKXRcJsNoGzIzsy40H
uLC6uj3DTFK5mS8GgX0e4tz910Pqq2KbhoQrnwYMqmuEuWtGqSl0fT276gAKTfL3
hmT98awFs7orCdXJyRbnKf7aLHeAKKD2V9cFMANocMbeapqaESmbnYIAJMAFtG54
QBISHrudK2qteLbF9mvulSfpWbeDminf8SnHuwv3cL7jAl3pdGbZWqr+Eh73M+O9
REsfD6PAUU6PyhX/IlLTX2wl1C0nQQa5yWKlm9lTnbZpNE1Hau1OO66VFZNZ4qJO
dog71uyzOpsRbeQvTirRNaIPbx11tUjePpmmdrsrbMCjS0qEhtCRP9NX1HVBYA4=
=tzKj
-----END PGP SIGNATURE-----

--nextPart6708146.GZnu4rnXZc--

