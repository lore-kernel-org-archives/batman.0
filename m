Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8B4C02183
	for <batman@archiver.kernel.org>; Fri, 17 Jan 2025 02:14:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3319783E54
	for <batman@archiver.kernel.org>; Fri, 17 Jan 2025 03:14:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737080049;
 b=uJVyxnhi5Z6SpRhoe4R7Cg6vvWpAFS0fmjrTS6CifDzAiZqInF7qfp0AiNEctIW6jdItn
 dWqd86WBvKSuyp8YpkcBmBR+kGCItCSF2ntVstUqcOByLMj6iXT6DTD3HmvC/Wtl/sxbwwG
 +IriFqgWTB4S941aXeubVBEBTXXAs8E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737080049; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mnbZrBF7u9Ea4jZZV5+pi6UQpCZqtF50gkrdcVFGsUo=;
 b=yiYyCc09dH/hWKRYHuBOSVYEZJ7tXl+Gf0qsdPBgqhSAq3Yv29c9D73FTbs5kEPnE9wOl
 EdIkWsHqwXQeJ1t8L7EVEHZTwHUFNVJhnxGKlhibFqx5d9BeFNQqrbVXBD1BVxy6pJ3MNOL
 3wEoeSvEFKzy7AGaMRWHDhj7kE3r2t0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5B85E818A1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 03:13:52 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737080032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mnbZrBF7u9Ea4jZZV5+pi6UQpCZqtF50gkrdcVFGsUo=;
	b=BngAQac54fmeB7MXaTZLOMRuFOGLdFwDgW2f9XTuEdaLA0aXWTp2P6wCR9LC6t/UFTuYIl
	FBnI8BjmJPmxRgRJH20GuQizYKuL7QRdRPYA8AciUbZ0PwwkpomS+5tJKU5cveJZuRXeNz
	RVQc61bDQnRckgCX4u/VDqlvNbSVpm0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737080032; a=rsa-sha256;
	cv=none;
	b=mHhLVJyrvfJHFfbtzR3GJIVbGbgkm3d0sCjBqzWlLJgsVE2Kgg034NcxJ1v/EwcK6ECO5D
	0GP4jWDAkMN2YL8Yv4mjowXASfDSQyqWYVXJoHREG93B/PU4O/7yi4Vwx8dRjS9TaUqIF5
	uHziYdTiprEQKMNiAzoqASBQjEDnGMA=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6B82D5411D0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 03:13:51 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v9 0/3] batman-adv: increase DAT DHT timeout
Date: Fri, 17 Jan 2025 03:06:34 +0100
Message-ID: <20250117021348.2021-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: CBAMZWKDNXZUUQDFQZ6XB356I7D7L454
X-Message-ID-Hash: CBAMZWKDNXZUUQDFQZ6XB356I7D7L454
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CBAMZWKDNXZUUQDFQZ6XB356I7D7L454/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This patchset increases the DAT DHT timeout to reduce the amount
of broadcasted ARP Replies.

To increase the timeout only for DAT DHT entries added via DHT-PUT but
not for any other entry in the DAT cache the DAT cache and DAT DHT
concepts are split into two separate hash tables (PATCH 2/3).

PATCH 3/3 then increases the timeout for DAT DHT entries from 5 to
30 minutes.


The motivation for this patchset is based on the observations made here:
https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping

                                                                                                                              In
tests this year at Freifunk Lübeck with ~180 mesh nodes and Gluon
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

Changelog v9:
- PATCH 1/3:
  - fixed typo in a comment: ENOENT -> ENONET

Changelog v8:
- PATCH 1/3:
  - fixing / cleaning up includes
  - fixing function kernel doc titles
  - fixing bugs introduced in v7 in the error handling of
    batadv_orig_dump() and batadv_neigh_dump(), using a goto
    pattern with more explicit labels

Changelog v7:
- adding PATCH 1/3 to add the batadv_netlink_get_softif() wrapper to
  reduce the amount of duplicate code, both in the current code base
  but also for the next PATCH 2/3

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
