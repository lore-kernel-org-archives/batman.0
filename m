Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 21 Mar 2014 16:34:33 +0800
Message-ID: <7361404.k5XdDIMMsb@diderot>
In-Reply-To: <1395251855-30765-3-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-3-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart35796495.cKXOOBZpoH";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next 07/11] batman-adv: fix multicast
	kerneldoc
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart35796495.cKXOOBZpoH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 19 March 2014 18:57:31 Antonio Quartulli wrote:
> The kerneldoc should always use the third person singular in
> the long function description.
> Moreover it should always try use up to 80 chars per line.
>=20
> Introduced by f2ed1502191a37abb39e3e2c80cca07f0f3bb411
> ("batman-adv: Send multicast packets to nodes with a WANT_ALL flag")
>=20
> Cc: Linus L=FCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  multicast.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied in revision 5690930.

Thanks,
Marek

--nextPart35796495.cKXOOBZpoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTK/mZAAoJEFNVTo/uthzAVLYH/27jfU8DXb115+xW/X+37uh8
HZtakMjnSS97i+djqoeVpz31tbi/g/8vOnpmbFGBtPwFFLwpPy3Zm+wQoHddEuna
I/ZV1QiBkpkVXbRWAg76tnI0eKO2K/zXqn9523+WKJH/O6q9UdISKDvj64gohsf3
r0E5RFIdRa1XOI3g9NBBPCGDQKvzIQqqGfgP22euFzG7K4xLwQx+Io8DrkiN4sRH
WPYdnpbt9IuU46pslOwiU4V3P2ogq80Ru/uwI7oYMXQHnwxCcNhhlZw9fh1kVxNl
PjKf8m3STKLXQHtAWZJI1xFF2BcDfyFOIF2oTC71OEk7nGkVHSA2SOpm8smVRgw=
=aUio
-----END PGP SIGNATURE-----

--nextPart35796495.cKXOOBZpoH--

