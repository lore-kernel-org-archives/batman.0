Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE70EB64DD
	for <batman-adv@archiver.kernel.org>; Sat,  5 Aug 2023 06:05:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0A34683054
	for <batman-adv@archiver.kernel.org>; Sat,  5 Aug 2023 08:05:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1691215549;
 b=U+Xlyi9t9RCEzrAbZmQB9+ETSqaGDVAr/E0M2WslGut9U+f6rpbUkg6g6OCPRKNx5uSp0
 IuwPGkWtbcD9FieoXkkGWmUja3P+I/hj2EPwbYFkCeKusgH00lB+9Ik75d9G67NRFhMBK6A
 GFfzicbjEgHKDlGMhttfkApqSYCb7WY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1691215549; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yFtMnGLfEgodoGei2h8UZe336PyKSdPdvngnYXixpuk=;
 b=V3glc86VX1ToFZ0zy5W2phL9GOD0MD+YDa6aBs23M+9IA/PVR2r1WiFcOwU22oQYzwGaF
 k9OA58kdeN2Np/0rXWEQeZcSwWip7VQPLOFJcdIta3cAmdN5IHwO8ZL6RyvUgFmGQ42vBNp
 dEKrqXzk4ms0vJ0lPmfYZ+UT9AN+teY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D3D6B80887
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  5 Aug 2023 08:05:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1691215516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yFtMnGLfEgodoGei2h8UZe336PyKSdPdvngnYXixpuk=;
	b=UmVTVUwkbVg+42zCMitzmhYOH95yFwMoqcmJR0I5N2inaBnRQX37cjX9B1Qob0uzSnCWko
	umFfAM54agTct7aL4lW4dHcI4FdztuTTLt2K0N7iMDFVYIYQNk2g/Zf9Qo61E0u6tBKRc5
	VS+KAzw1Bo6m2/LzlgL5MRs5Lw+hW/k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mnIpEaYq;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1691215516; a=rsa-sha256;
	cv=none;
	b=4EsizAUE6I6kbahNX9l5vZgpObP8Jz6N28CO+KAwfAogHkat0LbE+ZvPkjjUic4MSWBJdI
	xeut+zMaEhY19Dunx1wxIFIJab58eRgq2h8jYcdoXVrWJF1oyuMmyf/4b5buQolh0y+8fy
	l0tXNRnmxvRiSt+qrw02LIeH44Sn/PM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1691215516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yFtMnGLfEgodoGei2h8UZe336PyKSdPdvngnYXixpuk=;
	b=mnIpEaYqalGvm/XZ2MCRMjBcckZXRSyH5eNPNCEyomrA1LMmwPHuE64jRdARiRpPRCrHoB
	viphSUE6F/W7jKtbWFdqFJcUVEx5YiTj3O/Lh1xzOxncrA0o1KqEJEjsfaHhEK/4fHO8eZ
	XQbmBdxQaDkwHOEkin7OctVmp3XOwhk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Subject: 
 Re: [PATCH net] batman-adv: Fix TT global entry leak when client roamed back
Date: Sat, 05 Aug 2023 08:05:13 +0200
Message-ID: <2693362.mvXUDI8C0e@sven-l14>
In-Reply-To: <20230804093936.22257-1-repk@triplefau.lt>
References: <20230804093936.22257-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12259810.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 4ZWYWJ6WXCYUGKXUDL4MWRK4TT3ABSNP
X-Message-ID-Hash: 4ZWYWJ6WXCYUGKXUDL4MWRK4TT3ABSNP
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4ZWYWJ6WXCYUGKXUDL4MWRK4TT3ABSNP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart12259810.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Aug 2023 08:05:13 +0200
Message-ID: <2693362.mvXUDI8C0e@sven-l14>
In-Reply-To: <20230804093936.22257-1-repk@triplefau.lt>
References: <20230804093936.22257-1-repk@triplefau.lt>
MIME-Version: 1.0

On Fri, 04 Aug 2023 11:39:36 +0200, Remi Pommarel wrote:
> When a client roamed back to a node before it got time to destroy the
> pending local entry (i.e. within the same originator interval) the old
> global one is directly removed from hash table and left as such.
> 
> But because this entry had an extra reference taken at lookup (i.e using
> batadv_tt_global_hash_find) there is no way its memory will be reclaimed
> at any time causing the following memory leak:
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Fix TT global entry leak when client roamed back
      commit: d25ddb7e788d34cf27ff1738d11a87cb4b67d446

Kind regards,
	Sven
--nextPart12259810.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTN5pkACgkQXYcKB8Em
e0ap+A//aSI43I++QPAWQlTYcHVDZcDtCcVIk9qdSEvQtO62jJZYnBYyLZdvkcvY
/cQTjjSZY08wCzU3c9TEHPPnrZruRD+pDNn3m64izZhQ2BmAuHwIztociQytinan
I3oDTBL7wZYZu+66t/5NtRyD4vVE0Vr+1s0U1TR2DYkGALKsD9VGJOGKGLAJSF2i
PgDVjjDgqkEtdjvTnpC3a4phFumVfJLgNJBuuQ7FYEb+VQf37Wect8du4dMy+GNw
ifpZ+bqXWFKt0WP5M8r8T4M+NIpm3cS6a0ij3q4IVNI6xWzpmWjIiP2UG6lzpHna
BXOfPm2F7ArycTyyijg30hnTv3oV43Xpyy/vqMA7jRQRmnpeh9l96Rsew/MOouPQ
KUco8AazBnqOmX5fqpu1+uZFC+7h/ADVaUF6sbgfSQtyxPp0ggBAIAAAaHFfvGP+
1qLhIHCGPjdQVqRNpSHR85x5V5NYdlKwa91f/LE2oKz4Yt207/LNTeUfmYxeykz5
FsBwZPf77gdBCn0V533zqgreZ6aldqXp6+SWcbrKPChoV0h9AhfCsRQZGs+q4L6Q
Iwrh/iP+RQzWWLS/l6Xj9P6GSks3326kcWFPQwssdtXTZXPWAAhQ+m8lzIXbcaJ1
UGHrl6QLoNNr4/pnqCuTQmECHnSlMj//uB+KE1HaLp3JQZtV6z0=
=dwZT
-----END PGP SIGNATURE-----

--nextPart12259810.O9o76ZdvQC--



