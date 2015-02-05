Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 05 Feb 2015 19:09:55 +0100
Message-ID: <1525155.WDXWpZloLX@prime>
In-Reply-To: <1423147633-13147-1-git-send-email-sven@narfation.org>
References: <1423147633-13147-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2195909.letYPVLsPG";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Close socket after connect
	failure
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart2195909.letYPVLsPG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 05 February 2015 15:47:13 Sven Eckelmann wrote:
> The socket is still using one file descriptor of the process when the
> connection fails. This fd leak is non-problematic in the current client
> process code because the client would be closed in this situation anyway
> and therefore the socket would be closed when the process is stopped. But
> people using this as example code may not stop the process on this error.
> The unclosed and unused sockets would accumulate and the process would hit
> the limit for open file descriptors.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

applied in revision 26a7b5e.

Thanks!
    Simon
--nextPart2195909.letYPVLsPG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlTTsfgACgkQrzg/fFk7axZRdwCgyPzwnLp7KhJQK+P1aKM7BqHw
CdwAoLxGyhzhrRlzTy9hH16eLE0OMi0z
=r/p/
-----END PGP SIGNATURE-----

--nextPart2195909.letYPVLsPG--

