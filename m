Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADB3CCD193
	for <batman@archiver.kernel.org>; Wed, 15 Oct 2025 08:05:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5E0978466F
	for <batman@archiver.kernel.org>; Wed, 15 Oct 2025 10:05:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1760515531;
 b=0Wn4TlIJQZq1SaTLtwKYpi4tulqytvsT8kzYQd7zwW7KDxCDZgDtYQFTuWJxnXRKx51jp
 gbQhnZt2Pv/nFoAYuyFWa1jqJvC0cOoSrBRaMCamBxYpc0BGZEqhLVBquMduxe3OLNfvpPD
 3+pHrYck4d2Nnx7s8yFmv5bDaQ0Ea7I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1760515531; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SMyzYlm6vzTNPEDdPIfA93rUbSlTtmk8lnWIKEFC4h4=;
 b=Vet6Z/NWl9nW7+6QPUWTBvPyJ6hbm4xZhzBvnL++ien6DZwrj/dZwXGlpUE1pc9NtGO8b
 uWh8L6wvlE7gAWilPKv6HdHkKvimC1lhNB7w5QYOiNEnyiTKub5j51ibiqEA4sErJPzurqo
 q6K33y9njOZtVUbHQRFayD+hb1R1Quw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2CBBE844B4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 15 Oct 2025 10:05:18 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1760515529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMyzYlm6vzTNPEDdPIfA93rUbSlTtmk8lnWIKEFC4h4=;
	b=YrZ273FZtBttgRwl7hcetE4IFC2alf+LgQDNXqZDQsczbLD3st6vqqswXffIFXjBgJJc7w
	ygBdBDmpzt7+bwD3hxwwaTW3ymmVywLYUZz6bM8F3dynk8Ln/raATiQYZz7okj5yLqfcF5
	0ZrlPrE5e4DQbxpWZyaPwr5I8Qjz7Js=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1760515529; a=rsa-sha256;
	cv=none;
	b=kVvnrJmALZ7sGCdwtyVYjz9RspuFkqH0QQXP4ED+fyquAVr0ME+OGNcH+vsj292CNiN09z
	M0VA0pwYjP7vfYUsJs5NZGVEEu2svabeQquGrsegxs6aVawe4A/j5ZQsf7iiqgonUuwqxH
	77b2ECLmtYRz/p8iVXKWKXkJVwvcwTM=
Received: from prime.localnet
 (p200300c59700B9d838eeDeEc7F6B3C58.dip0.t-ipconnect.de
 [IPv6:2003:c5:9700:b9d8:38ee:deec:7f6b:3c58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8E640FA12C;
	Wed, 15 Oct 2025 10:05:17 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: mbiglari4@gmail.com
Subject: Re: Gateway shut down detection takes too time from other nodes
Date: Wed, 15 Oct 2025 10:05:16 +0200
Message-ID: <9767419.DvuYhMxLoT@prime>
In-Reply-To: <176039145278.1493.3258424615578163774@diktynna.open-mesh.org>
References: <176039145278.1493.3258424615578163774@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Message-ID-Hash: RJCZ2XGQFOYFNY22T2PFEWZD4F7NEDZD
X-Message-ID-Hash: RJCZ2XGQFOYFNY22T2PFEWZD4F7NEDZD
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RJCZ2XGQFOYFNY22T2PFEWZD4F7NEDZD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

can you describe your setup a bit more? Are your "gateways" connected with=
=20
each other over Ethernet? Do you have multiple DHCP servers on your gateway=
s=20
respectively, or is there a DHCP server in your LAN interconnecting gateway=
s?=20
Are you using bridge loop avoidance? Perhaps an illustration would help.

There are different scenarios how to set up this network kind of network, a=
nd=20
failover time  may differ from a couple of seconds to a couple of minutes=20
depending on the setup.

Thank you,
        Simon

On Monday, October 13, 2025 11:37:32=E2=80=AFPM Central European Summer Tim=
e=20
mbiglari4@gmail.com wrote:
> Dear readers,
>=20
> I have implemented a Mesh network with Wifi nodes on 802.11s and BATMAN a=
dv.
> My mobile nodes are mesh nodes, and I am using 802.11s to create a mesh
> network. Within this network, some nodes act as servers and others as
> clients. Suppose one of the nodes is selected as a gateway by the clients.
> The problem is that when this gateway node powers off, the other nodes do
> not immediately detect this change, and it takes a long time for them to
> recognize and switch to a new server as the gateway.




