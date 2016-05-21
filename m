Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2016 14:32:38 +0200
Message-ID: <1658184.bVJx44a0QY@sven-edge>
In-Reply-To: <20160521121756.27450-2-a@unstable.cc>
References: <20160521121756.27450-1-a@unstable.cc>
 <20160521121756.27450-2-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2965490.BpEGivcMEp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: move include line at the
	same place as other files
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2965490.BpEGivcMEp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 May 2016 20:17:56 Antonio Quartulli wrote:
> main.h is always included after the #ifdef guard except for
> bat_v_elp.h. Move it at the right place.
> 
> Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---

Good find :)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

>  net/batman-adv/bat_v_elp.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
> index cc130b2..be17c0b 100644
> --- a/net/batman-adv/bat_v_elp.h
> +++ b/net/batman-adv/bat_v_elp.h
> @@ -15,11 +15,11 @@
>   * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
> 
> -#include "main.h"
> -
>  #ifndef _NET_BATMAN_ADV_BAT_V_ELP_H_
>  #define _NET_BATMAN_ADV_BAT_V_ELP_H_
> 
> +#include "main.h"
> +
>  struct sk_buff;
>  struct work_struct;

--nextPart2965490.BpEGivcMEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXQFVmAAoJEF2HCgfBJntGdHwQAIbLCPQg3HAvbUATqUbOh3vS
8h1QZjIscjGM6j8t21eJ75YaFqVlkmuTjWtQ6O8fK3EJ+LFSFVkktSzsxKsuwg7u
gd28hs/SACn/7L7iyIJ4Hh6UFub9Ou/wqxtfYDhtKHfuoqV3g9fvW5t/Z6hl5AgO
L3Fj5u7qD5fzAWsVOXH+4JAuHJh2obMPnp/TzhqWbI+Ks02Np5BM3dBVLG2Os6oV
fc6u1/sjpVCTeA54UvwY/urOpptagqNauhnd8CHlmz82/83lrAClfr/WmugAVEOd
udNeW5ToV6NyBs4gmd0sobnRZqNcwocfMme2S3tZmaP2mdpcyL5AVh6zMair6NBJ
2Nem3sy/iFHehGX3Q8zGwsKoX8t/FsYiVfmXO86sy0LGv/CHtZiHF6TkTl33xsh8
UuIcHjyg5ZBhbo/Tduvf1WA2sTZW/UtR6t4/sn+hVGMI0JEEYfqtoZKEHqp7mK5M
8rDt/AB/nhwilyt8dUnCBogwIwm+2oefdKcTVt15vuC4jWatHjOIwXbF9Q+aVR7x
f96LULXAWPvwRwotdjE4gXgsBGgMNrFMVpNl0JWlJnjp5JXvYBijK7CYKfGobNrD
MyfWtPLKvGVJdzq//h9L4bHc0ZqyjTa2kQiqQkIJ9mtpT7NudJwFgLpnqMwU8aia
wX4jR3P/5YU2XzkBYsY6
=SRK/
-----END PGP SIGNATURE-----

--nextPart2965490.BpEGivcMEp--

