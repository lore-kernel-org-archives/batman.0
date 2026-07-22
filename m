Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0758BC44539
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jul 2026 10:08:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2880E812BF
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jul 2026 12:08:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1784714935;
 b=Xg12kybzhSaUrV41fqTt84XRyjSumuo1gGugkBFdVhu0pDHMiYg0CfeZwDtXXpTviKcFs
 B8ihvl6bgPUmwZByVshFHaQJ3/ZS+6K8hdNkOEwvmz7z1xFJ60Lgj/7cyVWK0Dt0fVwBTsI
 VH8G/VsxcPgLVDfim7c4H9cpr6tzv1Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1784714935; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kffhxcucn3OzmtLIIbVyOBtk7MB1urxIKk5ihYoKb18=;
 b=SZRIKjMfTBY+lVXm0bg9DUZh/KIpIYSl6BwcUQYXB11D2OLn8rYH4sNg1j/T7UTxrSdbj
 mWzJV/3PDbgQUXtZbBuerL/0kb/CseFBDNrsgwiZGbEYZhAPjnsRViThe2MnxJVSovm5zVE
 0UKvdDuaScST6vQvNEq+/tPMCsv2J5U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 888F6809A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Jul 2026 12:08:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1784714906;
	b=krF6MFp5foLd90rrD8R67hRUge/o47COWOJfxLLmLcXNRUVFUSWYNWEoE57fWpqnsXzJDM
	oHU559F69KVHBhdbkCEiCuSwpGc4ggPFLgwCrwipZTnQXgSYuhHIn4D2laXB7ZdPLJ+d2z
	c6b0xIUQgwVAAf3BTwgDdL6ojZgVxjw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1784714906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=kffhxcucn3OzmtLIIbVyOBtk7MB1urxIKk5ihYoKb18=;
	b=ZMFZ4bnpvq5I/b27lzxFARrk5D1fHI6Qym9wxuYAUpmvZn1bQSonnKTKzSiXcgCUTxnkML
	Kb/oZTtk5AyfoHjvKS0H3tGnOp7Dx6lvwEa6n4UD4Bvtx4g3qEQi/5+Cv7ytk8bqlTSwE5
	EIljk17C9iuCBvmlZahM8qKPiiv68FA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hcCULqRE;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 1A317200D4;
	Wed, 22 Jul 2026 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1784714895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kffhxcucn3OzmtLIIbVyOBtk7MB1urxIKk5ihYoKb18=;
	b=hcCULqREPMwoN0EVWkM4K9i9/0K0OG1nHVG7IUURljgVO0P6mFY0T+bp6zhY9KSAFw+PaB
	6CpEDFhkQOVLq/pHP8Uc0D28wXkeAaXkpYzAC5tgl58qmcuctyTXPcpPVPybU4Rkv4HFus
	YJ0NWzszxcCGQ1d8BXFt5DEhICxg4l4=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Jul 2026 12:08:09 +0200
Subject: [PATCH batadv] batman-adv: bla: fix freeing of claims on meshif
 deletion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-bla-claim-cleanup-v1-1-68d5743d581a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAIiWYGoC/yWM0QqDMBAEf0X2uQF7pFr6K6UPl3jqiU0lURHEf
 29sXxZmYWZHkqiS8Ch2RFk16SdkuF4K+J5DJ0abzKCSqrImMm5k40fWd17hsEzm5pj4bq1QbZG
 9KUqr26/5hOOZmxWv/58WN4ifzyCO4ws/GArWfQAAAA==
X-Change-ID: 20260722-bla-claim-cleanup-5ba2a844e274
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6730; i=sven@narfation.org;
 h=from:subject:message-id; bh=pfYzUxoInWJw4JI9cflxEZrtRRrkQbnmtrsJ40V4ZdQ=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGpgloqgD33Vg8UWxmFcc4Y4BwUQtiuYAH1Z27Ja2u9WuzztD
 Ih1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmpglooACgkQTQ93K9MU9cvW+wEA/5cM
 cTj67SZfKIhSVUlcVurpihZ+6Vj6QpVZzX+beWsA/3Dbvs3Pvmhl9mR+RPq+ULHpkMjYWIeQowO
 NLH4r2v0K
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KPH6CTT2UQ6FCVELFJNIRC5UBV27F3A6
X-Message-ID-Hash: KPH6CTT2UQ6FCVELFJNIRC5UBV27F3A6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KPH6CTT2UQ6FCVELFJNIRC5UBV27F3A6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When the mesh interface is getting deleted, then
batadv_bla_del_backbone_claims() (via batadv_bla_purge_backbone_gw()) could
make sure that all claims gets removed. But this function is only executed
when bat_priv->bla.claim_hash is not NULL. And since batadv_bla_free() is
always setting it to NULL before it is (indirectly) called, it was never
actually executed.

But the batadv_bla_purge_claims() -> batadv_handle_unclaim() is at the
moment too fragile because the BLA code is not handling the rehashing in
batadv_bla_update_orig_address(). The stored backbone address doesn't have
to be the one actually used for the hash bucket selection during the
initial adding of the backbone. The batadv_handle_unclaim() can therefore
fail to find the respective backbone for the unclaim and then stop the
deletion.

But the actual backbone_gw object is not needed for the unclaim because all
relevant information is always provided by the caller. And the check for
the existence of the backbone_gw doesn't provide any additional security
check for the deletion of a claim.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Problem was caused by https://www.open-mesh.org/issues/452. Was seen with
following test configuration:

    #! /bin/sh
    
    set -e
    export PATH="/host/batctl/:$PATH"
    
    echo disabled loading
    rmmod batman-adv || true
    insmod /host/batman-adv/net/batman-adv/batman-adv.ko
    
    ip link set up dummy0
    
    batctl ra BATMAN_IV
    batctl meshif bat0 interface create
    batctl if add dummy0
    batctl if add enp0s1
    ip link set up dev enp0s3
    ip link set up dev bat0
    ip link show dev bat0
    batctl n|head -n1
    batctl b 1
    
    MAC_PART="$(ip link show enp0s1 | awk "/ether/ {print \$2}"| sed -e "s/.*://" -e "s/[\\n\\ ].*//"|awk "{print (\"0x\"\$1)*1 }")"
    IP_PART="$(echo $MAC_PART|awk "{ print \$1 }")"
    ip addr replace 192.168.42.${IP_PART}/24 dev bat0
    
    ip link add link bat0 name bat0.10 type vlan id 10
    ip link add link bat0 name bat0.0 type vlan id 0
    ip link set up dev bat0.0
    ip link set up dev bat0.10
    ip addr replace 192.168.43.${IP_PART}/24 dev bat0.0
    ip addr replace 192.168.44.${IP_PART}/24 dev bat0.10
    
    ip link add  dev br0 type bridge
    ip link set up dev br0
    ip addr replace 192.168.45.${IP_PART}/24 dev br0
    
    ip link set master br0 bat0
    
    ip link add veth-in type veth peer name veth-out
    ip link set master br0 dev veth-out
    ip link set up veth-out
    ip link set up veth-in
    ip addr replace 192.168.46.${IP_PART}/24 dev veth-in

After it was running for a while (with an uplink to FFV), the interface was
deleted:

    ip link del dev bat0

And then the memory was scanned:

    $ echo scan > /sys/kernel/debug/kmemleak
    $ sleep 5
    $ cat /sys/kernel/debug/kmemleak
    unreferenced object 0xffff88800d243900 (size 192):
      comm "softirq", pid 0, jiffies 4294893474
      hex dump (first 32 bytes):
        d4 0a dc 8a 32 98 00 00 00 02 94 0e 80 88 ff ff  ....2...........
        00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
      backtrace (crc abaa484d):
        kmemleak_alloc+0x55/0xa0
        __kmalloc_cache_noprof+0x2b4/0x590
        batadv_bla_add_claim+0x4d3/0x12d0 [batman_adv]
        batadv_handle_claim.isra.0+0x52/0x2f0 [batman_adv]
        batadv_bla_rx+0xbfd/0x1110 [batman_adv]
        batadv_interface_rx+0x402/0xac0 [batman_adv]
        batadv_recv_mcast_packet+0x3ee/0x6b0 [batman_adv]
        batadv_batman_skb_recv+0x40e/0x5e0 [batman_adv]
        __netif_receive_skb_list_core+0x61f/0x9c0
        netif_receive_skb_list_internal+0x626/0x1070
        napi_complete_done+0x1ba/0x820
        virtnet_poll+0xc5d/0x18a0
        __napi_poll.constprop.0+0xa3/0x520
        net_rx_action+0x452/0x1170
        handle_softirqs+0x1cb/0x880
        irq_exit_rcu+0x112/0x1a0
    unreferenced object 0xffff88800d243400 (size 192):
      comm "softirq", pid 0, jiffies 4294893480
      hex dump (first 32 bytes):
        be dd b4 e6 68 a8 00 00 00 02 94 0e 80 88 ff ff  ....h...........
        00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
      backtrace (crc fdf62603):
        kmemleak_alloc+0x55/0xa0
        __kmalloc_cache_noprof+0x2b4/0x590
        batadv_bla_add_claim+0x4d3/0x12d0 [batman_adv]
        batadv_handle_claim.isra.0+0x52/0x2f0 [batman_adv]
        batadv_bla_rx+0xbfd/0x1110 [batman_adv]
        batadv_interface_rx+0x402/0xac0 [batman_adv]
        batadv_recv_mcast_packet+0x3ee/0x6b0 [batman_adv]
        batadv_batman_skb_recv+0x40e/0x5e0 [batman_adv]
        __netif_receive_skb_list_core+0x61f/0x9c0
        netif_receive_skb_list_internal+0x626/0x1070
        napi_complete_done+0x1ba/0x820
        virtnet_poll+0xc5d/0x18a0
        __napi_poll.constprop.0+0xa3/0x520
        net_rx_action+0x452/0x1170
        handle_softirqs+0x1cb/0x880
        run_ksoftirqd+0x32/0x60
    ....

The problem is not visible when I only have one interface added and thus
no-rehash is needed while the bat0 interface is deleted.
---
 net/batman-adv/bridge_loop_avoidance.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f231afbe..54f4e432 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -949,26 +949,18 @@ static bool batadv_handle_unclaim(struct batadv_priv *bat_priv,
 				  const u8 *backbone_addr, const u8 *claim_addr,
 				  unsigned short vid)
 {
-	struct batadv_bla_backbone_gw *backbone_gw;
-
 	/* unclaim in any case if it is our own */
 	if (primary_if && batadv_compare_eth(backbone_addr,
 					     primary_if->net_dev->dev_addr))
 		batadv_bla_send_claim(bat_priv, claim_addr, vid,
 				      BATADV_CLAIM_TYPE_UNCLAIM);
 
-	backbone_gw = batadv_backbone_hash_find(bat_priv, backbone_addr, vid);
-
-	if (!backbone_gw)
-		return true;
-
 	/* this must be an UNCLAIM frame */
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
 		   "%s(): UNCLAIM %pM on vid %d (sent by %pM)...\n", __func__,
-		   claim_addr, batadv_print_vid(vid), backbone_gw->orig);
+		   claim_addr, batadv_print_vid(vid), backbone_addr);
 
 	batadv_bla_del_claim(bat_priv, claim_addr, vid);
-	batadv_backbone_gw_put(backbone_gw);
 	return true;
 }
 

---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260722-bla-claim-cleanup-5ba2a844e274

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

