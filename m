Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 27 Oct 2013 17:46:13 +0800
Message-ID: <92195114.hafFiLUq8s@diderot>
In-Reply-To: <1382774343-3316-1-git-send-email-antonio@meshcoding.com>
References: <1382774343-3316-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3182975.u83AuencNv";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: deselect current GW on
	client mode switch off
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart3182975.u83AuencNv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 26 October 2013 09:59:03 Antonio Quartulli wrote:
> diff --git a/gateway_client.c b/gateway_client.c
> index 2449afa..2903bdb 100644
> --- a/gateway_client.c
> +++ b/gateway_client.c
> @@ -207,6 +207,10 @@ void batadv_gw_check_client_stop(struct batadv_priv
> *bat_priv) if (!curr_gw)
>  		return;
> 
> +	/* deselect the current gateway so that next time that client mode is
> +	 * enabled a proper GW_ADD event can be sent */
> +	batadv_gw_select(bat_priv, NULL);
> +
>  	/* if batman-adv is switching the gw client mode off and a gateway was
>  	 * already selected, send a DEL uevent
>  	 */

Right above the batadv_gw_check_client_stop() call in batadv_store_gw_mode() a 
very similar function is called: batadv_gw_deselect().

Calling batadv_gw_deselect() is not enough to ensure an ADD event is sent ? In 
case the old gateway == new gateway we have no event ? If so, that should be 
documented somehwere ..

Cheers,
Marek

--nextPart3182975.u83AuencNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSbODoAAoJEFNVTo/uthzAFdkH/0OqcS7PvInXL/pLcmJjUedf
VAy4ecVjQqAT8MA4Xo1GyPuT4KNRXBFIKmzBFVwQZ92MXuyCzrcQt2no3VGRrmxd
eg59cBJpuQhbSaIyDrj/gSRR8N6Y/1MENnRkgmyNK/20QANveRV5A4I+105gN7bI
d8yM/uI3uzd6H6RPKKojOocYozCQ6vLhPVPr1svRiS7upwSd8PYAiZsd8FpgmQsd
ylK1tzMSZdHboGnAoECXW9jR1mGN0rUpnh3oJBz1cPyBEapzYklbW271cY4c2z3f
CN75n37t51BjrFreMzhsMknzT+mhGUeZ1Xlu4F7ZjLkVeYJzB7wjP3iugiM7etA=
=/4Sm
-----END PGP SIGNATURE-----

--nextPart3182975.u83AuencNv--

