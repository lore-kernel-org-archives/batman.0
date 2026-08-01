Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA0C54FCD
	for <batman@archiver.kernel.org>; Sat,  1 Aug 2026 09:54:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 81EB881BF3
	for <batman@archiver.kernel.org>; Sat, 01 Aug 2026 11:54:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785578088;
 b=LZuAJExKUaL8poQyBRYvVPmTYr/pLCNhNpUnTAIEKuPdQvzE9x/IWvBq9Qyz+UfhYFXLd
 UXQdEOTZucFMLXlQ2Dyo2t0aQF6KLZVRR4HoMrDz5pWu1T/iamGP9Oh4lFx72MYA7C4m0vA
 RVB84u4FIGLc6bmwm6s0U+bEiDDKN0g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785578088; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=31562uwLfTYNq6vgE78qecgqtQEB+BtbSBg2bmrtk2g=;
 b=tCG9yZjo8Oq9jI0w/vYtb6Oi/BPsO0tSn4TpVMBylAVnTWyhakM+nPYP5PU4zrOhST2qG
 sT6PVUn1sTZ6GWcp7Im9d+WpBt9ayQFjdGLC5v/5dqmKdtNLGSmNEdPK0M580vG2j2LiJRu
 ArcDZQy8cwvX1N9bwLPMtobsZbnKlxo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 94D2F80FD7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 01 Aug 2026 11:54:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785578067;
	b=L4/BN5A6HGMt3X6sJPzKb5BD+SyDznDt4ToFTnTDBpUhVCUEfOiyw9S/9VPYwVH0qr4Y50
	CA2heJljxzq9IAMLt3Dj5lj35PdIjUpO8vlLXmOVAHqQhnBlceGa75sJ1upqdHb80QPOA0
	RmNFKr0eS5lz1/pHBbeGmhk04H8NxqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785578067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=31562uwLfTYNq6vgE78qecgqtQEB+BtbSBg2bmrtk2g=;
	b=RsGn/RDGEPtB8NTaNK8vNHIE4lns0q9EFnjMemnRtwUz3cULEBbeDJW7J9iwsVP3dRr+mf
	EQTVpPzwgMTpLu8FZCB1tphtahRDOnKxeFYgzpP+xxIkZlmyaUlSlxjFsi2Z+ukYv+T0Ze
	E6cSsI8WYa2CXNcXSoHSqJo7jZTx1tQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YPNFyxQS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3AD2620019;
	Sat, 01 Aug 2026 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785578051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=31562uwLfTYNq6vgE78qecgqtQEB+BtbSBg2bmrtk2g=;
	b=YPNFyxQS7DoF+/7/wXiAfuu71tAm1xL0rMWtDeYulWx0q3ZGkWI1urZ/cAPM7I8DrAjlRN
	iSmuGKXoGTyoGIR3yRz7vlXqTTvW+KLR6bABP9ZUOnUyUjSkAYa0LQXHcVOxUZTg7rXIjC
	lJn4rzySb9f7Ejk9c3UGAjafIi7q/Pw=
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 "Kernel.org Tools" <tools@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>
Subject: Re: [PATCH] batman-adv: reject unrepresentable multicast TVLV offsets
 (+ b4
 check signed-off-problems)
Date: Sat, 01 Aug 2026 11:54:03 +0200
Message-ID: <3801416.R56niFO833@sven-desktop>
In-Reply-To: <20260731135222.566367-1-david.lee@trailofbits.com>
References: <20260731135222.566367-1-david.lee@trailofbits.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3933016.MHq7AAxBmi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: F3Q3JNVVQX7UIN4OA6PDTBRYUEOWOGAY
X-Message-ID-Hash: F3Q3JNVVQX7UIN4OA6PDTBRYUEOWOGAY
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F3Q3JNVVQX7UIN4OA6PDTBRYUEOWOGAY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3933016.MHq7AAxBmi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 01 Aug 2026 11:54:03 +0200
Message-ID: <3801416.R56niFO833@sven-desktop>
In-Reply-To: <20260731135222.566367-1-david.lee@trailofbits.com>
References: <20260731135222.566367-1-david.lee@trailofbits.com>
MIME-Version: 1.0

On Friday, 31 July 2026 15:52:22 CEST David Lee wrote:
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Another thing just realized (and for whatever reason it was not shown by b4): 
Who is Kyle Zeng <kylebot@openai.com> here (what does kylebot have to do 
with the patch)? David Lee <david.lee@trailofbits.com> is here marked as the 
author but didn't even Signed-off-by the patch. See 
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
(see the end of mail of pending things for this patch)



@Konstanin (Joe/Andy): Is it to be expected that 
`b4 review track 20260731135222.566367-1-david.lee@trailofbits.com` -> 
`b4 review tui` -> "review" -> "checks" patch doesn't show the Signed-off-by 
error in the checkpatch check view? When doing it manually, it works as 
expected:

$ b4 am 20260731135222.566367-1-david.lee@trailofbits.com
[..]
$ ./scripts/checkpatch.pl -q --terse --no-summary ./20260731_david_lee_batman_adv_reject_unrepresentable_multicast_tvlv_offsets.mbx
./20260731_david_lee_batman_adv_reject_unrepresentable_multicast_tvlv_offsets.mbx:52: ERROR: Missing Signed-off-by: line by nominal patch author 'David Lee <david.lee@trailofbits.com>'

$ b4 --version
0.15.2

The difference comes from the "--mailback" option which b4 adds also to 
checkpatch. I have therefore also Cc'ed Joe Perches and Andy Whitcroft because 
of this suppressed error. The following change would produce the output but I 
have no glue and just fiddled around with the script without understanding the 
bigger concept (of checkpatch and why b4 uses --mailback):

diff --git i/scripts/checkpatch.pl w/scripts/checkpatch.pl
index 7a846a3ea1273..ccb2ec78193e0 100755
--- i/scripts/checkpatch.pl
+++ w/scripts/checkpatch.pl
@@ -7846,12 +7846,6 @@ sub process {
 		exit(0);
 	}
 
-	# In mailback mode only produce a report in the negative, for
-	# things that appear to be patches.
-	if ($mailback && ($clean == 1 || !$is_patch)) {
-		exit(0);
-	}
-
 	# This is not a patch, and we are in 'no-patch' mode so
 	# just keep quiet.
 	if (!$chk_patch && !$is_patch) {
@@ -7902,6 +7896,12 @@ sub process {
 		}
 	}
 
+	# In mailback mode only produce a report in the negative, for
+	# things that appear to be patches.
+	if ($mailback && ($clean == 1 || !$is_patch)) {
+		exit(0);
+	}
+
 	print report_dump();
 	if ($summary && !($clean == 1 && $quiet == 1)) {
 		print "$filename " if ($summary_file);

(this is just to show the cause - not meant as anything which should be applied)

Regards,
	Sven
--nextPart3933016.MHq7AAxBmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam3COwAKCRBND3cr0xT1
y0m5AQChINdIzm/w0zU7bfoEbd9BJ5+g/WSUN+VWYEDRgtHNCwD+IW00Wn77OkYu
fXiFXJUuvzn420Zc+jPEKhYkJB01gw8=
=/H5g
-----END PGP SIGNATURE-----

--nextPart3933016.MHq7AAxBmi--



