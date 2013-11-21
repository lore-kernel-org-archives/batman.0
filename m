Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:38:41 +0800
Message-ID: <12732164.njm70c9A0l@diderot>
In-Reply-To: <1384366492-27310-8-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-8-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3960415.Nhc66AdPeQ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 7/8] batman-adv: add debugfs structure
	for information per interface
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


--nextPart3960415.Nhc66AdPeQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:51 Simon Wunderlich wrote:
>  void batadv_debugfs_init(void)
>  {
>         struct batadv_debuginfo **bat_debug;
> @@ -378,6 +395,11 @@ void batadv_debugfs_init(void)
>         if (!batadv_debugfs)
>                 goto err;
>  
> +       batadv_hardif_debugfs =
> debugfs_create_dir(BATADV_DEBUGFS_HARDIF_SUBDIR,
> +                                                  batadv_debugfs);
> +       if (batadv_hardif_debugfs == ERR_PTR(-ENODEV))
> +               goto err;
> +
>         for (bat_debug = batadv_general_debuginfos; *bat_debug; ++bat_debug)
> { file = debugfs_create_file(((*bat_debug)->attr).name, S_IFREG |
> ((*bat_debug)->attr).mode,

I see no specific reason to create a 'hardif' subdirectory. We developers may 
know what the term relates to but it is reasonable to assume our users do not. 
How about adding the interface directory (e.g. wlan0) right next to the batX 
directory ? For clarity we could also move the interface directory into the 
corresponding batX folder. In case multiple batX interfaces it might makes 
things more obvious.

Cheers,
Marek

--nextPart3960415.Nhc66AdPeQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWQhAAoJEFNVTo/uthzAi3MIAKfZtZmCiK9ksEncFvpiBe48
C6iAilZuFkVRAeV3UECjBCDiGnznPxwlHDo800LVypHTQ3HhcwGYtY9vA8k+YkiQ
27gA3Iql8hQ1z69ciNcA5Bi1IMJpCa6poEsh4z7Zo/SEK+PfbgBOTKS9X/lcidPF
1gaEHrIrVADySo4I/3TRy08iqX2c1Jg0edEM6gTNLX0fWnPmxx0g4d2gS9XMlzXE
NMHWFwJz26J/ar+UmixWAT/7mfY2WMxGochIVszq+7aof4bvKDv9LQO5a+FXDTv2
8UxCZBNlAIXwEiECrVP+MnfUsWsq0JbzqkmwiUSE455yISzTqBoVqmQhF2pV2Uc=
=Eo0I
-----END PGP SIGNATURE-----

--nextPart3960415.Nhc66AdPeQ--

