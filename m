Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2011 21:03:03 +0200
Message-ID: <2114852.SJZ20Nucqf@sven-desktop.home.narfation.org>
In-Reply-To: <CAFevQmP3H-pEYDPfnpYP5eT1qvQ20v3fBGfwMJX7+7ZGJvYKVw@mail.gmail.com>
References: <CAFevQmMBoHLeQOhvYv9bYWh0YS7WYXDyL=geH9EcsqqgVeBj+w@mail.gmail.com>
	<16914270.mta8dqh2TR@sven-desktop.home.narfation.org>
	<CAFevQmP3H-pEYDPfnpYP5eT1qvQ20v3fBGfwMJX7+7ZGJvYKVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3122628.COKUrOvnLX";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Compile error on openwrt with new patch
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3122628.COKUrOvnLX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday 18 October 2011 20:57:53 Filippo Sallemi wrote:
[...]
> > Please create a new checkout of openwrt, add the feed, add batman-adv to
> > the config and build it with V=99 (the clean checkout not an old one).
> > Add the .config and the log to you mail.
> > 
> > Thanks,
> >        Sven
> 
> This is my make V=99 output after make distclean and however a fresh
> checkout of openwrt.

No, that wasn't what I asked for.

> 
> make[3]: Entering directory
> `/home/fsallemi/Develop/backfire/feeds/packages/net/batman-adv'
> gzip -dc /home/fsallemi/Develop/backfire/dl/batman-adv-2011.2.0.tar.gz

What is that? 2011.3.0 with patches from 2011.3.0... this will _not_ work.

> 
> | /bin/tar -C
> | /home/fsallemi/Develop/backfire/build_dir/target-mips_r2_uClibc-0.9.30.
> | 1/batman-adv/batman-adv-2011.2.0/..
> 
> -xf -
> 
> Applying
> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.
> patch using plaintext:
> patching file translation-table.c
> Hunk #1 FAILED at 1054.
> Hunk #2 succeeded at 632 with fuzz 2 (offset -448 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file translation-table.c.rej
> Patch failed!  Please fix
> ./patches/batman-adv_correctly_set_the_data_field_in_the_TT_REPONSE_packet.p
> atch! make[3]: ***

This is a patch for 2011.3.0 and not for 2011.2.0

> [/home/fsallemi/Develop/backfire/build_dir/target-mips_r2_uClibc-0.9.30.1/b
> atman-adv/batman-adv-2011.2.0/.prepared_d634b3efc2524a3909e7512491480870]
> Error 1

This says 2011.2.0

[,,,]

Kind regards,
	Sven
--nextPart3122628.COKUrOvnLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOnc1nAAoJEF2HCgfBJntGQKQP/11uFLwoNTdmJzqO+2YG2yjU
/K4EaMBHA0rgLTYB/jod3ad1fqP+g5/zgMYSt8N73hY8CNOm6M+OIrkwjbl+mwey
w6/hMkleLFue1aTyGWRqt5dynTINAihCUtRIGkXQqTQQlZVIfeTPWmS/plJgCnpW
mV0OHDIcvNjMz9+jOeO6cgkiJvhAQ/zUPdMNs7p1dYCvfXqf3o1ETC3i5TH+Wvia
9/R0jcUtxgF836s7OdwKXctXYtIf2Nfi5HIX0BkTDJL6V71x9yBnzc6Rld5Ay1rQ
fZl05tsS+gnsgxLVkPusP4EkoKdiWg1OMqrYe2GqKlWEj/aiH4EYmidsjtu/CSHT
+xAVi6IHqFU6NSMdwDEVCuPpMqaMtrz+U7D9J3GhIvw8iETbmULKsd2WCOWB/Xh8
JfXavy6tBf+WFw+uvmVkGrXpP/pICPP7SW31+kVG+Y/n3tyRLe5CdUJWrYJsQxLq
BpEohH4+r2xj+nlLPsjfTj/kvkYSRyWG9sY0zTudN0XXvsTemWzs84jq3xRRxCdW
Cm+n2XpYu26a/4mDFzGlZstYukbcm0Z4My8TKKF3RUgmgTg5m8wZb8C4LCNqilnB
lG1lOmfiuXphE14HM8NIZGBQuU1r6xEUVs6epzAt3goudDkKo8nCzaWzhNz8WWmZ
NOZ7OOjN/jzdbdLmmkac
=b0Fz
-----END PGP SIGNATURE-----

--nextPart3122628.COKUrOvnLX--

