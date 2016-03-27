Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Mar 2016 15:08:39 +0800
Message-ID: <3016125.hgzoRVfCNO@voltaire>
In-Reply-To: <1458392121-23608-1-git-send-email-sven@narfation.org>
References: <1458392121-23608-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26056221.KaGcxm6yZl";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Deactive TO_BE_ACTIVATED
	hardif on shutdown
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

--nextPart26056221.KaGcxm6yZl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 19, 2016 13:55:21 Sven Eckelmann wrote:
> The shutdown of an batman-adv interface can happen with one of its slave
> interfaces still being in the BATADV_IF_TO_BE_ACTIVATED state. A possible
> reason for it is that the routing algorithm BATMAN_V was selected and
> batadv_schedule_bat_ogm was not yet called for this interface. This slave
> interface still has to be set to BATADV_IF_INACTIVE or the batman-adv
> interface will never reduce its usage counter and thus never gets shutdown.
> 
> This problem can be simulated via:
> 
>     $ modprobe dummy
>     $ modprobe batman-adv routing_algo=BATMAN_V
>     $ ip link add bat0 type batadv
>     $ ip link set dummy0 master bat0
>     $ ip link set dummy0 up
>     $ ip link del bat0
>     unregister_netdevice: waiting for bat0 to become free. Usage count = 3
> 
> Fixes: 88861ea9acb7 ("[batman-adv] replacing if up/down timer with kernel
> notifications") Reported-by: Matthias Schiffer
> <mschiffer@universe-factory.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision fbb98aa.

Thanks,
Marek

--nextPart26056221.KaGcxm6yZl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW94b3AAoJEFNVTo/uthzAoWgH+gNxhe4CUOrHmcUrlpOtwksh
Sv7xzxbJYKqpo/01GV2ZmeAn2G5MzaD8KFbZHN95X9p9m357CHSpuIRZ6jlUNEg1
GvYCCFjpswdkODU08d6rAlChV8vUjUwF5C+s9y324S5TjczbPWcqeIvPu5zMg1mW
dDXOa9+vafljYgwoKxUDl3zbL7c1T7GkF9LjT+FFSkBlc6JzsefWf9Qi4zSwDggL
+gbLr7yH6yz25ZR9TGQ8TK4bywWnIPxv7OKIZaadis99/RV5+2nFvuhlBPCur0fA
soyhtes0CZajeoZA/zzdmXCWYLUuIrHDc38UiZ6h/x15HTG2q4lzHwRmAqmzDzs=
=NRR5
-----END PGP SIGNATURE-----

--nextPart26056221.KaGcxm6yZl--

