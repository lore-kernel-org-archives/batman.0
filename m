Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 01 Dec 2017 08:58:55 +0100
Message-ID: <108010722.Nn6OHKNu2M@bentobox>
In-Reply-To: <20171128073915.11117-1-sven@narfation.org>
References: <20171128073915.11117-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1682626.z9y0SORoze";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: setup_timer() -> timer_setup()
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

--nextPart1682626.z9y0SORoze
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 28. November 2017 08:39:15 CET Sven Eckelmann wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> This converts all remaining cases of the old setup_timer() API into using
> timer_setup(), where the callback argument is the structure already
> holding the struct timer_list. These should have no behavioral changes,
> since they just change which pointer is passed into the callback with
> the same available pointers after conversion. It handles the following
> examples, in addition to some other variations.
[...]
> ---
> TODO: this requires some compat code because this functionality was
> added first with v4.14 (we have to check in more detail)

Forgot to say that this is blocking the next release. It was merged into 
Torvalds' tree without spending its time in linux-next and directly entered 
v4.15-rc1. 

Kind regards,
	Sven
--nextPart1682626.z9y0SORoze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlohC78ACgkQXYcKB8Em
e0YGKhAAzeG/Senns48p+u9ysaIIEaJP1B8QIYC7Y1tTQU+sNEKI42W8jC+f6xl/
igcVMkYJcp0NzytJQCzLaTEJc3pkb1mIkOGDUcucu/ynfrw+Dzmqck8fzqmmaQfE
JFtF6QQHymgCK8rBleR8erLHUMq3n3EpEfMoU2RQNB4uOhUqkPmKEM6jTXkD4zJI
VU+PypihIp50fSzq/OvKXi/BsncQO9hOfyYxXYepAhy4ClXCnBbW1oavbEANPSyz
7vgNFSgUGMA81QjAIF777yDH+u0+SDTZKfAkDkhNK8nJcFc71SJzODIiPTYOyeHI
uox/JD4QbR8M2JXIL0yR2XU1PR57Kojneco/3S5PKKrRQnSayuBzL9AXeMrYBa4/
7bcoArnIhzBw2oCWYbCfi5fkM6Kw62mquudNHesLQ7jl5bz/GLIJX1ZpZ0KqGuma
FPu8iUbVNCV/09nMANd7A87jFvPmpPT+v+H2EyV4fcfmJT2A+BFOwy1tcOYg1g80
A1jZTRwXHkUkdDHw0iwO4rKU5tm4yzcmJrEEr+1Gl6nQf5ZRhiTUlk6XGkX+wj5h
taciemCDFesSp/eSVFMCZdBKHan6vzDKwHqIe84F0YO75JSrjDIF4Mtj0ErKGpPO
43+fpGvJYhjv7IqxlbQAhbaDSUzxKzR5aYYFeUpR4BYZPItl6wc=
=yI9/
-----END PGP SIGNATURE-----

--nextPart1682626.z9y0SORoze--

