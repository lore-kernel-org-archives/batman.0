Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE8BCCD187
	for <batman-adv@archiver.kernel.org>; Tue, 14 Oct 2025 07:25:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B33A784C6A
	for <batman-adv@archiver.kernel.org>; Tue, 14 Oct 2025 09:25:48 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1760426748;
 b=kFS5+84h7ms0Pe1CUfG6qISbhLKJXy/+OXxTjdi30ifrZCyabu+kahrCCCCakNYQXcGWd
 lCyEHhbXkxduQ+SwxJFLQcuW48prJdQE+MIkUirVCtI2EKuHbbzfIMHpkYGQWQAbV28ayZz
 9fh63fyY7WIs+6HKJp2L1w24pZvA8qE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1760426748; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3i2KDMc+s1CJgDhvqXCWfqM/APqyptMs4c2dfrtzl5I=;
 b=L8JD38LSpd7YaZOo1FKjwVLOmimB03ifmN5uMfTmpbua1cQ/f9HzpxyOf/uwhfXT2wIhc
 IvhO3tmtSBIZJWwVoUcW1dwQiYTtU+ufoBD1OjsCI//L8TutHDXn5Fs/WOoMrQc/ryrpitN
 vkpEc2y9y9BNIFzV1iMPWzgrsCYQzVc=
ARC-Authentication-Results: i=1; open-mesh.org;
 dkim=fail;
 arc=none;
 dmarc=fail header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C6AC381D6F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Oct 2025 23:37:32 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Gateway shut down detection takes too time from other nodes
From: mbiglari4@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Mon, 13 Oct 2025 21:37:32 -0000
Message-ID: <176039145278.1493.3258424615578163774@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: mbiglari4@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: 5QIIDOSJHFYQWFZWT3HIYMMNEQ2DPDL3
X-Message-ID-Hash: 5QIIDOSJHFYQWFZWT3HIYMMNEQ2DPDL3
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:25:43 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5QIIDOSJHFYQWFZWT3HIYMMNEQ2DPDL3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear readers,

I have implemented a Mesh network with Wifi nodes on 802.11s and BATMAN adv. My mobile nodes are mesh nodes, and I am using 802.11s to create a mesh network. Within this network, some nodes act as servers and others as clients. Suppose one of the nodes is selected as a gateway by the clients. The problem is that when this gateway node powers off, the other nodes do not immediately detect this change, and it takes a long time for them to recognize and switch to a new server as the gateway.
