Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Oct 2018 16:35:30 +0200
Message-ID: <3433076.Se5es9OeEg@bentobox>
In-Reply-To: <CAPzaX0gNh3g6wUmZJLuJnixYNVEkYjdiL3E=06acrSDw2amtvw@mail.gmail.com>
References: <CAPzaX0gNh3g6wUmZJLuJnixYNVEkYjdiL3E=06acrSDw2amtvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11851054.BCmSWuL55R";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Additional Assistance
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
Cc: Corey Combs <combsca90@gmail.com>

--nextPart11851054.BCmSWuL55R
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Oktober 2018 10:22:29 CEST Corey Combs wrote:
> All, thank you for the replies yesterday.

Why did you start a new thread and why did you use such a non-specific 
subject?

> Would you be able to offer
> some more insight into updating the 2 packages? I have had some
> successes, but not all the beagle bones have
> recognized the new version of batman-adv when I run batctl -v.
> 
> The general method I've been using is the script here
> https://gist.github.com/marvin/186a609d1e88f7426747 with version 2016.4.

The script mentions 2014.3.0. Anyway, both versions have known problems. See 
https://git.open-mesh.org/batman-adv.git/blob/HEAD:/CHANGELOG.rst

[..]
> I have also attempted to uninstall batctl and batman-adv with
> $ apt-get --purge remove batctl
>  and
> $ apt-get --purge remove batman-adv
> and reinstall using the script, but that hasn't worked across all devices.

Ok, I have no idea why it failed. Maybe because it wasn't successful? Or 
because there was a problem? Or was there maybe an error? ;)

A little bit more serious: Any info what failed? Any build errors? What does 
modinfo batman-adv say? Are there multiple batman-adv.ko in your 
/lib/modules/... and the wrong one was loaded by modprobe? Does `depmod -a` 
help (generates the module.dep again)?

> The laptop I have is running Debian 9.5 with batctl debian-2016.5-1
> [batman-adv 2016.4] and the Beagles are running Debian 7.9.  I would
> like to avoid reimaging the Beagles at this point in time.
> Please pardon my lack of knowledge on the topic, as I'm still
> relatively new to Linux and have been learning a great deal in the
> past few months.
> I greatly appreciate your help on the topic.

I don't want to crush your hopes but if you use broken components then you 
will most likely end up with a broken finished product. And as I said earlier, 
there are numerous known problems in the batman-adv versions which you've 
mentioned earlier.

Kind regards,
	Sven
--nextPart11851054.BCmSWuL55R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvPMbIACgkQXYcKB8Em
e0Y7ShAAvG7pmOrqqdDwts6Jwt8Hfs4yiAoQJaacsRn5Sip0MIF3iDNGCsjA99nJ
5W69VJ8Qyjbp28ZARz8i/foMfWYpGCHAKsh1YDqCYUmtZR7QKcveaGKgaXPZsbfX
NxTY7VqucX3MnVYud3Z4pY+DDJNIegsGZ3yrzs6tjc1jpQqmpYohC+TxQKT4g/Mk
AWGlKcklw5xYL/q+w/vGDPx97yQ/crCERfQoa4YD+CJE3GaGNFG3XoNhQTeJ+qgv
FfQ9ZnKLlSjeD98G5gGuLEsGsTZRS2zFpGamvLL9KFugAfk4jP9PWU3PgP+sgaww
ADgXuufI0tf6w2zS4C/0xb+ZWlvCMmQWNQltzxjKLgXRu8zu/FrYwa1xgLukYcqC
gt/er99PFkYliCvSxJihk2LequoW5/AMI1W7Qn/ApoBGRP+slsHx5iWGxd3yKARE
Zyz3huoF5PCYL2KKAElA9yX/FYEQWRoIVTmtZrHvu2TR1CKciO1q9bwiRqAcxoDt
7DwLmKyfVOOCN0j8vSNtzsQ34aM0fVX0v6hO4N5gtTSAHxwaPXbu+NYl3b1Sj+b3
SpvuCS/IZFGSQg19buup6cEZfxYMvCYTrP5rU8fzwSqWAMX/QkxTVZVTSvXUpaZO
jiBD/5wslLy1M+EPXN9dX6ltwo5tk9Aw9vY2lM7FUN6UkoEAwug=
=zU7b
-----END PGP SIGNATURE-----

--nextPart11851054.BCmSWuL55R--

