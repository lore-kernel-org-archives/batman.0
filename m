Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1121D6DDDB
	for <batman@archiver.kernel.org>; Fri, 15 Nov 2024 07:19:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 20A4A836DE
	for <batman@archiver.kernel.org>; Fri, 15 Nov 2024 08:19:12 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731655152;
 b=IBY2+7Drt0bDk2u7RVPSqjr3CxB2YIRI+CUmxeEcAil+UF8vmurnSMoGm7qaO7dkZZG1i
 b8yV2pzF+CrEU/Zw/XcPJNv5TdwY9XDHCHvb/aeRPnXnWIl+7wfxOignIsi+H5d7pXAr3EO
 HIz1Hk/XHzFt3IkM5Zf/PtU0Fq2MW74=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731655152; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZiF3FgqNJA4tZDa0J2g8epdxrSCCmBW2k+8rzqXZnfk=;
 b=cXKl7A4UHsLz0PNlZdaY36ZdhqFIT13ddianvifUJxemvGKjo61AGfPG9FwdKn8A7wLyU
 ZaqAcd3yN/9gEilhPoh6Y3CV3m6KXvA5xavJQCLag0lBYxACSmAlkq6mOhvG6QGPthKeh4l
 DPY50meq4t0Wox5993N/hJ9fvvHEwA8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 64691817B5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 Nov 2024 06:03:33 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731647013; a=rsa-sha256;
	cv=none;
	b=CvJf0+ASsSxBzRNJyLrNGAFRDcTmbPwtEcxitD+5gre339CaSgc+giNrfGplOkGgnpVmyt
	mjdGpTyc6dDSKgY1sN2yHYES/nfb2GYCH2mSsFhedWmohJtTYEVVGfPx33ScsNlHuWdmEt
	S1K+xJj58KNUaoVrsvy8DXRhMUwhdv0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=cXftwG7p;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of dheeraj.linuxdev@gmail.com
 designates 2607:f8b0:4864:20::62d as permitted sender)
 smtp.mailfrom=dheeraj.linuxdev@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731647013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ZiF3FgqNJA4tZDa0J2g8epdxrSCCmBW2k+8rzqXZnfk=;
	b=hT1G0xNLAfF/dZB6nAL9TruLpMmojldrRn7b0396fns4bZZDGe2011nZf57+vxiKPD3u3b
	yIZSRr5dFTfw7zUh7ihFEaVIRtGDobT7ZmH0dTBqA/FLgBuI1uBNKIXRf60yEmSrUIOmrT
	SXrLT2IBmYzvJwBw+LzY/be6MVNkjqA=
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2114214c63eso12746015ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 14 Nov 2024 21:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731647012; x=1732251812;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiF3FgqNJA4tZDa0J2g8epdxrSCCmBW2k+8rzqXZnfk=;
        b=cXftwG7pmvEcVTTV/4cMjuJoUJW3qj9YYg4XtY242aOiurA1pL7hp0PvmchW2XKx7/
         8eMtAtAXRsKzEdyWZxVzAy5qFxbQTy5u4z85yq3BHwK1nSC5Xu+j5TrSJkWtOBfAyA5M
         ppMyntbs6eJGaYQvfQTyN0UpR0M32oNHgJjZn9b0iil2IKdfS0uL2TeogcrgVWk++60Z
         DKT/CdqHz+/XNehlJlq6AOdesjEis00BGZvqlrnMD7qg5K23MEttmixacJUEb1ueUzGl
         rYo8oHZ683BPI5lC/sWwfqOLnu/8tGDE9U4iUI991H3PWaN1p1z0rpm4pbBtK5C6yc3l
         RtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731647012; x=1732251812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiF3FgqNJA4tZDa0J2g8epdxrSCCmBW2k+8rzqXZnfk=;
        b=jgAmct3DJzAyINucT5zSHCr7dK3WzxE/EI5QElrKS9gyhEInAtf4nRlSsn12vw/sDN
         Eps7+ZThRIgsoiaJW0UnHDv5IT/bGtr42eqDjrw9GknG319fI3xnBzUwjHbOuYpFftrW
         F2vRP5TWIYrkGVBjoS7bE8gBz5xwIQRrHcAS1TwESgay6SpVGoB5fz8IqN4aD+WYQ73v
         KVvx1Y+WgHxMfxlfPvmzQlSasAVJoisVeG4XcBnT2COQVC35bObUyrsFE2wqbawvh7wk
         A3RrcvFP3A5OR0Gy6ea1x2eETCQkYJ9vo2mBKPrqK3V0d+em+xR2sJ5JJcs3NMdelKZ+
         XqYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXOtiZ9h8Sv6S+4Q6o4G4/8pe4Gy+thyjWgnbR4xmOnfvIifSnnxFoWlhbmBukiQWuOqBwOXnZBCSW7w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yxg3iE1ZiBOsM4eiacELxaSUSg6OSLilkNgCxWUMlFkuKGzm5wO
	/BHnF0l1udoN7Z9ggw/0aKAFDkkqM/2PHtcrvkG/L/MwMjM6DK2awJh2mHDj
X-Google-Smtp-Source: 
 AGHT+IF5BHuijPtl48H//iBsTd5HSy6KmsItjpyh0p28m6AERbvt7GJ/T2MK2aMn16UtOQM0C/bEew==
X-Received: by 2002:a17:903:285:b0:20c:c1bc:2253 with SMTP id
 d9443c01a7336-211d0d861c9mr22855985ad.32.1731646691860;
        Thu, 14 Nov 2024 20:58:11 -0800 (PST)
Received: from HOME-PC ([223.185.134.27])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f47cbfsm4542935ad.217.2024.11.14.20.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 20:58:11 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: mareklindner@neomailbox.ch,
	sw@simonwunderlich.de,
	a@unstable.cc,
	sven@narfation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH-net] batman-adv: Fix "Arguments in wrong order" issue
Date: Fri, 15 Nov 2024 10:26:37 +0530
Message-Id: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: dheeraj.linuxdev@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: VHEN4EBVKCHZ7IBPTDMQLR657TLRZUBI
X-Message-ID-Hash: VHEN4EBVKCHZ7IBPTDMQLR657TLRZUBI
X-Mailman-Approved-At: Fri, 15 Nov 2024 08:19:06 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHEN4EBVKCHZ7IBPTDMQLR657TLRZUBI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This commit fixes an "Arguments in wrong order" issue detected by
Coverity (CID 1376875).

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 801eff8a40e5..781a5118d441 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1195,7 +1195,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 			goto out;
 		}
 
-		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
+		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_src, ip_dst,
 						      dat_entry->mac_addr,
 						      hw_src, vid);
 		if (!skb_new)
-- 
2.34.1

