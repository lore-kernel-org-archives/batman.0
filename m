Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 16 Oct 2012 01:46:13 +0200
Message-ID: <2204470.3OO4FsvbgM@bentobox>
In-Reply-To: <1350150752-5018-1-git-send-email-martin@hundeboll.net>
References: <1341782658-10978-1-git-send-email-martin@hundeboll.net>
 <1350150752-5018-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1643979.ua66uEqcWn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCHv79.4] batman-adv: Add wrapper to look up
	neighbor and send skb
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
Cc: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>


--nextPart1643979.ua66uEqcWn
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 13 October 2012 19:52:32 Martin Hundeb=F8ll wrote:
> +/**
> + * batadv_send_skb_to_orig - Lookup next-hop and transmit skb.
> + * @skb: Packet to be transmitted.
> + * @orig_node: Final destination of the packet.
> + * @recv_if: Interface used to receive the packet.
> + *
> + * Looks up the best next-hop towards the passed originator and pass=
es the
> + * skb on for preparation of MAC header.
> + *
> + * Returns TRUE on success; FALSE otherwise.
> + */

Could you please extend the kernel doc with the information that recv_i=
f can=20
be NULL and what impact it has?

Kind regards,
=09Sven
--nextPart1643979.ua66uEqcWn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQfKBFAAoJEF2HCgfBJntG0Z0P/07pVzBwaAgPZpTncI5AhUo7
ldCS8x/QweRVUBN7NUCTH0CuPqAeIH8CqYsF/gWBpzDoNz9mrN2nd8x0nMiSkqET
/mIGaUvmX/9Y0P2Ev/Mce3FLW1YI3QV8ZoDIy5kFjSj4iwiUI8cWd2/zymWyVl9o
udw/kPZM5frepOw/aKm+CA9NsHkDbNIBYVTukAf6EtGAjVhFqK+qnSH9SAKoO9h+
3HzuCP26F5Afa79e0S9RPhc/b+SLiXf/5EazD5LIGi29+N863QldyNm+IXkm9pWw
sonzB7A14SgER++R4uIyL3iDkAbXqoGGQPQiZkhsXFqpDftuiiKSLEjCE0Gj9v/5
viH3mc7zAf8lpKjTN3uiUfiqu3yEPHwCEVw9wJXtK9wHkf+P6BXWvAHi6LhHs7t1
dvLRaapBivKFiiiBS9QTewd2eLQajFPSsdZ0IhuUzNnbro/Wco395LuitErR/Sdr
AJcYtwoBRV24EYDa1xiPo8KX5WHC5REDALTgdOGCUft1vU9jmRVPA5yuDgiaztut
hNC4eWTv6t7nHkLWnueQGc8fXcqgHvoAyccZdSIweT2aRASo5uOsY1O+TarRLsS4
DUfHvOViZq6dkf/imzmy6JPKJGPYoYS7R0vKbpPx2VhmihIaSr4Yvib4vvRenrUX
4schcD0qmqPHVFR2mmYg
=mO0D
-----END PGP SIGNATURE-----

--nextPart1643979.ua66uEqcWn--

