Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next 05/10] batman-adv: Use netif_rx().
Date: Mon, 07 Mar 2022 08:26:44 +0100
Message-ID: <6057237.0618BOYifV@ripper>
In-Reply-To: <20220306215753.3156276-6-bigeasy@linutronix.de>
References: <20220306215753.3156276-1-bigeasy@linutronix.de>
 <20220306215753.3156276-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23526821.4xDK8nd8PC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart23526821.4xDK8nd8PC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 05/10] batman-adv: Use netif_rx().
Date: Mon, 07 Mar 2022 08:26:44 +0100
Message-ID: <6057237.0618BOYifV@ripper>
In-Reply-To: <20220306215753.3156276-6-bigeasy@linutronix.de>
References: <20220306215753.3156276-1-bigeasy@linutronix.de> <20220306215753.3156276-6-bigeasy@linutronix.de>

On Sunday, 6 March 2022 22:57:48 CET Sebastian Andrzej Siewior wrote:
> Since commit
>    baebdf48c3600 ("net: dev: Makes sure netif_rx() can be invoked in any context.")
> 
> the function netif_rx() can be used in preemptible/thread context as
> well as in interrupt context.
> 
> Use netif_rx().
> 
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Sven Eckelmann <sven@narfation.org>
> Cc: b.a.t.m.a.n@lists.open-mesh.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Acked-by: Sven Eckelmann <sven@narfation.org>
--nextPart23526821.4xDK8nd8PC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmIls7QACgkQXYcKB8Em
e0b2/Q//XcO0hhSLL1nArD2M/D4WHYoT7j507mGwYAJ9TxgHdAL1OMnK+rNBs0ad
FjYaoPzYhnhMBDvVWnkAbr2B+GPp6h3LNzWbjvc9hX/HMewWynKM6bpYGgfmPOz3
OSdTsrVGG9gmX5/rQUAjcYAXycOkiHWL3fsRzxjeB0BLwRjyOlXu77Y+E9sDNU41
XZ4cyEwG1ylIWx+JvtaK9TquoNAZ7BwdlHKdLGcnpJ2REI8ir+myjy0SxmKxB3w2
wi6YU6BfJXf1afHogDl4Tu4LmwJirs9+Gl+JPH+bQ9zD+V0hSYUN4akjCFuUAzM3
erKsgZVyabJ0J9VQSwTZBgo0myiW63uCG467Pu0IFVkY+0WZtdG4Dt6Z07O8KwaX
+Ls8Kp2cUj5E76dodkQlFqaBP2tLCe9D9PUUmVIAdWuI+UT8S7cGRBN9pV70uxaf
eRcdtiJ5GyCYDUoW7VxxslCiI/j3MjX1IE3/iqjImEbLXFXJb+TjVboYub8FXAtD
Zjv+gzOi4NEyN3DduyecXQ0xig6wcfaY7osZi21svj3/dBCvHA7ahRp+FMz+8m05
5Xf8QUQTQ2nydN/EqT/4Pn5zbsXM4e3fNoqZYj6QDfNCOccMItZRMCcdCZT1PPfo
epdgj0HJCpuGGdLzDAGb1Q+OuGFVtmE6ZvE9ro97nS/qFqrX8SA=
=cEkA
-----END PGP SIGNATURE-----

--nextPart23526821.4xDK8nd8PC--


