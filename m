Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 22 Apr 2015 10:08:49 +0800
Message-ID: <2376739.tkYtSexUdr@voltaire>
In-Reply-To: <1429612929-19765-1-git-send-email-sven@narfation.org>
References: <1429612929-19765-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1756069.ycY5jvAkVn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Document multicast compile
	time option
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1756069.ycY5jvAkVn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 21, 2015 12:42:09 Sven Eckelmann wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -59,6 +59,7 @@ BUILD_FLAGS := \
>         CONFIG_BATMAN_ADV_NC=$(CONFIG_BATMAN_ADV_NC) \
>         CONFIG_BATMAN_ADV_MCAST=$(CONFIG_BATMAN_ADV_MCAST) \
>         INSTALL_MOD_DIR=updates/net/batman-adv/
> +export batman-adv-y += ../../compat.o
>  
>  all: config
>         $(MAKE) -C $(KERNELPATH) $(BUILD_FLAGS) modules

This hunk does not look like it should be part of this patch according to the 
patch description ?!

Cheers,
Marek

--nextPart1756069.ycY5jvAkVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNwKxAAoJEFNVTo/uthzANJcIAIk489kNq8+9a2IPFgdoFEne
HPNRfOpkHDRgYz/tf71Qu4RsiJf7slhGTH08KRacmOTNFYrQdjvSenwCJ31RhFQd
/WesIGrx+nTq5aNplGn2NUOxPd7V2cX1EmJxoP7DxbmtmLyHyAogODJ52mpyVPpj
X0VtUvMYMruT6bb7XizHMK4U+9VqUSsQ0Ki9Lu4qXBHqdkcbroKiZLAR2fzUTPw2
UxEmLenfy+rwpq8UUG/ggNiJP8RwmtW4i1nl1S99h2gG3166V/qlU++QgEWoAeuk
k0NFQ5oj77s+4l6hqKBk/j/yiddPrtJTv0afEvzQPTah2T66SIwbz4TtEYC5HuQ=
=ZcBP
-----END PGP SIGNATURE-----

--nextPart1756069.ycY5jvAkVn--

