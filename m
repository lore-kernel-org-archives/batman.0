Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Apr 2016 07:56:36 +0200
Message-ID: <3917725.N04J6GrtYh@sven-edge>
In-Reply-To: <1460597825-22660-1-git-send-email-a@unstable.cc>
References: <1460597825-22660-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1587771.4yDl5mJmFD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: B.A.T.M.A.N V - make sure
	iface is reactivated upon NETDEV_UP event
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1587771.4yDl5mJmFD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 14 April 2016 09:37:05 Antonio Quartulli wrote:
> At the moment there is no explicit reactivation of an hard-interface
> upon NETDEV_UP event. In case of B.A.T.M.A.N. IV the interface is
> reactivated as soon as the next OGM is scheduled for sending, but this
> mechanism does not work with B.A.T.M.A.N. V. The latter does not rely
> on the same scheduling mechanism as its predecessor and for this reason
> the hard-interface remains deactivated forever after being brought down
> once.
> 
> This patch fixes the reactivation mechanism by adding a new routing API
> which explicitly allows each algorithm to perform any needed operation
> upon interface re-activation.
> 
> Such API is optional and is implemented by B.A.T.M.A.N. V only and it
> just takes care of setting the iface status to ACTIVE
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
> 
> Changes since v1:
> - added kerneldoc for bat_iface_activate
> 
>  net/batman-adv/bat_v.c          | 12 ++++++++++++
>  net/batman-adv/hard-interface.c |  3 +++
>  net/batman-adv/types.h          |  3 +++
>  3 files changed, 18 insertions(+)

Reviewed-by: Sven Eckelmann <sven@narfation.org>
--nextPart1587771.4yDl5mJmFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXDzEUAAoJEF2HCgfBJntGM08P/3SQ2h8+GGoH7wnvCtswq9DH
Y3X71mTiieU++zA1sHKW+pilmI9bp2ef7UO6P5LWGyGE7k3vM4hLmKpRol1B0FHF
m1S+JfixC42CsKiJScecd2mgEK9PdKF+FCe0/2Bm6ddyZlnDfvOlE+p3GbNpqQok
z/BkTD7XGveyXXMMzNi/c+iFZCdNB68G6Ieryt+9nyL/LsEUQHGR3sUC35iuuONt
/HIiW1Q7Gws6ZtfQoRhlfwclE00XKlPZ1UrNDKtE65OPa7aHDJrfmMqBaxAA9MNj
2JhfB1ckGGIG1pxksvngwnoFfXrtULT8ov8FjADmnasNwLLbaaslpopsvxBeNKbo
in4NnlXSqA9E2REbJBHU2lOZMs1GscyyJ5QXBWNI6xRfjOsAq/a0rXASmEujmYec
gyPxGxs04+80d6mLpiWuyCSPwMxrBOYNYfY559NI7qCaPxTNeTVWpER5C8NyEi2C
XZIEAtCPniNL+aZRc2AYyoP3a7JK42ekevqGoCdCZarB47dX6zRaVdlydW3b+fnv
OV8EG5veY2Gvh853qOh6rXLZ8mKDeGMpf8AXOl7xRONBdKjuIYWpIgCI9zHHH8yi
7c2j5JPC2uLEVqok3Mj6qaOMh3FE+8rULPUQTlAZ/H4djzW3WdKeHiC0/VbSaa5s
az3aQYFNQgOn/vuGPSJP
=Fv7A
-----END PGP SIGNATURE-----

--nextPart1587771.4yDl5mJmFD--

