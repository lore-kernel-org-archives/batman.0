Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 29 Jan 2014 12:40:39 +0800
Message-ID: <3034509.GXq9lutoyG@diderot>
In-Reply-To: <1390836437-3014-1-git-send-email-antonio@meshcoding.com>
References: <1390836437-3014-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1773755.VKC8M0JgsC";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 next] batman-adv: avoid potential race
	condition when adding a new neighbour
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


--nextPart1773755.VKC8M0JgsC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 January 2014 16:27:17 Antonio Quartulli wrote:
> @@ -266,7 +266,7 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface
> *hard_iface, struct batadv_orig_node *orig_neigh)
>  {
>         struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> -       struct batadv_neigh_node *neigh_node;
> +       struct batadv_neigh_node *neigh_node = NULL, *tmp_neigh_node;
>  
>         neigh_node = batadv_neigh_node_new(hard_iface, neigh_addr,
> orig_node);

I don't quite get why neigh_node has to be initialized if we set a value in 
the next line.

Cheers,
Marek

--nextPart1773755.VKC8M0JgsC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJS6IZKAAoJEFNVTo/uthzAfokIAKBZV2fcjrNZ5qPa7EGGqYLg
WpdxCNv2HrNJV5qFGLPwB34461uIOi4gk3vSJPow0Gbz4kssXJGP8n5yQhYOZ7QZ
WNpFOEvXVE/SPiPeruHgzSLk3v36tAxHuoQ9LHYJNQu4aJAOqYUSt1zbSVl+e5p8
KdCRdXKQ/KqCQmG983YePWFIEu/YVzkkMARaNlFCcENDgsNX8EbiustVqWE+h2vL
cYRiZ4SQ/acKr8CRVdaSWrW48F/ojvnoVHouokZuEUE7ypOOHfTpOETX0J3vpuDu
fP+EujvDU2sCguGaIc25D/wrgdmW07TfWRgNgwpvVPPAFsoMGLP3lFZUJOG6Vr0=
=rK4L
-----END PGP SIGNATURE-----

--nextPart1773755.VKC8M0JgsC--

