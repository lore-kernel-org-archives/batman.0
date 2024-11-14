Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59646D68B1A
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 13:49:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 74776835F7
	for <batman@archiver.kernel.org>; Thu, 14 Nov 2024 14:49:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731592140;
 b=IoykNrUK2eFmhkmmYTicneM60mnxzbL30qy/Cm13MdCj1LKpxKbgBuTgyTHxMN7+2XIhU
 WiV1ghU/ORgwHQG29NHiQBrnrA0/n9kYi5jU7dyQzdkyVHQxf65lJ53jnJTeHBPakAspUpn
 HaGanpEgkcdutNV1BEorthV5xenKeNQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731592140; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/p1s2vsXNar2VjOXLmuOIU5JWgJCcD7+ch7Khe0/O1w=;
 b=EOVslneTwrXl5F8OEj17nroyW//gVHdRuqM7Jts5vH0LHqDNEmNbbnzJK+S6IkKNy3T6X
 6iEYCjCb/AT4uYQqhsm6jXIRBgj0jvShMp8PfKHNCDfHEcy6qY6qWJpbwH97YQYtn5ZJQXY
 0+o/fKs0Ngp1pkSc4GhtmurGZhq1pPI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C920581193
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 Nov 2024 14:48:53 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731592133; a=rsa-sha256;
	cv=none;
	b=0scStaktuXd/GD/jtwS2LR4xsoZCOInP3G15rlOh87XVPSN3Jxk2QxA2Q+BJh5acrFJ/OM
	xpSA/gaMbiWCr0gD619vJ1qvwljdi07cNEt3A+8qZXkFv4LGFYGGfRZEeyrlVNmGfEW9vy
	kzoOSMtdgfKNEFbbr97zRBH6048dnZA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=iXKmGRrQ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of nico.escande@gmail.com designates
 2a00:1450:4864:20::432 as permitted sender)
 smtp.mailfrom=nico.escande@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731592133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:dkim-signature;
	bh=/p1s2vsXNar2VjOXLmuOIU5JWgJCcD7+ch7Khe0/O1w=;
	b=k7YEl6zyJKuQbGpVF98x0lix79flXvKkB6ISOnrWC2mqIZaizv2eLJIEB5u7oE3DHiJrRQ
	Zr/hpyJ/zRh4HtcnFxyWh3tQKC5zObWA+reERKC7C8gJImlWtVfPLeUHsx3Ipl5GxPzuvm
	8wP3x60syBcIL06fltGld3oNzuLzocc=
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d4c482844so425933f8f.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 14 Nov 2024 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731592133; x=1732196933;
 darn=lists.open-mesh.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p1s2vsXNar2VjOXLmuOIU5JWgJCcD7+ch7Khe0/O1w=;
        b=iXKmGRrQrfxEmROjwtJdmG6pB9R+OlxiI6vgZVA3/k6UD4ZOvsoHLvaOkuk6jO/b4U
         bZ3iRNAAHSs3ktrVN8NrRRNCSopHFZeVefRdSwSKmnd27CmfG7hL4eepxia5HL5LNmNs
         imNS1gU0XYu79CzrsQJAjgHnN0+tj2LhPqwNgQzGEYi0BHtyW6Fw9nydfsOxGNrgOSBw
         g6M4phARbCMiekxOm92POFPMqsM0ABU/3HCq0nwSWD+oNsUn+333uk0uQ5j7AozHh015
         IQbTkdLa15hQBF/SamTcwJZKmUcfbIGyBR/8/grUhBY4b1PvVZi7Qq1gIAKlIQPI2SXb
         h31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731592133; x=1732196933;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/p1s2vsXNar2VjOXLmuOIU5JWgJCcD7+ch7Khe0/O1w=;
        b=kYOaUuunaaj7Tir2/ZD/WOy+O3yIDp13O/pfaTO++c7MimxyOKWDhfiLxpFxFZuAeK
         adX9fi5/umVrKGzsQu2Y/EsHdu3EhDZspG3ZmbmohYhADu2SmAKKbwiAsgFtUSHAY6Ww
         NVtvqlXgyuMUDlmogFOLXQpG2SVYm7KZFHJzDmLqtd2Z4DZiM2IpZS28XiHadbE6aROc
         Ib2YkWNzbG895+gTBiaVzWkMzI7F/6u05oFuQ1vMYKZPSWLXufUPbxyJXaXRjGUj+ExZ
         wA/LCroSTW31BLrjKu/xfadu8WPhr4XVtAk0NaxuA+1MDAoofjbQGjsMuvn6tlnTTZUy
         y5Rg==
X-Gm-Message-State: AOJu0Yw2C2ydtnGMlbqnwAdeTjYqVenIA19rh91u8V2O8QvuLQC7ytc/
	QNFAZnSteZJsK7DHy3zQJDQClJtPEFaCGOLbvrNbx1XeHsMMmJm9
X-Google-Smtp-Source: 
 AGHT+IEBS6rE2a96GFnfaSH3k87S/a4qS3nMOXrwSqYWUIVCmHNsDYem7lfbzYK5JAp5Ul8CrIkZHw==
X-Received: by 2002:a5d:6481:0:b0:37d:525d:5a60 with SMTP id
 ffacd0b85a97d-381f18672e4mr17185754f8f.8.1731592133022;
        Thu, 14 Nov 2024 05:48:53 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae31083sm1510638f8f.103.2024.11.14.05.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:48:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 14:48:52 +0100
Message-Id: <D5LY6JQJT9NV.2MI0DB2CLTO6D@gmail.com>
Cc: <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: [PATCH v2] batman-adv: add dynamic, bridged-in TT VID detection
 support
From: "Nicolas Escande" <nico.escande@gmail.com>
To: <linus.luessing@c0d3.blue>
X-Mailer: aerc 0.18.2-0-ge037c095a049
In-Reply-To: <20240612213944.4169-1-linus.luessing@c0d3.blue>
Message-ID-Hash: VD44NUPCSSVJMCAC54I42KGAE4XJGXR3
X-Message-ID-Hash: VD44NUPCSSVJMCAC54I42KGAE4XJGXR3
X-MailFrom: nico.escande@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VD44NUPCSSVJMCAC54I42KGAE4XJGXR3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi there,

We've been running this for a few time and it's very usefull. So is there a=
ny
news on merging this into the kernel ? Or is the BLA thing blocking ?

However, this patch seems to leak some vlan entries on softif interface del=
etion.
For me simply running a kernel with kmemeleak & doing a simple ip link del =
bat0
shows splats like theese:

This should take care of kmemleak reports as this one:
	unreferenced object 0xffff00000cadff00 (size 128):
	  comm "xxx", pid 913, jiffies 4294914994 (age 77762.956s)
	  hex dump (first 32 bytes):
	    40 c9 35 05 00 00 ff ff 00 00 00 00 00 00 00 00  @.5.............
	    39 77 ff 61 01 00 00 00 00 00 00 00 00 00 00 00  9w.a............
	  backtrace:
	    [<00000000f10febf1>] __kmem_cache_alloc_node+0x1d4/0x340
	    [<00000000178f97a6>] kmalloc_trace+0x40/0x128
	    [<0000000087db8410>] batadv_softif_vlan_get_or_create+0xa0/0x1c0
	    [<000000009f648859>] batadv_tt_local_add+0x7ec/0x10f8
	    [<00000000c0dacbb0>] batadv_softif_create_vlan_own+0x48/0x60
	    [<00000000676cacd0>] batadv_hard_if_event+0x1a0/0xb58
	    [<00000000cd053741>] notifier_call_chain+0xb0/0x220
	    [<0000000019022ed7>] raw_notifier_call_chain+0x1c/0x30
	    [<00000000e22f9034>] call_netdevice_notifiers_info+0x6c/0xc0
	    [<00000000fb639003>] register_netdevice+0x5ec/0x778
	    [<00000000e2ac250c>] batadv_softif_newlink+0x48/0x68
	    [<00000000b65a146a>] __rtnl_newlink+0x81c/0xb10
	    [<00000000a91fbe5b>] rtnl_newlink+0x60/0x90
	    [<0000000043273284>] rtnetlink_rcv_msg+0x3d8/0x568
	    [<00000000da2bd331>] netlink_rcv_skb+0xc0/0x1e0
	    [<000000007523d87a>] rtnetlink_rcv+0x1c/0x30

So I fixed it by removing the extra refs that is hold for the vlan entry wh=
en
added to the global list. For me it seems superfluous. This way it also mea=
ns
that when a vlan entry gets deleted (because the last tt entry holding a re=
f to
it gets dropped) the vlan is freed instead of staying there forever.

Or maybe I missed something ?
=20
---
 net/batman-adv/soft-interface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interfac=
e.c
index b61f35918b5d..d7de54734725 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -599,7 +599,6 @@ batadv_softif_create_vlan(struct batadv_priv *bat_priv,=
 unsigned short vid)
=20
 	atomic_set(&vlan->ap_isolation, 0);
=20
-	kref_get(&vlan->refcount);
 	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
 	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
=20
--=20
2.47.0
