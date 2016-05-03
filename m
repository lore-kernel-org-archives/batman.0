Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 May 2016 11:51:45 +0200
Message-ID: <7540010.c2KB6pSlZv@bentobox>
In-Reply-To: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
References: <1462222618-29761-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3500792.v20CdhozvC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: Use netlink to replace some of
	debugfs
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

--nextPart3500792.v20CdhozvC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

>  #include "debug.h"
>  #include "debugfs.h"
>  #include "functions.h"
> +#include "netlink.h"
>  #include "sys.h"

Header file is missing in this patch.

Kind regards,
	Sven
--nextPart3500792.v20CdhozvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKHSxAAoJEF2HCgfBJntGw2YP/0b9nQnzAed01aOh6YRUe77S
wInw3nIxzXx4Z2udFLLuYHxjQb69RyyHRZf6z3aQ4c1AYjHekBKsZ0FgVumRQftU
IJfC5yEuafwfQym0uMV9baVKrIRCXeVdwfmdVP7vhFTXoe/huMA6TD45bxSvjTIZ
615zmjTCB7jxLfr7TzjzMXlg19vVxUWjt5j/W6oIQmUk+MHbhda25RKXsyTzk8ZY
C9Sr+MgGCLhxaenc3M1DmWjuk2BnKNnJlDFhFhaymfgI2EcDyEdif28pNLCdHdBK
8fV5ZjX4lFTAG1OuRHoCCcMGD9/Lfs6HiM4PYB0CvCdKfVRPMrDyh7CMsKAjpJhh
klEty+qvElnlMUxrISbm5sZRLZzQLaDTflvLRR7HCkC1oPoWGffKyZI6MJWxMlQT
0e6ZddSvshtf4uonQdks3Qmqov+FYCxnHgDT8FeabGzKR314Bt3eZLnaU3iBMvaj
2RTIweeDL3j5EhBsZ2W2qfzlNcklwoVAPfME+uIZK2ZispsNhoMbD8ibYl9POObl
uVPHF9FDzUU+XM8MTiVD+4p/FKepqmac1Eub1c4xRqa/1By4SE5nR40TbrmVLNb7
99THo7JX2Vmp6e2RFj0liOinCSkQdGMytrdWvZI2J8JWgj3hxGicdGhS8NKs6N20
s04lw/egkcbP9A5hq2KC
=Obz1
-----END PGP SIGNATURE-----

--nextPart3500792.v20CdhozvC--

