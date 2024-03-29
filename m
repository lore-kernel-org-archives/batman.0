Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E88CD11DD
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:30:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4352A81AD5
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:30:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715421;
 b=Tq86slQnrpylL3iwBq5rWjDpuZKlsyfeCnRMlc6qdJWo6+ZNqkzONWIkUQdGpOFKCu1eV
 aq8CZ4oytxT7ytjyof49/NBFeA9zjYyME6SFVS59EcFdaprxDXCwmHy/jlrmexwwIReoEP3
 FFMEs+TROkwgIAxX+kunglj6YXged3U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715421; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=s4yJ8gk0Tn/fau0AMNdev4V9KwGxS1PgFngIyyrDoUg=;
 b=CLcPS/Xbj77e3mLCBkbg++vPpzn92FHq6lg6fb7RGcDjN1pXUIYEd6GbWghTvWncUQ+c+
 wTBwkpW7w8s1kQAv2/uMGoaPZlywzxv5zqyDKr2SqKkCwyj95fWOYsYoz45G592g6u84heP
 6Vbvlg5T5tBKJx9CvTAApmzbC4ZdBzI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 740CB8015A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:30:04 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=s4yJ8gk0Tn/fau0AMNdev4V9KwGxS1PgFngIyyrDoUg=;
	b=0XqARTlC/7dfosqnRFf5cDUP3svzG4Sfgw4H7TRwzVPTZugEuVh6HiIY+KHoFdCANEIZ2C
	IFYAygXXKnjZ2RmxAjPrsrHDKXEkWY+LH+PCAVMJghrXZPbLpch/LsOyBqaRZlFCpKwXyk
	E/Ogwh7HLZGiqPIUTeutc+KSMwe0KdE=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715404; a=rsa-sha256;
	cv=none;
	b=wmDkLo4VnixAWhFUQEcHufChdHT6zT/RP+CuJ84IvotndpwgFJbIxoBcnvy/tQlR3Do54/
	klMH1VZ+YjDC7qkreIVkzGxc5VNkjRqOHmx+CQNedgShllk0HJwLgoFfSg0Lhk7REZaL7T
	k3LJ0aW58ZhaCsQXlHUhcbrCfpE5gAY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="YflT/8jx";
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 145.40.73.55 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D01C8CE03BC;
	Fri, 29 Mar 2024 12:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AE6C433F1;
	Fri, 29 Mar 2024 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715402;
	bh=SEsbnjgbOnrUNykRPC13YRzmbgzyK5QZUYeQcKRJKlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YflT/8jxM6MGfJOgoUZoJ1UwsYDf180IGE0/mSLLhSaB3PoXM+U33YxAidGT5FrqN
	 denjly5YprdUg0xTv5nsz1QkQqYcqHeS2E5kiKR9dfSQEdvxMSvdaqbqXrRbjlsFkh
	 NPbEUdFx4ukhMNE97kGHvS2TtweGAp3EDGimkpS18khAlmmLC1JIUyBOr5tP6JcFSK
	 Fdx3r8Zcw+TAITn6ZBmTIDn3qHT2QhArQ0Gcpkgj7C7F/WfBFXBDg5+ON/VFVPHfo4
	 XLYbLfqj7QRoy0FZ1EFDOQxdp2SngAG0V91126+E6L57YIA0Cu6dOWR1niApMo/3Rk
	 Rk7fzaeN+A+LQ==
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
Subject: [PATCH AUTOSEL 6.6 04/52] batman-adv: Return directly after a failed
 batadv_dat_select_candidates() in batadv_dat_forward_data()
Date: Fri, 29 Mar 2024 08:28:34 -0400
Message-ID: <20240329122956.3083859-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6WPFOAP3RD4LNSDJMY2O3D63KHMC46VC
X-Message-ID-Hash: 6WPFOAP3RD4LNSDJMY2O3D63KHMC46VC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6WPFOAP3RD4LNSDJMY2O3D63KHMC46VC/>
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
index 28a939d560906..4c7e855343245 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -684,7 +684,7 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 
 	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
-		goto out;
+		return ret;
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
 
@@ -728,7 +728,6 @@ static bool batadv_dat_forward_data(struct batadv_priv *bat_priv,
 		batadv_orig_node_put(cand[i].orig_node);
 	}
 
-out:
 	kfree(cand);
 	return ret;
 }
-- 
2.43.0

