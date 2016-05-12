Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 13 May 2016 00:45:15 +0200
Message-ID: <8712759.p24mxYU84N@sven-edge>
In-Reply-To: <20160512210718.GG21549@prodigo.lan>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
 <5284085.o6G6OjSAFN@bentobox> <20160512210718.GG21549@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart35689069.6Vs0dhVXrp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove forward
	declaration by including proper header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart35689069.6Vs0dhVXrp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 13 May 2016 05:07:18 Antonio Quartulli wrote:
[...]
> ok, how about adding it to any header file than (which is probably what you
> were suggesting in the first place)?

Yes, this was my first suggestion. Just packet.h and main.h have to be left 
out. I can also add a check to the daily builds (I have it on my list since 
your last mail).

Kind regards,
	Sven
--nextPart35689069.6Vs0dhVXrp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXNQd7AAoJEF2HCgfBJntG8nYP/005eq9dVSP7eKwkGMBB7Sd2
S3Mzoz9z/5W7DOggrZZuVy0D8p0SkIjtPhYVO/0K7KoRk/f4Cx4/LXW810H85tMS
yfj6PD1HiE1b1eQYwdhnCtCeBLeNTHLRgEVFU3mdw0QHcAR+6GPsynJeexM8D6aq
R2FFRbhpK/viquskiOQDLTZHd5cJAa4taCrKf+sbDJ0kJzQJXLZbOuiBreW+E4i2
p6FanWcBIW9z5TJcVOluaCeQ8/EijI4p/bbcEFkNI2R3uNRsULJdgeMf1E+1Nt3l
bgNyi2Y6cnkKwsvuKe4DfzTBc/Rt/0qygbBcwOE5cPkdDVWt6ZZp08B6uPvFccQU
r7NNOtn7ucTvY1cLeBFDd2iHNUGEQRdrjafgj9HD9Yu0a/BTOr9LZzDrT21x6lSK
cIxC8cAdbFnzxGj+fIOvrrKfP/GGsSAvT8mtH/ur398Zbpj2Uu+LC+fNAX/z4Dp0
g2t9F8+uvG9NnYWfoimazSPvLIqtLISvHBvmYzASwr/ElC8VA1YqvZSRN5P5A5F/
3hPNuGs2Qa5ktlhSwXr+5euWY0I/7JYXGVlaTi5hmNTI6Z8ec9Zt/4t5wF0miq4v
eVjzPYH4+Lvyag+bgrju3VXzEzcsRzrCAM75cs9ZPzAbdU1uiemLNnEovyS1IPnG
9eqEsuPJGYbUyNisll/X
=sRSl
-----END PGP SIGNATURE-----

--nextPart35689069.6Vs0dhVXrp--

