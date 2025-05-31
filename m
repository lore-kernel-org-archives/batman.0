Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68427C5AE59
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 09:59:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EE8C784752
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 11:59:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748685566;
 b=jSE4kGz4zx7KA3MxP6H+0lLPOybb/0uBS7J1aaHDCK8kxqeyQzDTB3AWb5AG/R5/FjNjV
 O6OsXJNVtI6B2CezQ+Jz+KzesWkMCGm94yIMxkGBXad+emgXlL43Ey/wvVTbkIpCo2l6LRy
 j/dzZyhOCIIStxXnGZDjAxuf4Aea3WI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748685566; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=F28uW/kKPBc+Y8EedF7wmeIStqF2kUtY2XQ+UTLAn34=;
 b=0FqGCqShWAYN2c++9IkfK7VTqgbphWT5qHrHTb5hUGPXgEfljNSIrCVZYsHjEZcWevNgH
 43EIgI2ly9M3BNhneIH4beiCIyI77QEOBASyf4zb7+ci11W4DQVQR0kZGT1GsHfonWdWfjZ
 Lex6YqH+sC5YueN64NfSBHkv99T1O+Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CAD5383E07
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 11:59:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748685556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F28uW/kKPBc+Y8EedF7wmeIStqF2kUtY2XQ+UTLAn34=;
	b=2+8HbPJbIvgfdQc0u3DZZvr1ZqBRSAeZguEfPcS5+9kUliNanj3laEP8/3F5m6n0TSzCMp
	TkXd4W/YpmbDNM/9au4Fv3APrsKWI+DG6VK/lYbozrjaPuxpuEIb0JfmaQ3+PY5JfoPyEU
	khhS+iT53LgiQkaOhduUuKHlAdCvVd4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=s4JsNElf;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748685556; a=rsa-sha256;
	cv=none;
	b=SK04KmrYTNvyeY0ajf0bjMbcqG8aVPiDaGk/h1FYFR4HHaFXnYPLozmhyonjYAE9Ao4gkH
	e4tgCtjnDXwAtvTfUmLXvWmk+cqqynQ5oWwst0++3+cN/vexOApz595/GNwhppKnlaQf60
	+8LDx5hoHKqXM//Cb8ZIE+v/GGaYNGU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748685555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F28uW/kKPBc+Y8EedF7wmeIStqF2kUtY2XQ+UTLAn34=;
	b=s4JsNElftbgemCahvFHM5i7zibfPVAa5C95dnFlArOQD1Ow2PQokjqH5SBAe2F/rh5pjeT
	9j9QS8md8jV5P3yncFR4uWkilj0xYGUNNEfnBhCVfHoZwdnjk/P0MnK0PhDMV63TYuAKgO
	c72/3fSlpryMdWVFR03RgP4eMzXPEvk=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject: 
 Re: [PATCH batadv 5/5] batman-adv: move hardif generation counter into
 batadv_priv
Date: Sat, 31 May 2025 11:59:12 +0200
Message-ID: <15478494.dW097sEU6C@sven-desktop>
In-Reply-To: 
 <fd475dcf9ceaa7d14e4f0b4dca668f93e704f370.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <fd475dcf9ceaa7d14e4f0b4dca668f93e704f370.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26338690.ouqheUzb2q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: XER33XJMYFQYO6AEN74NMRW6V6M2CTBI
X-Message-ID-Hash: XER33XJMYFQYO6AEN74NMRW6V6M2CTBI
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XER33XJMYFQYO6AEN74NMRW6V6M2CTBI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart26338690.ouqheUzb2q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:59:12 +0200
Message-ID: <15478494.dW097sEU6C@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:32 CEST Matthias Schiffer wrote:
> The counter doesn't need to be global.

Yes, with the changes from 
[PATCH batadv 1/5] batman-adv: store hard_iface as iflink private data


Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart26338690.ouqheUzb2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrS8AAKCRBND3cr0xT1
y6P6AP9KRnJJUPOIrj7VPA28oI+6BCBzSpYDpPYREKPl1twT1gD/R6ggdPQFEeRJ
rWPV5+4jwZmGS4UipJNC3BrNZrs8UA8=
=f/dy
-----END PGP SIGNATURE-----

--nextPart26338690.ouqheUzb2q--



