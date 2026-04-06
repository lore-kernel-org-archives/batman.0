Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D9CE9D836
	for <batman@archiver.kernel.org>; Mon,  6 Apr 2026 13:24:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A532F8591D
	for <batman@archiver.kernel.org>; Mon, 06 Apr 2026 15:24:43 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1775481883;
 b=1Jv+09Rv6Iug715LyTZMetvBat7Ej2/FGTfqv7DQrLAkR63F0njmJh/dOuL3dL9W/efKi
 xrQs1fNqqtuf6yf4OEU3ExgQV/IKJNHe+GJKK44C76C/QkHWgmfVUfKp3+FAx8itxLMc1Ou
 e0UmaZWaWAwchUZp+a4kl22PKjPw/64=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1775481883; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vk7mk1dkl8bYbRjz9KNsQMaH1GfrjF+qnBi5SZGzf/g=;
 b=sdoghCkJ6wr31QtF9aCDfEraNX6jz9XIMkgFHLeklLF9wDI3mCnHiWyFhz0u20tAZUYu8
 C5f4d5cSAUBdXw/zqFvfDVqMvwu31jKAglVJiPqqHZH5do43Aua1hQLPo7J3UF+mzqfHMhB
 QS2/cyX89fCRksKNNHt+JZ4iBlTefcU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net
 (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 42D7E83EF2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 06 Apr 2026 15:17:34 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1775481466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk7mk1dkl8bYbRjz9KNsQMaH1GfrjF+qnBi5SZGzf/g=;
	b=0N/wdmmjy61f2gQ2Tbhz3vXH8hWUgkTa6g7FL9id2xE8Ip2fJqruNmZC8K/ynz6SYgJnqK
	Bs7N96PjQvpJXehGCg+OzIRqKbbEufeIRyfMWrVFkMRkxCDrr1V9Ii1+rkSmSigGSjI66n
	zAtYj+/DB8mUO2gsOYG3hRtSs9Bc9oE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of n05ec@lzu.edu.cn designates
 206.189.21.223 as permitted sender) smtp.mailfrom=n05ec@lzu.edu.cn
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1775481466;
	b=Zwn8hF7mX/rQpWknxel9Q213SXhQUAovGKV+FL8aa9xVlnGr2RefW4uNPM1ni1KViSySsK
	06klGYXaJlKovvuPywokodo2UGTIIgcIEpOfizk6o1zKOV6rHFASeUN6l8QIKANoSZhI87
	pymTfas4L79Q2/CUGlwlKj4+zR4hUeY=
Received: from Draw.localdomain (unknown [27.227.216.52])
	by app1 (Coremail) with SMTP id ygmowAD3avtnstNpvLWrAA--.3227S2;
	Mon, 06 Apr 2026 21:17:28 +0800 (CST)
From: Ao Zhou <n05ec@lzu.edu.cn>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Cc: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Haoze Xie <royenheart@gmail.com>
Subject: [PATCH net 1/1] batman-adv: hold claim backbone gateways by reference
Date: Mon,  6 Apr 2026 21:17:28 +0800
Message-ID: 
 <4a58d2daef70ac17bb9be1f244a182439d5c4d63.1775301426.git.royenheart@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775301426.git.royenheart@gmail.com>
References: <cover.1775301426.git.royenheart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: ygmowAD3avtnstNpvLWrAA--.3227S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxGFykCF18Gw48ArWkWFg_yoWrWr1fpF
	1UKw15Krs7X397Xa4Iyry2gF4UXrs3GrW7WFyUGF4Iyw1qyr18G345KF1IvF4YyFWqkrnx
	Zr1YkF17urs8CrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB21xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
	IEY20_GrWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQUJCWnShX0H5wAAsn
X-MailFrom: n05ec@lzu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: UMC23VC7SAOCI2SB664WJK755FUNU7V4
X-Message-ID-Hash: UMC23VC7SAOCI2SB664WJK755FUNU7V4
X-Mailman-Approved-At: Mon, 06 Apr 2026 15:24:30 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UMC23VC7SAOCI2SB664WJK755FUNU7V4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Haoze Xie <royenheart@gmail.com>

batadv_bla_add_claim() can replace claim->backbone_gw and drop the old
gateway's last reference while readers still follow the pointer.

The netlink claim dump path dereferences claim->backbone_gw->orig and
takes claim->backbone_gw->crc_lock without pinning the underlying
backbone gateway. batadv_bla_check_claim() still has the same naked
pointer access pattern.

Reuse batadv_bla_claim_get_backbone_gw() in both readers so they operate
on a stable gateway reference until the read-side work is complete.
This keeps the dump and claim-check paths aligned with the lifetime
rules introduced for the other BLA claim readers.

Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Fixes: 04f3f5bf1883 ("batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
---
 net/batman-adv/bridge_loop_avoidance.c | 27 +++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 49ae92b9a152..247d8502c90b 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2129,6 +2129,7 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct batadv_hard_iface *primary_if,
 			    struct batadv_bla_claim *claim)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
 	u16 backbone_crc;
 	bool is_own;
@@ -2145,32 +2146,35 @@ batadv_bla_claim_dump_entry(struct sk_buff *msg, u32 portid,
 
 	genl_dump_check_consistent(cb, hdr);
 
-	is_own = batadv_compare_eth(claim->backbone_gw->orig,
-				    primary_addr);
+	backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
+
+	is_own = batadv_compare_eth(backbone_gw->orig, primary_addr);
 
-	spin_lock_bh(&claim->backbone_gw->crc_lock);
-	backbone_crc = claim->backbone_gw->crc;
-	spin_unlock_bh(&claim->backbone_gw->crc_lock);
+	spin_lock_bh(&backbone_gw->crc_lock);
+	backbone_crc = backbone_gw->crc;
+	spin_unlock_bh(&backbone_gw->crc_lock);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {
 			genlmsg_cancel(msg, hdr);
-			goto out;
+			goto put_backbone_gw;
 		}
 
 	if (nla_put(msg, BATADV_ATTR_BLA_ADDRESS, ETH_ALEN, claim->addr) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_VID, claim->vid) ||
 	    nla_put(msg, BATADV_ATTR_BLA_BACKBONE, ETH_ALEN,
-		    claim->backbone_gw->orig) ||
+		    backbone_gw->orig) ||
 	    nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
 			backbone_crc)) {
 		genlmsg_cancel(msg, hdr);
-		goto out;
+		goto put_backbone_gw;
 	}
 
 	genlmsg_end(msg, hdr);
 	ret = 0;
 
+put_backbone_gw:
+	batadv_backbone_gw_put(backbone_gw);
 out:
 	return ret;
 }
@@ -2448,6 +2452,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 			    u8 *addr, unsigned short vid)
 {
+	struct batadv_bla_backbone_gw *backbone_gw;
 	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim = NULL;
 	struct batadv_hard_iface *primary_if = NULL;
@@ -2470,9 +2475,13 @@ bool batadv_bla_check_claim(struct batadv_priv *bat_priv,
 	 * return false.
 	 */
 	if (claim) {
-		if (!batadv_compare_eth(claim->backbone_gw->orig,
+		backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
+
+		if (!batadv_compare_eth(backbone_gw->orig,
 					primary_if->net_dev->dev_addr))
 			ret = false;
+
+		batadv_backbone_gw_put(backbone_gw);
 		batadv_claim_put(claim);
 	}
 
-- 
2.53.0

