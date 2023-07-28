Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CDFC001DE
	for <batman-adv@archiver.kernel.org>; Fri, 28 Jul 2023 13:51:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3AD4782F05
	for <batman-adv@archiver.kernel.org>; Fri, 28 Jul 2023 15:51:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690552269;
 b=mZ0TFWMGbZbQKKtWDsW7oDX9dyge0MO0KnDD+qlCu8GX/tO/WUNyv9q87vZmtung6PxGG
 hepU0mtznIX97ZRCXVzAU+cYdKzdNrBHOi3MBpbOvBoGXPIRX2gcByL2KO6NzGObJnrriMu
 OnZuXY4jhjqxtu/EX+95jQ2GYN9C9+8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690552269; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A+pb95UIwurCzw0/KGPeMaUtbfjC8u9eRtp7VxUI8s4=;
 b=03MQn8C32pIQ4Js3Fhv11Qpt90RAVvNIzgFcF6tEcMheR9ehbRgQ+853NxiEOjXomYbbD
 tMbNsVnWw1zL/ZdB8EN4vAx8IOEGOpjjpUHm8IfDPA9+6buDbhKdTKYFv3roGvc48odYLJb
 VawQTclwfTMc9Dr1MMRmmOAuRZvtqbA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::225])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DAEE180188
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 28 Jul 2023 15:37:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690551463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A+pb95UIwurCzw0/KGPeMaUtbfjC8u9eRtp7VxUI8s4=;
	b=1mulyRkmNL2qHuNjvMQGR5n2pn8g4sj7VN+bD2ZBmwH14+iyfLKQySkoS+mOlqWuyPgVwR
	JuJSJJ6p3WniBUYdLXJPklFvGFXclmzzK0MZ70FRtKaxS32SL4+4p54urZxw2HhS9hAgzv
	T7w5tV54J+nmPH6+b80D3AIV5NzBd30=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 2001:4b98:dc4:8::225 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690551463; a=rsa-sha256;
	cv=none;
	b=b8sPboV4MtB92vLqxCW9c3LQ18tCnITSkEC1HLOn8NE+b+K/ipKMFpkCvHJUWHeSjwwv2J
	sUGvOD51WSzq7agkl5Ifm/jldnWx1NIovxko0rFJ0Hohos6RZQFYFE5pJvPGR+hO2i+039
	YDxVHtJPSTaH8Q5ErK7CLEEYNSwOAgA=
Received: by mail.gandi.net (Postfix) with ESMTPSA id 701451C0007;
	Fri, 28 Jul 2023 13:37:40 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH net] batman-adv: Do not get eth header before
 batadv_check_management_packet
Date: Fri, 28 Jul 2023 15:38:50 +0200
Message-Id: <20230728133850.5974-1-repk@triplefau.lt>
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
Message-ID-Hash: RDV4G5UCHJYAEBK55PXZV2RQUJYTCLNL
X-Message-ID-Hash: RDV4G5UCHJYAEBK55PXZV2RQUJYTCLNL
X-Mailman-Approved-At: Fri, 28 Jul 2023 15:50:55 +0200
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RDV4G5UCHJYAEBK55PXZV2RQUJYTCLNL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
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
2.40.0

