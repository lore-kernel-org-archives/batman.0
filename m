Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Nov 2017 15:36:04 +0100
Message-ID: <7304207.KlJx96cEKj@bentobox>
In-Reply-To: <20171119140517.24329-9-sven@narfation.org>
References: <20171119140517.24329-1-sven@narfation.org>
 <20171119140517.24329-9-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart60460437.ysuWmuGTCV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Change batman_adv.h
 license to MIT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart60460437.ysuWmuGTCV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andrew,

On Sonntag, 19. November 2017 15:05:16 CET Sven Eckelmann wrote:
> The ISC license is considered as not recommended in "Linux kernel licensing
> rules". It should only be used for existing code or for importing code from
> a different project with that license.
> 
> But the kernel still has the similar sounding MIT/Expat license under the
> preferred licenses. Switching to this license for this relatively new file
> should therefore allow batman-adv to better follow the new licensing rules.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> I would ask for Acked-by from following persons

What I wanted to say here: "I would like to get an Acked-by reply from 
following persons" (thanks to Simon, Matthias and Antonio for the fast 
response).

[...]
> Cc: Andrew Lunn <andrew@lunn.ch>

You've also worked on the netlink support (a lot) and you have at least one 
change of batman_adv.h [1] which can clearly be traced back to you. I would 
therefore be really nice when you either could also send an Acked-by or tell 
us about your concerns.

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blobdiff/15315a94ad98af583d207daaaf3f0bcda6c4573d..3b7a636060205a97fac5469ab6ab701ee30eb52b:/include/uapi/linux/batman_adv.h
--nextPart60460437.ysuWmuGTCV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAloW3NQACgkQXYcKB8Em
e0bM2hAAr8/WeZZ9maYZ37jkA08Ndzs4ZpWtHE4NEMggGazAmY7ripC2GeKWtHK2
OGsrkPTaZycMYD+LAhUNpR2d/A9mGWUg69jUXTBABwbreX2mgjFZAETh5OO4h8fK
L0mHJzACVxrbPF3UZAgNunszNqpALt92vP6TKRfQ5BgCfr5Tk1AyXg4zRQfv9h8z
aLRwGsPJjD0LSYL6t348FKwUl1rVj9J4dhJtPavqvQT+vL4idbVovf7Qj/6XJZIy
7JF6YSGW1cU63Uv3jphwUU0YTHUjGfadvfCi9cIYCsvUnZB3HQgCzzuTPj67pZec
KzyRNfeRLf45RwxWOhb9K2oJMY7zWHk8j/3Fq8Ik9CPNBgvurPJXKOwrqdNjNZVI
oOpLy9UCB7J8im7aM3u5uSRPXOvSm5UgM+jTsIWdkSyaN7oHlgf6KwTT973IKLYw
GCohwfd87rOHfXyfdUTfxULsSPrrIo0jTLaiDeMT3m5v9YjTiOt+9YUmtGoQ1u3e
15EB3dPvCk0dk5SWrmRYNwMLjD8dpQYEQMHDXOS6yEfkE64x7SUrd+29L0h9/Ok5
YrlO1tWW/D7Pslz9GNndHZyMKSY3Mx4EtfQz2lmjRh3u9hKqXnwXamBPRPE53rcW
FuQl9qYzBs55rznJjNtXDqdFyxWB8D3EQggowP2lKjvLMA78JD4=
=Jgzn
-----END PGP SIGNATURE-----

--nextPart60460437.ysuWmuGTCV--

