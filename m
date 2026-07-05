Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDCBC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 12:49:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4E51F843A8
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 14:49:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783255771;
 b=Ors1QWFSwvgXzTEmagY9cMg71imHrYUoIdWeBBEGCCSI1TfsYUYC+3UDmsEpTBU23i5+s
 BjccTfeIaSF4uTBip9nVvD2pskQIIiC1PZHC3LxWWEazmNUlIfpU7LsibdrjEjf8DZCzEHL
 O0N4U4EkP5SZ1altAW5FXony+uw/3EE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783255771; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gG5YEQQ0ya2xrSmb4qkA9sgc8dQP/I7KKnN0q2GSBfw=;
 b=eEwqHQ+S8JsffTI1XoWRYeB6KrozMhSt+A3xF44hBhHfWDzLesEmv+Frot71xPcvhdgVk
 DfX4XrNRoqIvEF8BgFBm7uYRZJK12lGwtdG8URmzD2FOer78tWZi8XGFyUeKSqsIoeXI+eE
 rd+DwjCeguZ+hJBX3wTz/QFgy/2RKjg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 97CCA8325C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 14:49:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783255750;
	b=g8hUW6OzRIS3HqHZVTPT6RK+yMcizp77c3dFBhA/T3j8Ce5MKLRpiQW521rfu2HlYJ0Z1l
	uscx2QbvoB+W4rc0A2SKs5cvszj+rC4XzzCKidFCAOCsa2rYGVC6NFW+PXvYwreScCeIqF
	a1Xj/mvLyEJK+ijDzFjvOeueuNMfGbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783255750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gG5YEQQ0ya2xrSmb4qkA9sgc8dQP/I7KKnN0q2GSBfw=;
	b=sy0RN/ZJevF/KactBkDlpKHq4Da7rUQpKY01GNP1BtRzbZ+9X/s+40GkmmYHnDNrk7zBfW
	VrhNrwytXyG2sD92VV7n8XS1fNZCiIp5aL4tosnl1m6Qk6jJdGCVcimgavkTFJi1DsolB6
	jZxpxbP2w/DUWV7HgKeT9fs6BXiNsXo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0LlKv1CY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6A34B201CF;
	Sun, 05 Jul 2026 12:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783255739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gG5YEQQ0ya2xrSmb4qkA9sgc8dQP/I7KKnN0q2GSBfw=;
	b=0LlKv1CYuObwup3P7Tqa4zS/qbTsYoSuyUxTkPX/fZ1BK4vFdjTqjJYvOhu8LNlsL3LRIh
	vXv/wL5U0FhdGQq+2XJCf6igXvAhV2H0YNVnHVFM5M0F3rcaa5Vz5/YWSjukSIWhB0JYs4
	AO36QQJo5Ou0vPPWgCBLJj+FLZiXGBQ=
From: Sven Eckelmann <sven@narfation.org>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, marek.lindner@mailbox.org,
 sw@simonwunderlich.de, antonio@mandelbit.com, linux-kernel@vger.kernel.org,
 amitesh.singh@chargepoint.com
Subject: Re: [PATCH] batman-adv: fix throughput detection for VLAN interfaces
Date: Sun, 05 Jul 2026 14:48:56 +0200
Message-ID: <12951327.O9o76ZdvQC@sven-desktop>
In-Reply-To: <178325531132.27339.5219063208417341297.b4-review@b4>
References: <20260705122134.62809-1-singh.amitesh@gmail.com>
 <178325531132.27339.5219063208417341297.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6033412.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: U3QFOEEYBZINTWWO7Q4C3HVS35SIF2JG
X-Message-ID-Hash: U3QFOEEYBZINTWWO7Q4C3HVS35SIF2JG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/U3QFOEEYBZINTWWO7Q4C3HVS35SIF2JG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6033412.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Amitesh Singh <singh.amitesh@gmail.com>
Date: Sun, 05 Jul 2026 14:48:56 +0200
Message-ID: <12951327.O9o76ZdvQC@sven-desktop>
In-Reply-To: <178325531132.27339.5219063208417341297.b4-review@b4>
MIME-Version: 1.0

On Sunday, 5 July 2026 14:41:51 CEST Sven Eckelmann wrote:
> 
> Duplex handling was not copied to this function

Regarding this remark: duplex handling is also on top of the upper device and 
is not neighbor specific - this doesn't really make the handling easier.... 
but I think we can ignore this remark for now.

Regards,
	Sven
--nextPart6033412.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCakpSuAAKCRBND3cr0xT1
y7UbAQDroIxbNBYZ4KRB+mD21BctsgHeBBh0MQERwHAQYu/rcwEAys3uazSq9TjK
547NQcSh0Wi55/WTCyq6nCSajXWjAQI=
=eKkM
-----END PGP SIGNATURE-----

--nextPart6033412.DvuYhMxLoT--



