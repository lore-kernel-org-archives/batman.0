Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 09 May 2016 18:28:29 +0200
Message-ID: <1689798.ZJlLjAlgFP@bentobox>
In-Reply-To: <1462372207-28322-1-git-send-email-andrew@lunn.ch>
References: <1462372207-28322-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4088653.ajKBhvSZps";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batctl: Use netlink to replace some of
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

--nextPart4088653.ajKBhvSZps
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 04 May 2016 16:30:07 Andrew Lunn wrote:
> +       [BATADV_ATTR_THROUGHPUT]        = { .type = NLA_FLAG },

Why is throughput a flag when you access it with 

    throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);

Most likely just a copy+paste error and it should be NLA_U32.

Kind regards,
	Sven
--nextPart4088653.ajKBhvSZps
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMLqtAAoJEF2HCgfBJntGIiwQAM4lEVs+PffT2bYDRZw8ZskP
jq9oHEjzLttS5g+UpvnCx/mqZdrZtVl0Wb86zS02CEw26TPqX1ThJqcUta2Saj+g
7k2hWNHre/xThmpyH14486l9PAf2Lr8SDbzvYfa2WB25nhzqKkW2MPxUNmAekgQj
Goj16iRkjJYYEpTo/fiKqR0zlYU4+QN+ui4gx+Fo2UMjdFeb7Ll8l2knkRBWPWg/
5vXLQgQqAzWoPW/d2DbaRpiyGGSOzQqVrmE1GRrI+s6CeNJ8wi5i0YJNoJWxFyCJ
+P1nlYcwuTXUfa3MLDCLpTAv1IGPWZFrjeIYVO/YjQRrwwQfCmlpSqdFhmztz6Fi
Hi/wUPt0DEpLcByjzdmt+SBzVJYDi78XzeErWpyMSb/DzCK5wCHhDoaMzubT4jSI
ONfAsJPyQxDS+G6+jLfkPIsD8nSdjsGWWMEW/t3K/FouH/SrSN6gDmFH3ZzpLTyq
l0OcUfGmpelo2/jEaRCuL96pwLvtRk7Hiko10SuFYgJyjSQLxq5yF1LEIvSnYLs5
KJO0AwiMHnhv5eccKa0M0ChOO2OqB2o+TLmx1UCffnU29X8oYw4LLUccxblOJaG6
aSzveIXsl9FEF+wKJg7QgC1YrGdfNljD0CN+CIVRhtFqj/EAwPL1RuBi4IFoJ6Ei
MnaDWwGF00X0scKx/zt4
=MwXi
-----END PGP SIGNATURE-----

--nextPart4088653.ajKBhvSZps--

