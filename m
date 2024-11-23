Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A27EE6ADD5
	for <batman-adv@archiver.kernel.org>; Sat, 23 Nov 2024 07:53:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 56789844DF
	for <batman-adv@archiver.kernel.org>; Sat, 23 Nov 2024 08:53:38 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732348418;
 b=m8MUosqVAbpyu7g/PufPfs4tRuQ2yT0yjZTLgegxzW4p9Up6+Y0XyI9d9LEujiJh8Qbdj
 UHgjR7C5UVBcrG/8D9z2ZN9rgd9Vppq92ReVSxzMtC7zIfqOAOaw5/gccFwhVqyeKnegUD1
 Mq1d+m+gc1ZThXVYA7TZDiNJPU7ixSw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732348418; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WRIUzifPLPuX0rY1ZbAUc8N5AENjOj8jHeRG7boC7Kw=;
 b=swkhpCOi5WTwz9k064abxEhey9bcN3NU+Yn/XYSjJ3sB04W7R/SVM7ZuIrhZjTh2F5i9N
 nd9pnPkNnm/LheYhnRotB6kI3HjH7weEQdLcVFQbOCq5XWJfhn766VFewiO9oMbLAVm3RLi
 I1ckCPBWK4Ci52O8U9bqWDBuYhfflRs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 927B9820F6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 23 Nov 2024 08:53:11 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732348392; a=rsa-sha256;
	cv=none;
	b=iHvninTAVDyxGiOq7kd/myDJJAULIj1WnvPrkVODpthgMuX5wtDGzQ58JNBWR3pQftBsIi
	FP/0CcecGehrjL5QScnzGvp96/cWeuKudm3AXWMnEmiClB8XIBBfeygtiooI4yaDboDxsv
	2/ZHMTKB01+GFetLKMe6p4gr5wrgw3k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732348392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WRIUzifPLPuX0rY1ZbAUc8N5AENjOj8jHeRG7boC7Kw=;
	b=SUZI5h5DqRoFGlClcvl6LST2/WkqU2lYgpXYXxBLtr/PfHXyQb1Zcg2R+/D6iecbmxAjv6
	BiF98jDVIgK2slOxkigNSTUNhuI9ZFNsF+L2V0Hoy4KhDOMh5z/RtyAGYKAK2r9sceAIo9
	yeciz6K3BnGLvXnD9/U+O8lR2bOyj+s=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 378D85413F5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 23 Nov 2024 08:53:10 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v6 0/2] batman-adv: increase DAT DHT timeout
Date: Sat, 23 Nov 2024 08:43:53 +0100
Message-ID: <20241123075304.24568-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: HJYWA627VGVUU25HNWBRE3WCIA4ECVZW
X-Message-ID-Hash: HJYWA627VGVUU25HNWBRE3WCIA4ECVZW
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HJYWA627VGVUU25HNWBRE3WCIA4ECVZW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This is the fifth itereation to increase the DAT DHT timeout to reduce
the amount of broadcasted ARP Replies.

To increase the timeout only for DAT DHT entries added via DHT-PUT but
not for any other entry in the DAT cache the DAT cache and DAT DHT
concepts are first split into two separate hash tables (PATCH 1/2).

PATCH 2/2 then increases the timeout for DAT DHT entries from 5 to
30 minutes.


The motivation for this patchset is based on the observations made here:
https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping


In tests this year at Freifunk Lübeck with ~180 mesh nodes and Gluon
this reduced the ARP broadcast overhead, measured over 7 days, as
follows:

- Total:           6677.66 bits/s -> 677.26 bits/s => -89.86%
                   11.92 pkts/s   -> 1.21 pkts/s   => -89.85%

  - from gateways: 5618.02 bits/s -> 212.28        => -96.22%
                   10.03 pkts/s   -> 0.38 pkts/s   => -96.21%

Also see graphics and a few more test details here:
- https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping#Result-2

These patches (v5) have been applied in this mesh network without issues
for 3 months now.

Regards,
Linus

---

Changelog v6:
- removed renaming+deprecation of BATADV_P_DAT_CACHE_REPLY in PATCH 1/2
- small commit message rewording in PATCH 1/2

Changelog v5:
- rebased to current main branch
  -> removed now obsolete debugfs code

Changelog v4:
- rebased to: acfc9a214d01695
  ("batman-adv: genetlink: make policy common to family")

Changelog v3:

formerly:
 "batman-adv: Increase purge timeout on DAT DHT candidates"
 https://patchwork.open-mesh.org/patch/17728/
- fixed the potential jiffies overflow and jiffies initialization
  issues by replacing the last_dht_update timeout variable with
  a split of DAT cache and DAT DHT into two separate hash tables
  -> instead of maintaining two timeouts in one DAT entry two DAT
     entries are created and maintained in their respective DAT
     cache and DAT DHT hash tables

Changelog v2:

formerly:
 "batman-adv: Increase DHCP snooped DAT entry purge timeout in DHT"
 (https://patchwork.open-mesh.org/patch/17364/)
- removed the extended timeouts flag in the DHT-PUT messages introduced
  in v1 again
- removed DHCP dependency
