Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A4CD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:27:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96D588495C
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:27:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460861;
 b=R9LmvQ1U4mxi5UkMLOMbA0maGLispGAZwu/JPrTVLOdbAZ7hdMzYRoXBuAusp3BSSwdzX
 2bePSjsEE0fa8LCD6EC1qGRifb7ldSP5KSoBS7fBtAKi2OY80e+256+Hucvw55z6JUjJE9Q
 /0dyYCqJfnFXDf3ZLHSUOgNjNcLevWM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460861; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=i+GpR9suaB3xuRk5A7baU+Z+Spf9X1Y/0BjWrXFmY48=;
 b=OHGTibxnMwhxYOvlcA9CFBvG0QMZlvhqDFo5zrqxVU5JLsVkEZk/EDf7dne1BYVXJzWMX
 QyIWYZ99Fs4kNzv14QUX11fWWaqc2Rb4tEVTqY5D3YJqctmXrwLBN1RAKXfXLnstrR2T+1n
 +AwObZI3Hi+Jg3M3Oi6ZlQzD8FNEkgk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1265A8430F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:21:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460503;
	b=uXJlHHCTv0n9K9Tk555Qqahp49QLZVIR8cnjZtNTFuKWF8om2zrUT5ugE5n/3av0fGI4YG
	dJ5SF9t7mtgtEYdeiySBUS7ZgxvLw1eyUxAx1woobQ5vIpfbqI/jyPTmQk0KklLmdCXrFL
	HMMQs/VaTIUoeAI2K/WEAfZ5RYqddKE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QeWxqH86;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=i+GpR9suaB3xuRk5A7baU+Z+Spf9X1Y/0BjWrXFmY48=;
	b=bkx1q1JA5kTawvJ+VfP6X1ZpOnZ/Khd44pQmQmdh9h5GYGYoHDAQwuj6ACMkMi+oDoeYev
	Rtge2vnvjrakKEezwctgaAjlpuz+ClAYgSclDonRY25yiuJt4b9RljOhpvq6JLana6jLXx
	nyZ94nPoPAAd5vXj53Sd/D005Kdeo+Q=
Received: by dvalin.narfation.org (Postfix) id 1C7A61FEA4;
	Wed, 03 Jun 2026 04:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i+GpR9suaB3xuRk5A7baU+Z+Spf9X1Y/0BjWrXFmY48=;
	b=QeWxqH86h5wWLvoMLxsnVbblFmt0iNnVf8GaxyO5jXdCj4SX32JYr42M6RtbfYWMRLwNYj
	wyvIWaUqrVYwmwjxe4I3I0E/9HffXT6Z7kEiPOuiYvfmWDO+cG0QY0PtExibUmtCcjl7i1
	xoSmF/ZBHycaBWwmRfLHewAj9CXaITc=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/3] batman-adv: wifi flags cache cleanup
Date: Wed, 03 Jun 2026 06:21:37 +0200
Message-Id: <20260603-wifi-cache-cleanup-v1-0-d5ed08075c96@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKrH2oC/yWMywqDQAxFf0WybmAcNND+inQRY6wpZSozvkD8d
 8d2ee7lnB2SRtMEj2KHqIsl+4YM5a0AGTi8FK3LDN55cuQ8rtYbCsugKB/lMI9INen1yb0iyOI
 YtbftF22g5Ym7BZ7/Pc3tW2W6inAcJ0Q6rLF+AAAA
X-Change-ID: 20260602-wifi-cache-cleanup-656e0602c946
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=767; i=sven@narfation.org;
 h=from:subject:message-id; bh=/dmWkJHjXsKmVetgv19Y4KY4shEAnRq99lHDym3X3jQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyqy9PTOJdnzQ/JdHt2dJDjUKXpnoc0so6zNRn+PXwm
 +KUZeZLO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATearN8E+9MtGQh/Pep0CW
 CWdKZXrZ/je//XOwQahR8HVoVrFE6zaGv3Lmd88xrpT3zUj7yHitd095R19YuZbD/vi5xzTSwrI
 2sQEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WMRG43CGZLKBGTTSEAFXLCPQGZGHC7JP
X-Message-ID-Hash: WMRG43CGZLKBGTTSEAFXLCPQGZGHC7JP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WMRG43CGZLKBGTTSEAFXLCPQGZGHC7JP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Unfortunately, the new wifi flags cache had some problems in the kernel
doc and non-optimal code in batadv_wifi_net_device_insert(). Let us just
fix this while the code is fresh :)

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batman-adv: correct batadv_wifi_* kernel-doc
      batman-adv: drop duplicated wifi_flags assigned
      batman-adv: use GFP_KERNEL allocations for the wifi detection cache

 net/batman-adv/hard-interface.c | 11 +++++------
 net/batman-adv/hard-interface.h |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)
---
base-commit: bba80ddd693e6d82a0b1f456511904cfefd5df24
change-id: 20260602-wifi-cache-cleanup-656e0602c946

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

