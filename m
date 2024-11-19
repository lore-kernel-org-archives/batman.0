Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A23D44162
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CF854842E5
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 15:25:56 +0100 (CET)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732026356;
 b=sHMXvJznxO6C/LfNaqqeGCs0BjacY0xu6SkZiKIcSqkizO5vgv75wY6j8Zyp2LAwDbaXe
 Y0v3enkhG/ZnDtoSu9Q3mrtS3WtLbSE4P4ZO7wi/y926FpBfbZGtmuYDFhet1ApogcoI+pm
 nyb6yZV2aCn6It6wFeRZcCKurJ/dqYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732026356; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yZ1BSUPYeZ9l/N/mdajCuY0YjhNzUkmr3qZL9PGugqo=;
 b=NDAbt+yFH10cKtxYkRPeb3pJp7ax8G2WRyCdGlX85uILQH56VS3vGHLsz7eTbPedLt6us
 alSknWTAWJ4QC4MBk94KndUnB5ghH0gZqBPIGP0ReN9XE/ZamxgctCCpqWtd8TTjzqedVkV
 68eJQTBLPgBMnjKwQ4ISZ3CNMp1vsUo=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B52A981CAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 15:21:40 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: IP connectivity issue at openwrt nodes
From: soanican@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 19 Nov 2024 14:21:40 -0000
Message-ID: <173202610073.676947.3056533458107107503@diktynna.open-mesh.org>
In-Reply-To: <173195908428.676947.9438253969806655968@diktynna.open-mesh.org>
References: <173195908428.676947.9438253969806655968@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: soanican@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: NUJR27VLWAXRUAHTRL4MCCEAC2HAMI7J
X-Message-ID-Hash: NUJR27VLWAXRUAHTRL4MCCEAC2HAMI7J
X-Mailman-Approved-At: Tue, 19 Nov 2024 15:25:24 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NUJR27VLWAXRUAHTRL4MCCEAC2HAMI7J/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear Sven,

I would like to ask generic system and topology questions:

1-)Generic System Question
According to info at the "https://www.kernel.org/doc/Documentation/networking/batman-adv.txt" (referred from the troubleshooting page) , if following "batman-adv" folder do not exist, your interface might not be supported. -->"/sys/class/net/eth0/batman_adv/"

If that folder does NOT exist in a system but interfaces can be add/removed via "batctl if" command, and outputs indicates interface active, can we consider this system works properly?



2-)Generic Topology Question
Consider multiple batman nodes, each have 1 bridge interface, bridge have two ports, one "bat0" and "eth0", and IP is assigned to the bridge port.  At each node, multiple wired/wireless interfaces are assigned to "bat0" which have stable connections to other nodes bat0 interfaces.  These interfaces are indicated as "active" via batctl.
Can local process of batman nodes and external non-batman nodes connected to "eth0" port of the bridge, have IP connectivity to each other via IP addresses assigned to bridges?

best regards
MuDe
