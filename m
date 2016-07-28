Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Jul 2016 19:41:07 +0200
Message-ID: <31954371.21uiIYPYc7@sven-edge>
In-Reply-To: <1469726363.5505.7.camel@c00941>
References: <1469726363.5505.7.camel@c00941>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3205791.yIyMBbJBVC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Externalizing ALFRED_INTERVAL
	for setting synchronization interval
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>

--nextPart3205791.yIyMBbJBVC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 28. Juli 2016 17:19:22 CEST Jonathan Haws wrote:
> ALFRED_INTERVAL is now externalized via the -p option (synchronization
> period).  If specified as option, user supplied interval is used,
> otherwise the default interval of ALFRED_INTERVAL is used.

Fails to apply because your mail client corrupted the patch:

Description: alfred: Externalizing ALFRED_INTERVAL for setting synchronization interval
Applying: alfred: Externalizing ALFRED_INTERVAL for setting synchronization interval
fatal: corrupt patch at line 30
Patch failed at 0001 alfred: Externalizing ALFRED_INTERVAL for setting synchronization interval
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
'git am' failed with exit status 128

Looks like you are using "Evolution 3.10.4-0ubuntu2". Please check
 https://www.kernel.org/doc/Documentation/email-clients.txt for instructions
how to force this client not to corrupt patches. Or just use "git send-email"
(like most developers)

Kind regards,
	Sven

--nextPart3205791.yIyMBbJBVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXmkOzAAoJEF2HCgfBJntGhBwQALls8+96ew6QYSIMIgiVGiIt
73Qv8d2b3Aocp2vnfNoc4eN0BtPLlFAdzSZSQ0q1PoJAu2Z7NEoI8Z0ON5LNS5or
Y9Z+99AqBnLIrgR/CrsCUJCmuHQ/0cO0eMcF/FL/5+RvgcfKeo/OAxLhyhv0TNRB
m8WGd5fuQWTAtg9QFRTXuzJ8ULGLZ9+yvXxcwDjjzWlKkPtyKYWAeAKXOtbavhM3
a8hfNsjauSpq7EcwYZ+btBZ0UH7lWvM6nV0wiMUqUC/yzRQLGdMBxz4HKEy+N/vO
JmggfBUuJ2C2zz9AK99TQtb7RPtDEOMSokRb8mWg4Gxa2KL6mZdmTZKGUWV5arX2
E298NdP7REQ2yc8kl2+19IFr6XTk1MvrNJWhSf7cf2QM9HgsLzmQ6IaHT5EJ+ClX
YO4P+k7EH9Z7WqMcWZo5els16DQaVANjY5fJLctl2lJJEACd+a9e6M8wNrVsQdxJ
/YWz2ew10sjBNX8z9ygbc246WeDL3n7xhbHa2eSzvX/WDtGI6IuM7q1OXJ1jJVKg
1LSdCTRe2iuAPKqxD8iLtpF2oETqBRwjbxxP9vDF8zmHsKQ9oVs7ZonbAYZWcj0H
qAd7ox/Wcy88tPmQagFamhfSJmH7BjimcI1mQQdV/PFpVHCX4t7KoxxODTuA4jeT
REGRCA/cp+EvsqpwWiRI
=8oaq
-----END PGP SIGNATURE-----

--nextPart3205791.yIyMBbJBVC--

