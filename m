Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE68ACD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:27:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8149884295
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:27:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052054;
 b=HaeznV7lwsGFpNWf5ee9sFnJGh8sTdcmzSRfdd6LhYsupsUIM5tSldbL2ysk7oo7CjZpz
 GS3VGp9JEvsUknjXmwF4wjYXFVZzdlrGvLGR9dk3jEWHYvp+FcKfmAuHVFK2bxGmDLPXh3G
 H/m4JfVQ2E9vuWjbfG+u1g/WIF800M0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052054; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=QAxI/5NG6CtY5Jnd1pOlRLK9ImdFVgpH/qBNcFnfK4M=;
 b=DtRJS4vlsEYbzZjg8czzSwLAQ/WWdZvWzPot9UjGzB27VtRynbmd83jFO9QTq0J2C8+Vw
 Bl6KFhD1dnB6+Qx+8cTi30DmkwiwN1j2NcgNRk9s0OX9iHjHJJ5No0fer8hgYgXBbTvTsyz
 VVUlHN5Yxf8HwVZl4UPw6Eg6vIFIrQ4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2C3BD83EC3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:24:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051864;
	b=rh+V0VjqKAH41Zp3vnDHzo7iAihtOdw015jvGoS+6BG/PF1GbEc+Ge2qoOzeXdSrQKOiMC
	RbDgs9wrO2fzLPAM0Fb2Sy68A+zAXcHm+ATkautPCCjrJ2wjuLSJv+fRznfXzvkBIOA1Ck
	eQgouxreEZVnEFS6qzUa877PKxmxgMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=QAxI/5NG6CtY5Jnd1pOlRLK9ImdFVgpH/qBNcFnfK4M=;
	b=ngeVeZfsLQenVWICqRAu1HJmW5TD2kf5SF9LdK62JNaITv4mUhlq34keCLxF105lahfqak
	6wljmIjfExFdQPPJhHnp7IlNEOZBOA31OFHIL2WATafFWjQviGpdOWPfK25NWuh5Ma30SI
	Kect6LqctHz2EoUVoIjCbkOpwzcR5Ro=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=jifz29UQ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6A171200C4;
	Sun, 21 Jun 2026 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAxI/5NG6CtY5Jnd1pOlRLK9ImdFVgpH/qBNcFnfK4M=;
	b=jifz29UQkgGBsiQu0n6onWxzAdEonu7ZhBex08IV7KIgRKyR/7/kW1Jeyndix3D+WV/+5H
	O6w2+S19TuIUzLU1pz0SPFwREugG1T1B5fFpwLhb7Gq2koBq1rLMnrhE0HCzt5O1D08iVc
	QiYpappcc75s2QMwJKyAP6X9fkpJsOU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 00/28] batctl: random bugfixes 2026-06-21
Date: Sun, 21 Jun 2026 16:23:50 +0200
Message-Id: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPbzN2oC/yXLyw5AMBCF4VeRWWtCQ11eRSy0HYwF0lGRSN9ds
 fxy/nMDoyNkaJMbHJ7EtK0ReZqAmYd1QkE2GmQmVaZkLrSfRrqQRV2VQ20L21htIOa7w2+Iddf
 /Zq8XNMf7hxAeBos1GmwAAAA=
X-Change-ID: 20260621-bugfixes-875a8d4d9dbc
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848; i=sven@narfation.org;
 h=from:subject:message-id; bh=vWAeMLewZTJnTz/rdThWDNGozWb5LUoXm0lbpWN+lM8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmn/8/X3hNSO2Rvt6O1xo5u7Pen9a+ce3jPZF5Cr1XG
 QQcv2Wv6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5FszI8POLibhDF+Xotfu
 b1+c7vrHJPbqW+O2K6rWHWySk4+uc4pj+CsQ1Ote+lBq1akFnZUrZmdny/3cI6t2kINFsVjA2T7
 sCTsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: HLFGN3AZWE6S7XPVRIFCJLHIFFYRCRLZ
X-Message-ID-Hash: HLFGN3AZWE6S7XPVRIFCJLHIFFYRCRLZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HLFGN3AZWE6S7XPVRIFCJLHIFFYRCRLZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This patchset batctl is just a bunch fixes without any specific topic in
mind. 

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (28):
      batctl: fix parsing of parameters with arguments
      batctl: originators: fix throughput lines with bat_hosts
      batctl: free header lines after error
      batctl: use strict interval/timeout parsing
      batctl: improve number parsing error handling
      batctl: traceroute: handle fast replies
      batctl: ping: count sent and not received pings
      batctl: return only initialized icmp destination unreached bytes
      batctl: tcpdump: fix coded packet mac dest mac addresses
      batctl: tcpdump: fix endianness of fragmentation sequence number
      batctl: tcpdump: correct output of VLAN IDs
      batctl: tcpdump: drop hardcoded IPv6 buffer sizes
      batctl: tcpdump: fix reported length for ICMP6_TIME_EXCEEDED
      batctl: tcpdump: handle TCP packet with bogus data offset
      batctl: tpmeter: fix Gbps output
      batctl: handle netlink callback object on error
      batctl: netlink: check for BATADV_ATTR_MESH_ADDRESS before accessing it
      batctl: netlink: consume until acks even on errors
      batctl: netlink: always 0-terminate hardif name
      batctl: version: don't strip newline for empty buffer
      batctl: rtnl: report correct error on kernel communication problem
      batct: bat-hosts: compare full path for deduplication
      batctl: mark file read only succesful on read line
      batctl: bisect_iv: avoid access of uninitialized loop magic
      batctl: bisect_iv: handle failed node_get for RT_FLAG_DELETE
      batctl: bisect_iv: avoid write before buffer whole tokenizing log
      batctl: bisect_iv: avoid out of bound access on short lines
      batctl: bisect_iv: drop dangling phantom event on OOM error

 bat-hosts.c        |  2 +-
 bisect_iv.c        | 44 ++++++++++++++++++++++++++------------------
 debug.c            |  4 ++--
 elp_interval.c     |  7 +++++--
 functions.c        | 11 ++++++-----
 gw_mode.c          |  8 ++++++--
 hop_penalty.c      |  7 +++++--
 icmp_helper.c      |  6 ++++++
 isolation_mark.c   |  8 ++++----
 main.c             |  4 ++--
 multicast_fanout.c |  7 +++++--
 netlink.c          | 16 ++++++++++------
 orig_interval.c    |  7 +++++--
 originators.c      |  4 ++--
 ping.c             | 14 ++++----------
 routing_algo.c     |  7 ++++++-
 sys.c              |  2 +-
 tcpdump.c          | 33 ++++++++++++++++-----------------
 throughputmeter.c  | 19 ++++++++++++-------
 traceroute.c       | 12 ++++++------
 20 files changed, 130 insertions(+), 92 deletions(-)
---
base-commit: ea57436f665805a6e93f496617e44dab8a2f33a4
change-id: 20260621-bugfixes-875a8d4d9dbc

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

