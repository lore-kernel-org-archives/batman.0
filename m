Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 13 Mar 2015 14:04:59 +0800
Message-ID: <8175743.8Hpu4HdMqh@voltaire>
In-Reply-To: <1419594103-10928-24-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-24-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2173808.EKA8ibc9GZ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 23/26] batman-adv: Remove unnecessary
	ret variable
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2173808.EKA8ibc9GZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:40 Markus Pargmann wrote:
> We can avoid this indirect return variable by directly returning the
> error values.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  main.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Applied in revision 32a451a.

Thanks,
Marek

--nextPart2173808.EKA8ibc9GZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVAn4SAAoJEFNVTo/uthzA3I8H/Ay6FQkAwX+ZLFu/sf8Kv7jU
Y+z34cUIGSUPBlIt/I3BBkTnfYzIiBAWsQsrYEzgasR3ekuGOYyVZx8p8wNQYtEE
3xvI7Xy5UDfVajz1RIJ2p6YWlWeQjEAOyJwPDTSFS5OBl57PK2JGt487Osz9zJSy
uiAfAwZckhbs3zXDxIJiIpbXvI3w4C/cS41gU9LEBQ6I7D+LduM0r0TA8btZJBzY
/I1RciUR9TUTyfHme9ieNww0mHYRiwzy5Ms/CgwUGIwI0l0SLkcUzZmbDe2SpqZL
J31c2qkpr6deenpQ4pXLQAktNQG79OAQq+n4aFkexjPXf5dt5UTOKmHbFEDd1wE=
=jEIf
-----END PGP SIGNATURE-----

--nextPart2173808.EKA8ibc9GZ--

