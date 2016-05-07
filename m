Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 08:39:54 +0200
Message-ID: <1906308.Wsn34X6QAt@sven-edge>
In-Reply-To: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1724613.lWiqNDUSuE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
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

--nextPart1724613.lWiqNDUSuE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 20:45:50 Jonathan Haws wrote:
> I am trying to get familiar with the Alfred tools and downloaded version
> 2016.1.  Unfortunately it didn't work - I couldn't get past a bind error:
> 
> root@sierra1:~# ./alfred -m -i bat0
> can't bind: Cannot assign requested address
> Failed to open interfaces
> 
> I had setup batman-adv with the commands:
> 
> batctl if add eth0
> ip link set up bat0 (eth0 was already up)
> 
> I rolled back to 2015.0 (per a hint at
> http://wiki.pinneberg.freifunk.net/alfred) and alfred started up just
> fine instead of giving the error.  However it periodically gives the
> following message:

Thanks for reporting it (why didn't FF Pinneberg report it?). Can you please 
try following workaround:

    make clean
    make CONFIG_ALFRED_CAPABILITIES=n
    # only when you've installed it before
    make CONFIG_ALFRED_CAPABILITIES=n install
    # try it again
    ./alfred -m -i bat0

It would also be interesting to see the output of `ip addr show dev bat0` and 
the used kernel version.

Kind regards,
	Sven
--nextPart1724613.lWiqNDUSuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLY26AAoJEF2HCgfBJntGKgsP/3sUHMyIqAzlo/XU27PfyRU6
2I5iIMGMoYa42ya8bZWWIdsTBeYbXBOe9l5J8xQK9QR7+I86ijYmFcKtRxR6hQAo
sQUWw0pEjQd+Wr4/0oMLp2gfDhalkoOvOcgFALQk2n96kG0SmFycI6osk0Ba0pXa
TOc71jpavBTr7lamK4FCu8t0pBQ3X55qKHBD4b2CyLKAjIk9u0PFVf4TRzcoiFBo
SjNw5Iftfxz/trux6hbNWhMXhs0Us0vJB5hpEeeFOdWKCsOj348yOSmxgZtQSlrr
kt+b/ET8XyQBGOI17eKfwde0L1SOZzZZlJiRj/RYZS4gwUTYiQdL/Pm9i6OlSFyu
TwI4mn8FP3gDytkSy1foUUYV0VFCb5OLgE0ka/DT+C3xzwht4420GDYwQSnXE9iy
wMHMeF1QiYizi6k1CIZrCcIamlbaIa6LzIjvpLlOK12G+ClbhUv6qEbI2NHhu3CW
jYmiP6EG9c3pT6SESFPfUZZr2TyBt5T+VncmxQYS4pGeMZ88Tw6wO44cSael5JLJ
Q7KfCMOZgFAIHoTCUon5fHS9FBk1nxKvSq++nL7ivIHMaEpYNQkGkl3zXtyX1+D+
FHTRXDdhKCeHzlSjszh8sf7BLYfHk/C8avB4nM+lNMF7BzbPg3K1ZDBlydGizv5W
q5bP34xb3g9FMtZNzP2L
=LbaJ
-----END PGP SIGNATURE-----

--nextPart1724613.lWiqNDUSuE--

