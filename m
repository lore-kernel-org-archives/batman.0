Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B1CD11DD
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:37:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3FA4A81F75
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:37:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715825;
 b=c4Utu0Nc+5ualMCjNldr1PFa0Ht/ODWF2GxQ3WE+cXqwJxSV8UPrvIEsvqsgu9ZyWxwIV
 EC+hRRxbYICROzv3qcAzjum2PHMb208aHT0AuZBkYmS2Mtux7PXaktF66XHthdngBmXxu90
 anJT5WLvBSNniiDdZ/b4eD3LwR1d3VM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715825; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KbAPhMaglJyULYKsI/4WBcLq3W72k7uBJYpHJ3KaYt8=;
 b=T7fGDVbIE0+U3m7F0W5dCu86urTX1kYfRMGXReGHRhAywgpfRFh9S7pTP77ovoTpKkUWA
 dBp0nl5foR69qwa2v2/IYBF+fF4aE9m6gDjpSbQbk1+OSs7KjRPpiW1H9jLuQNPV3IZgnK2
 WFFkuLnYCIGjrjqJCuLYe3eWRubjhSw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7C3F181EC5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:34:49 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KbAPhMaglJyULYKsI/4WBcLq3W72k7uBJYpHJ3KaYt8=;
	b=rJL61T6t1DvIl85bJly3Fg8KXo/QWjj7phYCPxkmXq1VSMILkYFyhFw0tBYD9XXh1T4CqT
	LPGWeiZ7q+ixSGoVX/ARJqk9FjoScrTeVDSdaf2AuxJcmRc+HVwLmISKJ4c3PlE/DW0rMl
	i7GjzxYcIfGfxKfGRvz8YkGf9GxKEAI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715689; a=rsa-sha256;
	cv=none;
	b=k3Icsb5lETZFdtrocOkX/JGwxbnNb2iO8kvvR57OlwL5LguaadY4Kd7jF8mSLWfAmG2Nrx
	aTvsh+nFwZdud+IBeIN5Y05OJembouRbPJd7RIZjQOHTqCHMbuCE/shXGBruimxx1DghKb
	7EYIMFiX2GwDJYlri4wBoitK67Nbh2Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=fh2TUUOQ;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5E20B61927;
	Fri, 29 Mar 2024 12:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC54C43390;
	Fri, 29 Mar 2024 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715688;
	bh=twDLGvPJQ+B9GgLuoQNBwZ3oy3K0DvO0WQRtvidVAOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fh2TUUOQh/MOln2k3r8glWjaI5cp4k/Z6mAzVFE8xZZGuVlCPbC1MhmKUBk62LuGa
	 1lDx0wDScro2g4ySwlWeRm+OsWnh9sYMnVaA0gmIA3AE7e2rcvxJBS/5mi+9GRTriu
	 crPPIBkEEcY+VkOVR2rOFiardWW47WqmXeH8l60NqNRQQE6YDLMZxPdWnJ4s/DTeI/
	 7bCrVyY6rEN20fa8R4xopHFKkyV+XzQ5SUlOSkeuMi68OMPqGSDxMLSNG/fto+A4iT
	 T+D3ZFI1MLMC5O4BWoQiUT9MGJgFSVx/XnHTv6dYlutPZBov2W8pIS8CcjYNr0LzJW
	 usG/DITda+UJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/15] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:34:25 -0400
Message-ID: <20240329123445.3086536-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123445.3086536-1-sashal@kernel.org>
References: <20240329123445.3086536-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V74ZPBJB62QLMDNH4FRZEEKBDWBVWMOJ
X-Message-ID-Hash: V74ZPBJB62QLMDNH4FRZEEKBDWBVWMOJ
X-MailFrom: sashal@kernel.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V74ZPBJB62QLMDNH4FRZEEKBDWBVWMOJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit ffc15626c861f811f9778914be004fcf43810a91 ]

The kfree() function was called in one case by
the batadv_dat_forward_data() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a batadv_dat_select_candidates() call failed
  at the beginning.

* Delete the label “out” which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/distributed-arp-table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index dda62dcd59c8a..c5b7e9994a018 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -682,7 +682,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -726,7 +726,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0

