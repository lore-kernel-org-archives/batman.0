Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Sep 2016 13:47:44 +0200
Message-ID: <6384558.y6Bohapl4F@bentobox>
In-Reply-To: <OFCE68AE93.BFBB6428-ONC125802F.003810B0-C125802F.0038B302@phoenixcontact.com>
References: <OF679B1A8B.6DAC88DA-ONC125802F.00308C8E-C125802F.003170ED@phoenixcontact.com>
 <1739945.WLjKjG9su1@bentobox>
 <OFCE68AE93.BFBB6428-ONC125802F.003810B0-C125802F.0038B302@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4470351.tEeeQM9tTz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: batctl: problem with #define
	__unused in main.h
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andreas Pape <APape@phoenixcontact.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4470351.tEeeQM9tTz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 15. September 2016 12:19:20 CEST Andreas Pape wrote:
> Hi Sven,
> 
> this patch works for me. Sorry for not finding your patch in patchwork
> myself.
> Stupid question: how and where do I reply with Tested-by....?

Its not a stupid question. You can download the mbox file containing the mail
at https://patchwork.open-mesh.org/patch/16673/mbox/. Just open it with your
mailer and reply to this mail.

Or you can (when your mailer allows it) use the In-Reply-To header and point
it at 20160904182331.18118-1-sven@narfation.org. The mail can then be written
like any other mail.

And when your normal mailer doesn't want to do it - (mis)use git-send-email:

cat > mail.mbox << EOF
From: Andreas Pape <apape@phoenixcontact.com>
Date: Thu, 15 Sep 2016 13:40:09 +0200
Subject: Re: [PATCH] batctl: Work around uclibc collision for __unused

> uclibc on 64 bit systems uses struct members called __unused. These
> conflict with the definition of __unused in batctl. Such a conflict results
> in a build error because the struct member will be replaced with the
> __attribute__((unused)).
> 
> This can be avoided by renaming it to the Linux kernel name
> "__maybe_unused".
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Tested-by: Andreas Pape <apape@phoenixcontact.com>
EOF
git send-email --in-reply-to=20160904182331.18118-1-sven@narfation.org --to=b.a.t.m.a.n@lists.open-mesh.org mail.mbox



I hope this helps :)

Kind regards,
	Sven
--nextPart4470351.tEeeQM9tTz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX2opgAAoJEF2HCgfBJntGkwMP/3p4aLMRmQ8/EJdC3fDgTkZM
Al1UbyMiEGv5uQbumh+7UV8qhBAj5DVzVYBxmclqRSYD/l+Hny2Csqydzwh3Fyhd
YeZtpW4QNm59eBD1Z0ae5Sxya+EjmOT5AUwvpyILl8jl1sTNEmtFtNrETCxn/x8q
FLWrZuph88zESLbBqkHmetrt//3cz7dmF6GBYcehQA9NQ0cojyAzG2KL2F5CbK74
BeFlQmGIX2H9erWKHu8cTPfgRGto7kUmxPAai6VKynnNG/QasyT9auB4lInQrulX
wDN4iktuAEp8v9HwuDtsjmXuJI/kFBmfH+qXarlKSdj92NfnVL+QRASw437GPUAl
WUYLIjNSkUayTVsRDByj7PmgCsFPHU3zTgAswWW41bseOgQM4zqsW4iu07eogax0
VPFYh3yNzNr1vPnaJdIKaXLvOL55NQc7SqS3KfXoGAbTToJMy4VZvSaopYVE3RFN
VAxoovMY+GwU8+hd15+2vFVp5tQ/tLm8uKNyuWxSz4Vu2z8frs26S/YVez8nEFHX
rHdneTsxUeZezK48RiNBy0g2s5ptHqqCpyztziTl/xqh4oC3C/WKw6ub70kkDm3w
YmEcZDyC0Q/coPC+4sBvJsU14j4Y2ninx8OiAJqoh2Ctzfgy1+XNxdHdsvKixaJB
MNfS6b2orpUVv3BPRdmu
=7sSo
-----END PGP SIGNATURE-----

--nextPart4470351.tEeeQM9tTz--

