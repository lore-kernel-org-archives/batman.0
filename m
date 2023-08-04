Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A372EB64DD
	for <batman-adv@archiver.kernel.org>; Sat,  5 Aug 2023 05:52:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9648A82FE4
	for <batman-adv@archiver.kernel.org>; Sat,  5 Aug 2023 07:52:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1691214752;
 b=MR5Q6JrofcUTf5/RsKYIcjKoKXBwEACD0QLzdVoEcrsFx4iJ6A86zEnzwSYGDZexXZXSV
 T+ehCWeNwAOd/Qcg5lYnIWroXJsllM0Q++eh7EAxnAd0l+uIGEz5eW6AeMtLQXW9/8oIzmN
 ylv3Xoa++trlcg2G+YHrKiWZZ+o7ZIQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1691214752; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Rb+D1tkfFnHzypbYnjvIv6sF4eaWuzV9M3TT3Iv64nc=;
 b=oMOqmobeoC3JPKwHBT1WQqUM6nHI9Ou4KMKjlHOga23Bcf+Ua0LxuTeJCnkyqfLZTGsxT
 gKHWnLujedgmld8CcsXa+iYo/ZkQk78+YefWr1mhQSoAc1xL6R9DJ+3Qz4fjAvYL4cDdhXN
 bVSlkxgMb32vAbYRu9NbmHm+UbyhIIs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6CC0A800FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  4 Aug 2023 11:38:39 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1691141919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rb+D1tkfFnHzypbYnjvIv6sF4eaWuzV9M3TT3Iv64nc=;
	b=yWOHAjx29S2bnHatVxIM9FhbNqgjZUS//qcF6MfWmUjS+t5d+phRaQRMkWANfRtgciOs4n
	9Qg7nUNuGw9loufttTMb01XDybz3A6BDM3XUNI6TDO/+9eUTYuYndLEnIG1q4a78BJfOyP
	uU3ZGStx2KTl6ikcC4gIkNeGqHvLoeQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 2001:4b98:dc4:8::221 as permitted sender) smtp.mailfrom=repk@triplefau.lt;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1691141919; a=rsa-sha256;
	cv=none;
	b=0iwnfIZbFcCGA2e11Vpe151fJdQw96Tarp5g4EVpQiM9ukMeq0l1HCpS9ns+ukdoXQcp6a
	P0x0ptLkI3tBGgv50EFA4J/P+4dSxJhx8ejwmImSyr0y4JAQ1xLhtReLmCKJjaFK1lOJDv
	tb+80ygnhWpgRpV/dT1AYpPg774yQyY=
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC33724000B;
	Fri,  4 Aug 2023 09:38:36 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH net] batman-adv: Fix TT global entry leak when client roamed
 back
Date: Fri,  4 Aug 2023 11:39:36 +0200
Message-Id: <20230804093936.22257-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: 4UVCBDJEA2XSIPKTXNGG6NE2B7ZUIB3G
X-Message-ID-Hash: 4UVCBDJEA2XSIPKTXNGG6NE2B7ZUIB3G
X-Mailman-Approved-At: Sat, 05 Aug 2023 07:51:55 +0200
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4UVCBDJEA2XSIPKTXNGG6NE2B7ZUIB3G/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a client roamed back to a node before it got time to destroy the
pending local entry (i.e. within the same originator interval) the old
global one is directly removed from hash table and left as such.

But because this entry had an extra reference taken at lookup (i.e using
batadv_tt_global_hash_find) there is no way its memory will be reclaimed
at any time causing the following memory leak:

  unreferenced object 0xffff0000073c8000 (size 18560):
    comm "softirq", pid 0, jiffies 4294907738 (age 228.644s)
    hex dump (first 32 bytes):
      06 31 ac 12 c7 7a 05 00 01 00 00 00 00 00 00 00  .1...z..........
      2c ad be 08 00 80 ff ff 6c b6 be 08 00 80 ff ff  ,.......l.......
    backtrace:
      [<00000000ee6e0ffa>] kmem_cache_alloc+0x1b4/0x300
      [<000000000ff2fdbc>] batadv_tt_global_add+0x700/0xe20
      [<00000000443897c7>] _batadv_tt_update_changes+0x21c/0x790
      [<000000005dd90463>] batadv_tt_update_changes+0x3c/0x110
      [<00000000a2d7fc57>] batadv_tt_tvlv_unicast_handler_v1+0xafc/0xe10
      [<0000000011793f2a>] batadv_tvlv_containers_process+0x168/0x2b0
      [<00000000b7cbe2ef>] batadv_recv_unicast_tvlv+0xec/0x1f4
      [<0000000042aef1d8>] batadv_batman_skb_recv+0x25c/0x3a0
      [<00000000bbd8b0a2>] __netif_receive_skb_core.isra.0+0x7a8/0xe90
      [<000000004033d428>] __netif_receive_skb_one_core+0x64/0x74
      [<000000000f39a009>] __netif_receive_skb+0x48/0xe0
      [<00000000f2cd8888>] process_backlog+0x174/0x344
      [<00000000507d6564>] __napi_poll+0x58/0x1f4
      [<00000000b64ef9eb>] net_rx_action+0x504/0x590
      [<00000000056fa5e4>] _stext+0x1b8/0x418
      [<00000000878879d6>] run_ksoftirqd+0x74/0xa4
  unreferenced object 0xffff00000bae1a80 (size 56):
    comm "softirq", pid 0, jiffies 4294910888 (age 216.092s)
    hex dump (first 32 bytes):
      00 78 b1 0b 00 00 ff ff 0d 50 00 00 00 00 00 00  .x.......P......
      00 00 00 00 00 00 00 00 50 c8 3c 07 00 00 ff ff  ........P.<.....
    backtrace:
      [<00000000ee6e0ffa>] kmem_cache_alloc+0x1b4/0x300
      [<00000000d9aaa49e>] batadv_tt_global_add+0x53c/0xe20
      [<00000000443897c7>] _batadv_tt_update_changes+0x21c/0x790
      [<000000005dd90463>] batadv_tt_update_changes+0x3c/0x110
      [<00000000a2d7fc57>] batadv_tt_tvlv_unicast_handler_v1+0xafc/0xe10
      [<0000000011793f2a>] batadv_tvlv_containers_process+0x168/0x2b0
      [<00000000b7cbe2ef>] batadv_recv_unicast_tvlv+0xec/0x1f4
      [<0000000042aef1d8>] batadv_batman_skb_recv+0x25c/0x3a0
      [<00000000bbd8b0a2>] __netif_receive_skb_core.isra.0+0x7a8/0xe90
      [<000000004033d428>] __netif_receive_skb_one_core+0x64/0x74
      [<000000000f39a009>] __netif_receive_skb+0x48/0xe0
      [<00000000f2cd8888>] process_backlog+0x174/0x344
      [<00000000507d6564>] __napi_poll+0x58/0x1f4
      [<00000000b64ef9eb>] net_rx_action+0x504/0x590
      [<00000000056fa5e4>] _stext+0x1b8/0x418
      [<00000000878879d6>] run_ksoftirqd+0x74/0xa4

Releasing the extra reference from batadv_tt_global_hash_find even at
roam back when batadv_tt_global_free is called fixes this memory leak.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 36ca31252a73..b95c36765d04 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -774,7 +774,6 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 		if (roamed_back) {
 			batadv_tt_global_free(bat_priv, tt_global,
 					      "Roaming canceled");
-			tt_global = NULL;
 		} else {
 			/* The global entry has to be marked as ROAMING and
 			 * has to be kept for consistency purpose
-- 
2.40.0

