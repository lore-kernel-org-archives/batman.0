Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3663ECD4F47
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 17:43:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7436E85AA9
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 19:43:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779039824;
 b=w4oOODtyhg+Xmu8uDFOENFfCCmOX7477DkGrA5XtrPycRu45kc9DFwQGcezMkzS7ADVPG
 msmIyuULEpdcZ+Pi5lqF+jHlblCx2ELoZG0cevaLngMf8aIiwDhFy6QeYs2j8eicQ8efyVx
 JSSPvqeheed+qL3kX0e/XQOdoEOynkk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779039824; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zww9b+D7N/+lRkcVQC0YhmyGT4lRXlzp4OWHhAUL9Nw=;
 b=xdM2f8Hq6G2i21uwbYE2SZJlK4wgoZniH/PPHJCWkt5HyqoQTJ1Pta2q23OgHrFAK5WMu
 9MX5+MHp2FPQlsOAwvEMVbpot54Zg6fLQ5prw4sSoYsXUhgx56/kyr/i3VxlU5qf1o8lYZc
 g3jgvE2+Q6Z8Xz7xW7WF2sS9jbeSKVQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9A6778072F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 May 2026 19:43:03 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779039793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zww9b+D7N/+lRkcVQC0YhmyGT4lRXlzp4OWHhAUL9Nw=;
	b=TRIB29cpF0Mp8nqhYHgy99A2B8/C23ojYZcDs1jZcrT8j1o4o1pPLEn2Rj+IL+MkR9Vsm5
	az04iPLE8b165F3yWkpz2X/zdDQApHnNeCGAAdWXeWdaPiHrylgktauHqmgAkUHwHBll1c
	PwCT9S8HF+iYmSpRFZ9XW4OYRLqwG5k=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779039793;
	b=ok8lh2zyK9VZa6V8UGc98Dx2uX2Nua+5VuPS38tBabuj5+D5XGmJz+Ao0ArDH/E8sbv6ZM
	HW3bPc6cIYmgC86tI2972O8TCyD8YbDWlnXz90daimVGPg0aWLggNZxLBRbvZICQVxFhWX
	5h789dMTs7ecQZ5FOLEcWM6dL2DNtUQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 807E4542B5A;
	Sun, 17 May 2026 19:43:02 +0200 (CEST)
Date: Sun, 17 May 2026 19:43:01 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv 0/5] batman-adv: allow to specify limits for
 remote learned objects
Message-ID: <agn-JXkIGCucPwaB@sellars>
References: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516-resource-limit-v1-0-6f597360ed2b@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: NRQMUG3WTUTINTEHLPMBV7SVIVTKORAV
X-Message-ID-Hash: NRQMUG3WTUTINTEHLPMBV7SVIVTKORAV
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NRQMUG3WTUTINTEHLPMBV7SVIVTKORAV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, May 16, 2026 at 02:35:17PM +0200, Sven Eckelmann wrote:
> There are some concerns that an external entity could spam the batman-adv
> related interfaces with random mac addresses. The batman-adv would use more
> and more resources to safe things like neighbors, originators, TT, ... and
> would at some point run out of resources.
> 
> One idea is to limit the number of entries for each resource type could
> have. Things which might need limits
> 
> * orig_node
> * neigh_node
> * tt_local_entry
> * dat_entry
> * bla_backbone_gw
> * bla_claim
> 
> Things which are limited by other things (maybe)
> 
> * hardif_neigh_node
> * gw_node
> * orig_node_vlan
> * orig_info
> 
> Unknown how to handle overly large tt_global_entries:
> 
> * tt_global_entry

For tt_global_entry I think we are currently bound by MTU size and
the maximum of 16 fragments? So ~2000 entries? Which in an IPv6
enabled network, due to one multicast TT entry for each IPv6 address,
would maybe be ~500 hosts. Which isn't much already when considering
that people bridge larger TP-Link Omada / Ubiquiti UniFi setups into
batman-adv at least at Freifunk.

> This approach is also used for the bridge since commit bdb4dfda3b41 ("net:
> bridge: Track and limit dynamically learned FDB entries"). And it is also
> disabled by default.

I agree that it would make sense to agree on similar approaches
for the Linux bridge and batman-adv.

> For the moment, I just want to demonstrate how this might work with some
> example code. I didn't invest any time to actually check out the other
> items in the list. So, please consider these lists as vague suggestions.

Some more, vague thoughts/ideas on what to do when hitting limits:

We now have this new multicast packet type. And have introduced
these "want_all_*" flags. We could also introduce such flags for
unicast. And have a unicast packet delivered to multiple nodes
via the batman-adv multicast packet type.

We could do more "aggregation" of addresses and more broad,
opportunistic delivery when hitting limits.

This could also be useful if some host (accidentally or not)
was using the same MAC address as another host, maybe. To treat
such a unicast MAC address like a multicast one then.


I also would be interested in aggregating/absorption/handover of other
originator('s flags + TT entries) when a node is only connected
via one other node. So that a neighbor node takesover the
responsibility, to save OGM traffic. We have a lot of such leaf
nodes with a single connection in Freifunk setups and could probably
save 2/3 of the OGM traffic by that. And this could be useful for singular nodes with a
cellular modem, to avoid having constant, costly OGM streams to them, by
transparantly, within batman-adv switching them from a full "originator mode",
to a leightweight "TT client mode" with a few ELP hellos or so.


tl;dr: hop-by-hop auto-aggregations should make it harder for an attacker
to DoS from a single position in the network?

Regards, Linus
