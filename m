Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 02 May 2016 18:05:39 +0800
Message-ID: <1862457.UagmlqXuON@voltaire>
In-Reply-To: <1462137808-719-1-git-send-email-a@unstable.cc>
References: <1462124180-12104-1-git-send-email-a@unstable.cc>
 <1462137808-719-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart39544018.m1sU7rdGmL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: make sure ELP/OGM
	orig MAC is updated on address change
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

--nextPart39544018.m1sU7rdGmL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, May 02, 2016 05:23:28 Antonio Quartulli wrote:
> +static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
> +{
> +       struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
> +       struct batadv_hard_iface *primary_if;
> +
> +       primary_if = batadv_primary_if_get_selected(bat_priv);
> +       if (primary_if != hard_iface)
> +               goto out;
> +
> +       batadv_v_primary_iface_set(hard_iface);
> +out:
> +       if (primary_if)
> +               batadv_hardif_put(primary_if);
> +}

Please provide kernel doc.

Thanks,
Marek

--nextPart39544018.m1sU7rdGmL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAABCAAGBQJXJyZzAAoJEFNVTo/uthzAIZoH+JdXnAW8Zss2GqFHexHP+VXm
sa76SYXvCifFKtT1e5iv92ECoOpL6mv1gOsMgvUDzKVy5Z2bAouEYYiNBJfy19AN
dsMBPtd9huuiUwwbHZeLhtp3ISPJAOosGfuZ9a2U7BOme33toHiB+1qnSsUbB+vL
NM4qwQBDuqFikcRt+8syNXEmqeQKW5kOtBwpkwvbipeQsTlY+F7SWVKb3acOMaXt
EiO5tbEImWtNxNVpg8sXoIPrTzR9Kib2oapLTb01nFPBY+4cabQ5tz96kh7GpVOf
+ZqoDUJ7m/QcYofIlo2Y3ermz2fPRiBK+0XEpVqyBod12qLI00FEu1iINP96Kg==
=6TNX
-----END PGP SIGNATURE-----

--nextPart39544018.m1sU7rdGmL--

