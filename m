Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 03 Aug 2015 14:52:09 +0800
Message-ID: <3128531.JDhBBG3Ak5@voltaire>
In-Reply-To: <1437494666-16416-1-git-send-email-sw@simonwunderlich.de>
References: <1437494666-16416-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6423426.gHnq3zlzVa";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: remove obsolete deleted
	attribute for gateway node
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


--nextPart6423426.gHnq3zlzVa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, July 21, 2015 18:04:26 Simon Wunderlich wrote:
> @@ -498,7 +492,8 @@ void batadv_gw_node_update(struct batadv_priv *bat_priv,
> struct batadv_orig_node *orig_node,
>  			   struct batadv_tvlv_gateway_data *gateway)
>  {
> -	struct batadv_gw_node *gw_node, *curr_gw = NULL;
> +	struct batadv_gw_node *gw_node, *gw_node_tmp, *curr_gw = NULL;
> +	struct hlist_node *node_tmp;

The variables gw_node_tmp and node_tmp aren't used in this function ...

Cheers,
Marek

--nextPart6423426.gHnq3zlzVa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVvw+mAAoJEFNVTo/uthzAZy0H/05VQ12fL4PzQU7q5jFzCNS5
p6AwDlu+FT2sxFCzKXvTr1bkIDXGcvzAjCQB1PmGaWTQbE8MAuELopYZUkEuoaCR
cLY/IAFSnWJZQ6qmmE6Mgt+hYVZnCBvUG2R/4fx/+iwZwSHacoQpStphicekYxVZ
uEKzUoULgNg0pznZ0YgClL9fWf2zvZBlRjmAGKzzwsqPbI/DxicC+JWXl9ugNo0k
3TPWbUJBh42gd+simmFXKlTi61w+3TTSEBOWBB82cvTl2HsQODcNeDQmHTrp7+A4
FHsDcmoUrM8bMbvPA6GpjjNKbsP/FxzwH0twD2Wp3AwGZMxM8hT4I71Ioqy0V4w=
=/QI4
-----END PGP SIGNATURE-----

--nextPart6423426.gHnq3zlzVa--

