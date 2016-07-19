Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:29:03 +0800
Message-ID: <3126829.kUMf6V1Llu@voltaire>
In-Reply-To: <1468597173-25378-9-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1684082.jZpOgMIXdF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 09/18] batman-adv: Place kref_get for
	bla_claim near use
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

--nextPart1684082.jZpOgMIXdF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:24 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/bridge_loop_avoidance.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision 7b229c7.

Thanks,
Marek

--nextPart1684082.jZpOgMIXdF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeTPAAoJEFNVTo/uthzACgkH/01sGuDbRLem3zWbs+UN7HU6
Wub44FixHmIkAANvWBiP3kN+p6eJ6LXqRnIF+gg8y6obCcBR5JK9pYhqIWzbRBa9
e3cx6Rc0LbxdRiUQz+uQ7jhJfDGFJKlAQL7yNVyRh1oD++sMXtAzOIT66AjTsOOO
kso3h+JkqFwWUaHozOL0BPyjMzzxP+ENSsstqSb570NY6Co1oLfyp8pu3RXDHWB/
KitCHiTq3XxO0mzZgCkCEgZcLByxVO8pee76NMNJH6syl5JYGj0kMi4rLM+bv2xp
c/lyJVyCHb/1EOLY0cx8pTpiSR80HYOFI0CVVaPraWSdwBE9YPVDnpTgXfrXZ1E=
=Yp0y
-----END PGP SIGNATURE-----

--nextPart1684082.jZpOgMIXdF--

