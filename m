Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D4DCAC587
	for <batman@archiver.kernel.org>; Sat, 13 Sep 2025 10:53:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 71AA084544
	for <batman@archiver.kernel.org>; Sat, 13 Sep 2025 12:53:28 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1757760808;
 b=A9RqjvfN0EkTVuNw66TLJxznNoVEZd47yOFlvleJEfaGJLglDc7IqdvBQwI32zquXzzAH
 hbVV2HrGqQgAdeMeKzwJvSczqtnEgcJbmOTOQlzteA+HhT/tOTeBb+9dpZnldZsxIIs1eE6
 60UbvwiibE4V4zICTw2jU0bFD4DH87E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1757760808; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Zvm6G1UraUwHtSsLso3ZF1fuaJnSLzV3Xdng8E2n4rU=;
 b=K77cxiO8PGripv+DHW79zlfy8aURKsMBaDLjECrlA1pPMWVEfl4IBa5U90FaLyp8EW425
 bTSBySOg5PgjUOb0QV5W3uubn39zWi//hxz/jP1r/mdGT7dH1hs6jz/eM7dZe5QlkLyXG3p
 0eglqPJP6jJs/DsWrjM9+Wt86Q31/RY=
ARC-Authentication-Results: i=1; open-mesh.org;
 dkim=fail;
 arc=none;
 dmarc=fail header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D158829A2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 13 Sep 2025 12:53:06 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Mobile Ad-Hoc use-case where each node may be Client and Gateway
From: martinvdberg@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sat, 13 Sep 2025 10:53:06 -0000
Message-ID: <175776078622.1495.8426151955000236578@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: OYFWWIPB5FCIPHDGMLZGXTVHHBKEFDUM
X-Message-ID-Hash: OYFWWIPB5FCIPHDGMLZGXTVHHBKEFDUM
X-MailFrom: martinvdberg@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OYFWWIPB5FCIPHDGMLZGXTVHHBKEFDUM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

I’m researching whether the following use case can be implemented with B.A.T.M.A.N., and I’d appreciate any guidance on how to achieve it.

Use case:

- A Wi-Fi mesh network consisting of multiple OpenWRT devices.
- Each device is mobile, meaning nodes can join or leave the mesh at any time.
- Any node may have its own internet connection and if so, share it with the mesh by acting as a gateway (gw_mode=Gateway).
- Each node should automatically choose the best available internet route—either through the mesh (as a gw_mode=Client) or via its own internet access.

My main concern is whether a node can simultaneously act as both a gateway and a client. Is this possible, and if so, how can it be configured?

Thanks in advance!
