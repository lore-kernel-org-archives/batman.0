Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 09:20:53 +0800
Message-ID: <1779138.N065qCyhMx@voltaire>
In-Reply-To: <1462474003-25279-4-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <1462474003-25279-4-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart146275310.krFTOjobnV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/7] batman-adv: split routing API data
	structure in subobjects
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

--nextPart146275310.krFTOjobnV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 02:46:40 Antonio Quartulli wrote:
> +       .iface = {
> +               .bat_activate = batadv_iv_iface_activate,
> +               .bat_enable = batadv_iv_ogm_iface_enable,
> +               .bat_disable = batadv_iv_ogm_iface_disable,
> +               .bat_update_mac = batadv_iv_ogm_iface_update_mac,
> +               .bat_primary_set = batadv_iv_ogm_primary_iface_set,
> +       },
> +       .neigh = {
> +               .bat_cmp = batadv_iv_ogm_neigh_cmp,
> +               .bat_is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
> +               .bat_print = batadv_iv_neigh_print,
> +       },
> +       .orig = {
> +               .bat_print = batadv_iv_ogm_orig_print,
> +               .bat_free = batadv_iv_ogm_orig_free,
> +               .bat_add_if = batadv_iv_ogm_orig_add_if,
> +               .bat_del_if = batadv_iv_ogm_orig_del_if,
> +       },

If we are touching all API calls I suggest to remove the 'bat' prefix. For 
example:

       .iface = {
               .activate = batadv_iv_iface_activate,
               .enable = batadv_iv_ogm_iface_enable,
               .disable = batadv_iv_ogm_iface_disable,
               .update_mac = batadv_iv_ogm_iface_update_mac,
               .primary_set = batadv_iv_ogm_primary_iface_set,
       },


Cheers,
Marek

--nextPart146275310.krFTOjobnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK/F1AAoJEFNVTo/uthzA2noIAMHmDce3yTt5GYUjCRE1nN/4
BOCUukON5f9mG9rWnwhGsZMvLIqfeB96J/plVb+EmakhCPsMGf8Fa3nVHgUBvN5K
bBC+gZ4oEOSZVugu7zDxaS3qRMu6smyc8GY0iA52+RjqniNduuNfWhsf/Ckjwob3
9KxJBI1Q2wnxbuQqxRTd22FMdvk0HIMNmMlUWvJIvjuTBak1lMEp37/bYHoabi11
gWLIMDf2qvdeyViApGhOizQ5cBASjwtaItJ1Nh/UjzoO7jxEbcTwAJannXLeTD5a
LTJMXP1UN3HP6d6bL77FSXVysKPw2bqmnLoINq7sEl5JjxYWVS+Ag6vSKTVSVzw=
=pcCk
-----END PGP SIGNATURE-----

--nextPart146275310.krFTOjobnV--

