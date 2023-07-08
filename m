Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E44EB64DA
	for <batman@archiver.kernel.org>; Sat,  8 Jul 2023 21:52:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A8F7B81E89
	for <batman@archiver.kernel.org>; Sat,  8 Jul 2023 23:52:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1688853129;
 b=jv0qVf2KVtUw9ScIy9ptywt+VlRwqipIMlWHGBIJuVX2+qYzfyGrMWpNs+3r3Uz3YbGU+
 +ZQTsL65QoJ7evEukZHDzEQZQLGi5xQEmiWFDkkS0CyUjEPz+VU3b+8X2Y1i6yZvzblCzXW
 tt4JbLfWKOMPC5G6dHii+c83KasjXu0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1688853129; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Yr+WnXroM41VoZZCuloHXEv6RUQP67LKRHUOqkcTs9I=;
 b=zbq4BXEZG3x+c4EwmnmLdnQzOKSjE5+4BnQcZm+bx7rZEIgVwBYZtXGmhrRvxPBJWnuX0
 nOEWeyCOEIVwD4000pLoqpeZnOqiT1YzPQ6dcZ9dtQqt6ZdWp3M2Kk1pkeNfVf8GbnxJvkR
 xqrisOZu/yjkQG0qm2ip4Xhl6Gjxm/Y=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 17A3F8045B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  8 Jul 2023 23:51:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1688853099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Yr+WnXroM41VoZZCuloHXEv6RUQP67LKRHUOqkcTs9I=;
	b=hojLCrWqCvnYsX/pb0ySkFZjKQPHEtq+7iO6Ea13SyTyVMBq9S191RoBUNU19t/AL94Efe
	gt0F5uu+7UVb5+SaxKLHgBZNkC5ORu2JtxPq98OLvoB97uhQZUg+PXJ3yhQU59S0BPaQcd
	0Nt4co6bvQC95GqgLHRS9UQUrUa74Lg=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1688853099; a=rsa-sha256;
	cv=none;
	b=ee53JbV5Olwwnb9+ewaK335l2zPZQwBcq2GiOL0XcFZ1sP3QSzXENFTY4JgqbtXjdVbreC
	rF6whmyb7txiXWvE1OTwn3gEc8GAX3xO8QzlGI9moyJDpGefB7kJ/j4dhdtk7vPrqMeO9q
	WzI0JdR5fGRTAgVuigmBc4Geu0N2Xng=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=none (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue has no
 SPF policy when checking 116.203.183.178)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC4F4419CE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  8 Jul 2023 23:51:31 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH v5 0/3] Implementation of a Stateless Multicast Packet Type
Date: Sat,  8 Jul 2023 23:51:10 +0200
Message-Id: <20230708215113.15325-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: CRSS3TFTWI5TEPBWMZ2GKXXP56LTXAEI
X-Message-ID-Hash: CRSS3TFTWI5TEPBWMZ2GKXXP56LTXAEI
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CRSS3TFTWI5TEPBWMZ2GKXXP56LTXAEI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

[PATCH v5 0/3] Implementation of a Stateless Multicast Packet Type

Hi,

The following patchset implements a stateless, TVLV capable batman-adv
multicast packet type.

The new batman-adv multicast packet type allows to contain several
originator destination MAC addresses within a TVLV. Routers on the way will
potentially split the batman-adv multicast packet and adjust its tracker
TVLV contents.

Routing decisions are still based on the selected BATMAN IV or BATMAN V
routing algorithm. So this new batman-adv multicast packet type retains
the same loop-free properties.

The purpose of this new packet type is to allow to forward an IP
multicast packet with less transmissions / overhead than the 
multicast-via-multiple-unicasts approach. Or to reach a lot more
destinations (currently up to 196, depending on the payload size, see 
Wiki documentation for details) than with the default multicast fanout
for the via-unicasts approach.

This will allow using applications like mDNS again in several Freifunk
communities. And with less transmissions will also make more bulky
multicast applications, like media streaming (to an assessable amount of
receivers) a lot more feasible.

This approach is way simpler than the original multicast (tracker) packet
approach we envisioned years ago. As it involves no maintenance of an
extra, state based multicast routing table. However the TVLV capability
should allow to extend things later, to split control and data plane a bit
more for instance, to further increase the number of destinations, to
further reduce overhead.

A compact overview can be found in the Wiki here, including limitations:

https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-Packet-Type

Regards, Linus

---

Changelog v5:
* removed patches 1/5 + 2/5, as they were already applied
* rebased to current main branch
* changed padding behaviour:
  * now 2 bytes padding on the end of the multicast
    tracker TVLV, if number of destination nodes is
    even
  * as number of destination nodes might change between
    initial check until after pushing them, functions
    to post-adjust padding after pushing were added
* added/fixed TTL handling
* removed skb_pull() bailing from sub-functions of
  batadv_mcast_forw_push(), to only have a single
  skb_pull() to keep track of in batadv_mcast_forw_push()
  to revert the changes to the skb; instead a
  "unsigned short *tvlv_len" is passsed along in 
  batadv_mcast_.*push.*() functions to keep track of
  how many bytes were pushed
* moved + verified skb->ip_summed invalidation
* batadv_mcast_forw_shrink_tracker() xmas tree ordering
* reword batadv_mcast_forw_push_dest() "Return:" kerneldoc
* fixed spelling: outter -> outer

Changelog v4:
* PATCH 4/5:
  * add missing include for linux/types.h in multicast.h
  * add missing kerneldoc for @bat_priv in batadv_mcast_forw_push_dest()
    and batadv_mcast_forw_push_tvlvs()
  * use sizeof_field(type, field) instead of sizeof(((type *)0)->field)
    in batadv_mcast_forw_push_dest()
* PATCH 5/5:
  * rename num_dests_remove to num_dests_reduce in
    batadv_mcast_forw_shrink_align_offse() to fix kerneldocs and for
    consistency
  * fix typo in kerneldoc in batadv_mcast_forw_shrink_update_headers()
    -> @num_dest_reduce -> @num_dests_reduce
  * use sizeof_field(type, field) instead of sizeof(((type *)0)->field)
    in batadv_mcast_forw_shrink_align_offset()

Changelog v3:
* PATCH 1/5:
  * remove now obsolete includes
* PATCH 2/5:
  * fix batadv_tvlv_handler_register() in network-coding.c
  * add missing include for linux/skbuff.h
  * move variable declarations out of the switch case
    in batadv_tvlv_call_handler()
* PATCH 3/5:
  * remove unnecessary include of multicast.h in routing.c
  * add a few missing includes to multicast_forw.c
    (linux/byteorder/generic.h, linux/errno.h, linux/gfp.h, linux/stddef.h
     uapi/linux/batadv_packet.h, multicast.h)
* PATCH 4/5:
  * add missing rcu_read_unlock() in error case before returning in
    batadv_mcast_forw_push_dests_list()
  * remove unnecessary include of soft-interface.h in multicast_forw.c
  * add a few missing includes to multicast_forw.c
    (linux/bug.h, linux/build_bug.h, linux/limits.h, linux/rculist.h,
     linux/rcupdate.h, linux/string.h)
  * make batadv_mcast_forw_mode_by_count() static
  * fix return types in the declaration of
    batadv_mcast_forw_packet_hdrlen() and batadv_mcast_forw_push()
    in multicast.h
  * fix typo in commit message: "that the are capable of"
    -> "that the*y* are capable of"
* PATCH 5/5:
  * make batadv_mcast_forw_shrink_pack_dests() adhere to 80 characters
    per line for consistency
  * add a "continue" statement after the jump label in
    batadv_mcast_forw_shrink_pack_dests() to silence the sparse error
    "error: label at end of compound statement"

Changelog v2:
* Add "[PATCH v2 0/5]" prefix to title of cover letter, so that
  Patchwork can hopefully find it - no other changes

