Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 16:54:50 +0800
Message-ID: <31260547.I8XBpZylIC@voltaire>
In-Reply-To: <1468158477-10941-1-git-send-email-sven@narfation.org>
References: <1468158477-10941-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1754643.bjpFPdN9tU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Keep batadv netdev when
	hardif disappears
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

--nextPart1754643.bjpFPdN9tU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 10, 2016 15:47:57 Sven Eckelmann wrote:
> Switch-like virtual interfaces like bridge or openvswitch don't destroy
> itself when all their attached netdevices dissappear. Instead they only
> remove the link to the unregistered device and keep working until they get
> removed manually.
> 
> This has the benefit that all configurations for this interfaces are kept
> and daemons reacting to rtnl events can just add new slave interfaces
> without going through the complete configuration of the switch-like
> netdevice.
> 
> Handling unregister events of client devices similar in batman-adv allows
> users to drop their current workaround of dummy netdevices attached to
> batman-adv soft-interfaces.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/hard-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision be7cd9d.

Thanks,
Marek

--nextPart1754643.bjpFPdN9tU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXkd9aAAoJEFNVTo/uthzAIZIIAJ6MeI3sC0r1uvBvA1e/8BoW
buS2MNQA2We6CnfrjgGH+d1PcSbTomcyA9Eble+Lb5iWMVZ3dtSx58VCw9rH4JPg
2HEnREtAl808B6Fjl9ydD2HT3z2jw75JC5FrZ/tIbEwRzICmM0K4wK5Mwl0zAyZR
mCa7PzJYu8bgC/v7Vj1+g1ExwU/7t8ua00v3X1HouOnoZbFWUZP84miuxudZXjrO
9MvHCQD0nCPAC6wW/Ic8W9t/9puBAzEZDJ2FKLBLXVq2qeZebt4yPeN3Njnkss0r
7+7u4OLrMj0oZRgaPi756Ah3p0LuX5J10LauhgVM91Bkm1+Kxx22I4ys3rqXiHk=
=5Xwx
-----END PGP SIGNATURE-----

--nextPart1754643.bjpFPdN9tU--

