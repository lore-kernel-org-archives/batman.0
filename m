Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Dec 2011 10:35:41 +0100
Message-ID: <2517338.YUz7OTm7ve@sven-laptop.home.narfation.org>
In-Reply-To: <201112081726.40642.lindner_marek@yahoo.de>
References: <1323260777-30119-1-git-send-email-sven@narfation.org>
	<201112081726.40642.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3637030.9iJ279dBme";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Allow to disable features
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--nextPart3637030.9iJ279dBme
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-15"

On Thursday 08 December 2011 17:26:40 Marek Lindner wrote:
> On Wednesday, December 07, 2011 20:29:11 Sven Eckelmann wrote:
> > -# uncomment the CONFIG_* line to enable the related feature
> > -# features enabled in the target kernel configuration cannot be
> > disabled
> > +# changing the CONFIG_* line to 'y' enables the related feature
> > 
> >  # B.A.T.M.A.N. debugging:
> > -# CONFIG_BATMAN_ADV_DEBUG=y
> > +export CONFIG_BATMAN_ADV_DEBUG=n
> 
> Haven't tried it yet but does it mean the newly added 'activate this feature
> from the commandline' does not work anymore ?
> For example: make CONFIG_BATMAN_ADV_DEBUG=y

It sill works perfectly. But now you can also disable features and we have 
some default values which don't depend on the target kernel config. So Antonio 
and Simon can add their CONFIG_* stuff to the Makefile + gen-compat-
autoconf.sh and everything should be fine.

Kind regards,
	Sven
--nextPart3637030.9iJ279dBme
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO4ITtAAoJEF2HCgfBJntG+ykP/12VsAyBeJmCw/eU9sSA7KmK
5l09DX8IiMXx0lEBz3V4IxLcq2j3qZ2vrghq6dCY8fSWYTXIkrAoHFlKnf1gP6Ej
NuuL7CIcdO3s5A5mK71+95gXWH6XnKQ9pXHbeMmH5V4FVN8iyEFa4gATd6jtnIM7
DqvXXhYqsfpHww5QDnFHqc8dZbdqNhNlTU5G3RubgaPd2KO5RTrX/TCcqDfKuIcM
c++h4dWwpYO7Eia1/zQ4A/M/3lapY1znzjLQ+uVGBm+l9jJ1T2SaHrb4JnnP3Lww
8hgr+S4yUm28ogRZWiz+RQEuKaUxU6pZMsvD6LxMub00IYLMKidJMFjCVl7FkVXE
MdaB96l9Iu6dt2eF8woTLGyGeYiy4CTavaaY8ngmKcgBiTTG+R6vaG24VmIttZyQ
oqjSe28hMkJNWXApV7IX9mqQqvdGi/OJdaQXpkZHYUyTrV20NfcaszANnHDjwBIu
hKSeuRFQYQvhtdogenhtvYGmK5oluT4W85g8UfgHa6jEQO1jyfBrJ934ft5N9GW4
B+hhcqjYF4b3IokhR5i9IioC5tuv2Vl4ZUQ4DvPuyY71KVqCz0mXUYg8vLZUM/7/
cn/cHYDuYATDq5PEzbBEUHSLmnnYxIP0hLFBukxnVZbg58fSgWAqYSAWqczAyLJi
bERLXhOnPUrrp3Gild3j
=oMou
-----END PGP SIGNATURE-----

--nextPart3637030.9iJ279dBme--

