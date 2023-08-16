Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B2C001B0
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 16:36:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 261A6833B6
	for <batman-adv@archiver.kernel.org>; Wed, 16 Aug 2023 18:36:00 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692203760;
 b=Ssi6beJLLqR9XH8LWajTBsIpmdnLtMjsiZ2jLNnCzIngNQZE2CtJDGaN5yLOWGzsGqbX9
 ZUmBZSFpryJYMvZjBZK1WALSAMrsK6I+8bEiJCYYffZDjbpqOr3k5oqDBQfTj0YDEzfe4Ud
 uku5UPeGz5NPk9Cg54VOXCtkOn1xGn0=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692203760; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l95692txLl6SeteMeQcbeptJUFPFVrXOC5fLUGwNKzk=;
 b=lMQ5m/wGS1pf+tUyDf3LtOx7qeL+xAWHQmqFDSAXEgCsaWcQmIsD1AmoZIwTHmOCwrU2X
 6Yx/CdZgV07XnDZoz+0SZ9L2WHv1T1Pbce/t9yOLRuNlUeofbwJso3YMIolKwCi42TFJxSM
 w+sOSqMGHpW1uHp4fvF/kXYD7LUEjcM=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9CF4681FD5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 16 Aug 2023 18:33:22 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692203602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=l95692txLl6SeteMeQcbeptJUFPFVrXOC5fLUGwNKzk=;
	b=rHGcqC2ZGfnHxtw9pA+4GFHA+5x7U8+hxXWw9PKX+Vi8gV/0WG8oh67QzsFC5WmF5kZBDK
	hVZ6ZtZh/k3gPPWz1J3pSZS/+bsiTCH5a73TRun20qFlugGuPk02N4HB+fyxbt3Z+/lJIm
	NPeTn64zvxu83o94Y6yDiVo6zzAkTpw=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Jvae0P0o;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("simonwunderlich.de:s=09092022:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1692203602; a=rsa-sha256;
	cv=pass;
	b=18VXJeg0hacP2FCc7jFyZAr+l0N8m99wlRIWBgZ84iq44JNtyVLhhUrhNFrFZU/ooX5e7B
	MJxh/rVan+0sjllFeC4qSXsZg+piWJXS/DPeAlqpYt43hBWqQh/i2eXCYEa30qos1HVeBo
	3czXfFb6z5DBmZJWSG8ksz9jYYu7ETU=
Received: from kero.packetmixer.de
 (p200300fa272a67000Bb2D6Dcaf57D46e.dip0.t-ipconnect.de
 [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 50D5DFB5B7;
	Wed, 16 Aug 2023 18:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1692203602;
 h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l95692txLl6SeteMeQcbeptJUFPFVrXOC5fLUGwNKzk=;
	b=Jvae0P0orb16uWcJFOoA9+P9RUxDlfitqiPk2TcINd9NPV2CrB9ftxcGgOHj+tcex75yXc
	yCxcIM4LMTe3+u0jkdqusYJgNxrHMztM7KX7wB7DoHczcE9yBmcgh4ByzJNDVxT7QoA/Ph
	uqHw734A6E5jNS/DVwnxu/kgIjDg1QjCWvH2kSKyl+wgWZ2Omilo21gJ/YFnnpy/KN7Dm2
	cF2Yx7inEC/DfFxTFafbQiNhk36RlBy8NbyCL6/4nDrNHhnN1iFPbsjrc2MPPbj21v0vTL
	Kpw937+eKJ5TZJGKIjOpvtbPO7hEyaWfHf6SsJbTn8almHhzRCpGWQxmzfBCZQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Subject: [PATCH 3/5] batman-adv: Do not get eth header before
 batadv_check_management_packet
Date: Wed, 16 Aug 2023 18:33:16 +0200
Message-Id: <20230816163318.189996-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1692203602;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l95692txLl6SeteMeQcbeptJUFPFVrXOC5fLUGwNKzk=;
	b=cfsTeJtrRnT4VkVE1Yq8P3d6x2sTzDv3TA9IPJFmo4qdPkEx7TJ5jxTWjMClcA1m8P8I7c
	HpgceqG63lmBdPIlPlwfQL6sI3XTImd+jgZl9kiXU50B+/TSNhEkjEdaa8Um3OVp1Y9Dcq
	OL6Ro+/ZLs5g6vn7XSgLC72MStEvf8yPXEwJYynojE/wZIrzY3Bo6oaP4Wj+He8QJ052/l
	VBh5B1ks6ZSBE4xeOkQUTDBu4b8AxeIMLboxm5VJokKDLjEKFH/QMZ4NqkdWGjIgenCaEm
	mszNQTTgxL8lI1NaPdrDvLFfagcjha767pvpLUxlSPKW/5cGC7tTZRvCDdMZMA==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203602; a=rsa-sha256;
	cv=none;
	b=tD1tQ2+vtwCPXB5qI+TCOFPbNLUOScA+c+qoxhPtmlZLySTGiizBQbs1gQfRKgA9WPsDbSsnTQD7HiR1j0O5W+vrl3s+f2+pFYYBw2Cl2BD1pUftVuaeHWey7ZzpFPaXCPsuYA6hFwLDUmiMgEtDvoEj2MT3f+Z43Nx9PDsGyEJBYJOJQLlRpqnRYaRxBnNj5G70QJdvxzzBs8VPFGw19X0pTNkOEyImNx2XlHRV9Rdzc9uqgyY+uByFIYdvN70jC6iSYZiHU5JHkPlvtw4BK8N5YihbaWENlAagT+dpwOpCoTu8tPh6dc9Cjn66sfOViWSK9n9f0MP/WgH6cFid0w==
ARC-Authentication-Results: i=1;
	mail.simonwunderlich.de;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: HPSORX4OF527N7LU4OXAT34YEIFXFJU4
X-Message-ID-Hash: HPSORX4OF527N7LU4OXAT34YEIFXFJU4
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HPSORX4OF527N7LU4OXAT34YEIFXFJU4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Remi Pommarel <repk@triplefau.lt>

If received skb in batadv_v_elp_packet_recv or batadv_v_ogm_packet_recv
is either cloned or non linearized then its data buffer will be
reallocated by batadv_check_management_packet when skb_cow or
skb_linearize get called. Thus geting ethernet header address inside
skb data buffer before batadv_check_management_packet had any chance to
reallocate it could lead to the following kernel panic:

  Unable to handle kernel paging request at virtual address ffffff8020ab069a
  Mem abort info:
    ESR = 0x96000007
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x07: level 3 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000007
    CM = 0, WnR = 0
  swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000040f45000
  [ffffff8020ab069a] pgd=180000007fffa003, p4d=180000007fffa003, pud=180000007fffa003, pmd=180000007fefe003, pte=0068000020ab0706
  Internal error: Oops: 96000007 [#1] SMP
  Modules linked in: ahci_mvebu libahci_platform libahci dvb_usb_af9035 dvb_usb_dib0700 dib0070 dib7000m dibx000_common ath11k_pci ath10k_pci ath10k_core mwl8k_new nf_nat_sip nf_conntrack_sip xhci_plat_hcd xhci_hcd nf_nat_pptp nf_conntrack_pptp at24 sbsa_gwdt
  CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.15.42-00066-g3242268d425c-dirty #550
  Hardware name: A8k (DT)
  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : batadv_is_my_mac+0x60/0xc0
  lr : batadv_v_ogm_packet_recv+0x98/0x5d0
  sp : ffffff8000183820
  x29: ffffff8000183820 x28: 0000000000000001 x27: ffffff8014f9af00
  x26: 0000000000000000 x25: 0000000000000543 x24: 0000000000000003
  x23: ffffff8020ab0580 x22: 0000000000000110 x21: ffffff80168ae880
  x20: 0000000000000000 x19: ffffff800b561000 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 00dc098924ae0032
  x14: 0f0405433e0054b0 x13: ffffffff00000080 x12: 0000004000000001
  x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
  x8 : 0000000000000000 x7 : ffffffc076dae000 x6 : ffffff8000183700
  x5 : ffffffc00955e698 x4 : ffffff80168ae000 x3 : ffffff80059cf000
  x2 : ffffff800b561000 x1 : ffffff8020ab0696 x0 : ffffff80168ae880
  Call trace:
   batadv_is_my_mac+0x60/0xc0
   batadv_v_ogm_packet_recv+0x98/0x5d0
   batadv_batman_skb_recv+0x1b8/0x244
   __netif_receive_skb_core.isra.0+0x440/0xc74
   __netif_receive_skb_one_core+0x14/0x20
   netif_receive_skb+0x68/0x140
   br_pass_frame_up+0x70/0x80
   br_handle_frame_finish+0x108/0x284
   br_handle_frame+0x190/0x250
   __netif_receive_skb_core.isra.0+0x240/0xc74
   __netif_receive_skb_list_core+0x6c/0x90
   netif_receive_skb_list_internal+0x1f4/0x310
   napi_complete_done+0x64/0x1d0
   gro_cell_poll+0x7c/0xa0
   __napi_poll+0x34/0x174
   net_rx_action+0xf8/0x2a0
   _stext+0x12c/0x2ac
   run_ksoftirqd+0x4c/0x7c
   smpboot_thread_fn+0x120/0x210
   kthread+0x140/0x150
   ret_from_fork+0x10/0x20
  Code: f9403844 eb03009f 54fffee1 f94

Thus ethernet header address should only be fetched after
batadv_check_management_packet has been called.

Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 3 ++-
 net/batman-adv/bat_v_ogm.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index acff565849ae..1d704574e6bf 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -505,7 +505,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_elp_packet *elp_packet;
 	struct batadv_hard_iface *primary_if;
-	struct ethhdr *ethhdr = (struct ethhdr *)skb_mac_header(skb);
+	struct ethhdr *ethhdr;
 	bool res;
 	int ret = NET_RX_DROP;
 
@@ -513,6 +513,7 @@ int batadv_v_elp_packet_recv(struct sk_buff *skb,
 	if (!res)
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e710e9afe78f..84eac41d4658 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -985,7 +985,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->soft_iface);
 	struct batadv_ogm2_packet *ogm_packet;
-	struct ethhdr *ethhdr = eth_hdr(skb);
+	struct ethhdr *ethhdr;
 	int ogm_offset;
 	u8 *packet_pos;
 	int ret = NET_RX_DROP;
@@ -999,6 +999,7 @@ int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 	if (!batadv_check_management_packet(skb, if_incoming, BATADV_OGM2_HLEN))
 		goto free_skb;
 
+	ethhdr = eth_hdr(skb);
 	if (batadv_is_my_mac(bat_priv, ethhdr->h_source))
 		goto free_skb;
 
-- 
2.39.2

