Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8A1C54FD2
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 08:58:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1FFE780893
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 10:58:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785401921;
 b=L7lAURsFFozDJk+lBdB3D8X3ujaDPPHLvJBpXCsEFbiwazxQNBhoL89cNF2t7Ng4rzNCR
 HRLo6GOdhH6e/kL5FZRy8CTPUh9LTSEMJt0YPzspvK73ELx1aYK8Z62/pTl+lNyi+p8hKh0
 9EPONWM+VfCy4bsr+jL8RSM7amCa1Dk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785401921; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Jgntor+43v6tbWleg7SUIiiL7fHfehWWv5v+9lLOlgU=;
 b=O6PzWIE7Xf5A4ZrfJ4Kp06fK8mV+YV1khzoxB/jZhyw1xU1Fe9D5l4etOo0WV3QEW9C1k
 fHyjpgFP5AfVUYL01JwT6UdX2cY1TsvBwf2dsC0zsNZ8JGU9JN/T6aSDSKZeR+xwxU8dZK4
 SeDvXL47UKAaE7XecHTF1pDbRcQaFQ0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 79B9680F88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 10:58:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785401901;
	b=TaWn/MnAIo3std45QR0ohpej0kotwXa31F+9ylNttdhsXI/KjqMiiy78IqKCkxEM44SW5q
	kpxcI1P0m1Nne6iPGQcOpEeMAG3RN3hn6hXykZXT7rjJ/8FMdOjc+mY8qjqF2goUyW0MNK
	8gAZr9t7AMvmoCJC7MrIlMXhHOKqnD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785401901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Jgntor+43v6tbWleg7SUIiiL7fHfehWWv5v+9lLOlgU=;
	b=vHLFE6Gycub4dLAatvOXavOSlnhN5ukt+bOATjM5wmA9iKweTlqplKV5pUUnzfkReRx7jY
	Psylcs8TN264Rs+D3jMDcAMOhj1O5BLxf+/BlkLMbyyjpyUaAOtwoE14ItOXLACYUA8/qj
	V9uLV1r+FrGncyUu/IBYiDTO1WfLjT8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ldY6W0tz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B8E0D2019A;
	Thu, 30 Jul 2026 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785401886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jgntor+43v6tbWleg7SUIiiL7fHfehWWv5v+9lLOlgU=;
	b=ldY6W0tzXxr3x1uZ2kYl8qkG5EbAsHTsA6jEybsJRW30MNxY1qrlNFojyCPuU/ggV20RVw
	nXEe0Hd/HWWpjuluHHfe0BBGfxx2SfCOefFXFdNOpLzAfEOciuSEmS00TYIhwJ2WlW8wUg
	uRMPB0UGxwmv0vhEXFSMsRoUEzEHC/8=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 10:57:53 +0200
Subject: [PATCH batadv] batman-adv: tvlv: handle negative tvlv processing
 return codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tvlv-negative-return-v1-1-b7cdc661c2dc@narfation.org>
X-B4-Tracking: v=1; b=H4sIABASa2oC/yWMywrCMBAAf6Xs2YX0QYr+injYJtu6IlE26SKU/
 rupHmdgZoPMKpzh0mygbJLllSq0pwbCndLCKLEydK7zbuwdFnsaJl6oiDEql1UTkvf94ON5nEM
 LNX0rz/L5ba8wUaFocPv7vE4PDuV4wr5/ATQhdvSAAAAA
X-Change-ID: 20260730-tvlv-negative-return-a66346d97fc1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=sven@narfation.org;
 h=from:subject:message-id; bh=6yzyZCbwpH4VyY3I44Xqll0gg3jo7Bh0jBeDVCrAtWg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZQoJcExNTyxPju7jypnJad7ROXC5hLX2PY+K9ptrnI
 ksFbvl0lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbCfJGR4cKjBk3BN6dMrJ88
 T5z9fbtv7aTWzg+JR6XCjoqoiq47JsfI8L7lwNzbvw8HxYsfFpmyQHe7eOvxB6uiXMouODyVlFj
 qwwwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EPZ2ILEL3ZHDXTNF4AQTDR6G2NBS2VH6
X-Message-ID-Hash: EPZ2ILEL3ZHDXTNF4AQTDR6G2NBS2VH6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EPZ2ILEL3ZHDXTNF4AQTDR6G2NBS2VH6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tvlv_containers_process() was implemented with only two return codes
from the handlers in mind:

* NET_RX_SUCCESS (0)
* NET_RX_DROP (1)

The multicast handlers broke this convention and are also returning
negative return codes. But the processing code was never updated to
correctly aggregate them.

To handle negative return codes for non-OGM(2) handlers, they are now
aggregated to:

* NET_RX_SUCCESS when no handlers returned a different return code
* the last negative return code when at least one handler returned a
  negative return code
* NET_RX_DROP otherwise

Fixes: 8ed36122d709 ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c |  3 ++-
 net/batman-adv/tvlv.c    | 22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 15ef47d3..3996ffd1 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1385,7 +1385,8 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
  * contents of its TVLV forwards it and/or decapsulates it to hand it to the
  * mesh interface.
  *
- * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
+ * Return: NET_RX_SUCCESS on success, NET_RX_DROP in case of failure or a
+ * negative errno code when the multicast tracker TVLV could not be processed
  */
 int batadv_recv_mcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 5600aaf0..de907c07 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -386,8 +386,9 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Return: success if the handler was not found or the return value of the
- * handler callback.
+ * Return: NET_RX_SUCCESS if the handler was not found or the return value of
+ * the handler callback. The latter is NET_RX_SUCCESS or NET_RX_DROP for the
+ * unicast handler and additionally a negative errno code for the mcast handler.
  */
 static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 				    struct batadv_tvlv_handler *tvlv_handler,
@@ -528,8 +529,9 @@ static bool batadv_tvlv_containers_contain(void *tvlv_value,
  * @tvlv_value: tvlv content
  * @tvlv_value_len: tvlv content length
  *
- * Return: success when processing an OGM or the return value of all called
- * handler callbacks.
+ * Return: NET_RX_SUCCESS when processing an OGM or the combined return value of
+ * all called handler callbacks. The latter is NET_RX_SUCCESS, NET_RX_DROP or,
+ * for BATADV_MCAST packets, a negative errno code.
  */
 int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 				   u8 packet_type,
@@ -544,6 +546,7 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	int ret = NET_RX_SUCCESS;
 	u16 tvlv_value_cont_len;
+	int res;
 
 	while ((tvlv_hdr = batadv_tvlv_hdr_next(&tvlv_value, &tvlv_value_len))) {
 		tvlv_value_cont_len = ntohs(tvlv_hdr->len);
@@ -552,10 +555,13 @@ int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
 						       tvlv_hdr->type,
 						       tvlv_hdr->version);
 
-		ret |= batadv_tvlv_call_handler(bat_priv, tvlv_handler,
-						packet_type, orig_node, skb,
-						tvlv_hdr + 1,
-						tvlv_value_cont_len);
+		res = batadv_tvlv_call_handler(bat_priv, tvlv_handler,
+					       packet_type, orig_node, skb,
+					       tvlv_hdr + 1,
+					       tvlv_value_cont_len);
+		if (ret == NET_RX_SUCCESS || res < 0)
+			ret = res;
+
 		batadv_tvlv_handler_put(tvlv_handler);
 	}
 

---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260730-tvlv-negative-return-a66346d97fc1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

