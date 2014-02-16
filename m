Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 16 Feb 2014 14:24:27 +0800
Message-ID: <2054711.eOSEPyua8Q@diderot>
In-Reply-To: <1392482874-9024-3-git-send-email-linus.luessing@web.de>
References: <1392482874-9024-1-git-send-email-linus.luessing@web.de>
 <1392482874-9024-3-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2104204.20OyCo8Krl";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 2/6] batman-adv: introduce capability
	initialization bitfield
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


--nextPart2104204.20OyCo8Krl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 15 February 2014 17:47:50 Linus L=FCssing wrote:
> The new bitfield allows us to keep track whether capability subsets o=
f
> an originator have gone through their initialization phase yet.
>=20
> The translation table is the only user right now, but a new one will =
be
> added soon.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  originator.c        |    1 -
>  translation-table.c |   12 +++++++-----
>  types.h             |    7 ++++---
>  3 files changed, 11 insertions(+), 9 deletions(-)

Applied in revision 5d2121a.

Thanks,
Marek

--nextPart2104204.20OyCo8Krl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAFmcAAoJEFNVTo/uthzAxwAH/29ChgqYgYbLF6j7B+3cubRK
hj20/SQqkUNamnaWQ39yqAdHaeMDhTreeZtogkYweQJ7aMRNOrfZIODz0CQq7SSd
96qWYz+uE3ik0EaxbHEkwm8CAYujLD9kQBMSlmiMtWZ4SyVJNqdIjwpTV0yq06OU
8Em8trL51Glz4OdIXuf3OnxwXdrjsXf7CnJk92i9GqB7SoCDeqKUp9GlL6xgpfG6
uR6xujCWw0MNyBZQas1zsHm7Nv9zpCzkfiuL5J5Q1yGBZU6wQYDxSz+LvPM2JZ+q
1N/G3/saZpWZPE2KpZNQTqk/cF5I3U8cAsOICf9omDrSeZRfbxWvi6lrs5iCBho=
=dytw
-----END PGP SIGNATURE-----

--nextPart2104204.20OyCo8Krl--

