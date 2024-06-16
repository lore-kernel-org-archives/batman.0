Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA97C27C6E
	for <batman@archiver.kernel.org>; Sun, 16 Jun 2024 20:38:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CC30F82FA8
	for <batman@archiver.kernel.org>; Sun, 16 Jun 2024 22:38:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718570318;
 b=q3DVxuWSKhzlYMB3PuWS6pFXWn5WPPStxDu9ugZ326yPwVWMXc5YVMTLqVXL6anh5Vw04
 E4XpfckrTLKkJNiM1meo52ZQtOUCTV7dveI2vbxzo4nr4LNw/mt7Z5N3IbrOo0H03Q7fiGC
 naQjF2MjI49OLCyNGDp/ViPgBQd+zzE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718570318; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nlVFU5o2/vVFH6pdWpAuUEbSFBd5ucAHsPGqHXnxJwM=;
 b=cXZQ0xGwkEqXugVEQo4ELDiHBkAzqvqeVmEID97XT5qYoGtl5L9cnHAtISYJBxsqsfrLB
 ydcs649eK8C0NuIDFYzQ66fvmwKcSRgW8eYV5M/2ys+/cTAwbX+J8C5Bb8hWQJu3WAdvoQ1
 DUNsAcmjFVtES/vTg2Addmon4paBB00=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C751981E8E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 16 Jun 2024 22:38:25 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718570305; a=rsa-sha256;
	cv=none;
	b=J9pkqEQ+dZDhG3BojcAXpUroc15rmYw5p4K3vG+3Y+pBuI0sSQXquAcOZXo940vhYhJeCx
	hv6J0YMrdHmE+nDYQKrGOSRzX5o6FScJBYilNhAoIq5q2pKU4TSudmR+y8MI63voVBoXO8
	4V3pEo2CTZygtHgx/sXFAM0K6lMTJnY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718570305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlVFU5o2/vVFH6pdWpAuUEbSFBd5ucAHsPGqHXnxJwM=;
	b=Gl3WbCbzBlumk9etcYF0zikPbYvUhIl4KQejio0DPEgSjsQoi6+p4yZouxlEUDYjubnzHx
	g08KSYLGZNrl+OvsKFBhEIQvHLZ5qPqBJ7QmWtlYglbpp6Z4NEuMuigiXeO9OO+imqw2BO
	8ZLDu/0EmK87SGU3U2i1gbZhD9ApxK0=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B95AE3EE5E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 16 Jun 2024 22:38:04 +0200 (CEST)
Date: Sun, 16 Jun 2024 22:38:22 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v2] batman-adv: add dynamic, bridged-in TT VID detection
 support
Message-ID: <Zm9NPkUOQuj93BQs@sellars>
References: <20240612213944.4169-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612213944.4169-1-linus.luessing@c0d3.blue>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 63KZAK5OR2QKLSIRAIAIRMIREAVWESGN
X-Message-ID-Hash: 63KZAK5OR2QKLSIRAIAIRMIREAVWESGN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/63KZAK5OR2QKLSIRAIAIRMIREAVWESGN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Jun 12, 2024 at 11:39:44PM +0200, Linus Lüssing wrote:
> So far, if we wanted to bridge VLAN tagged frames into the mesh one would
> need to manually create an according VLAN interface on top of bat0
> first, to trigger batman-adv to create the according structures
> for a VID.
> 
> With this change the VLAN from bridged-in clients is now automatically
> detected and added to the translation table on the fly.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---

Just wanted to add two more remarks / oddities I was stumbling
over when working on and testing this and reading the code.
Which might be something worth additional patches in the future.


Minor thing, in the following case I would have expected the
P/NOPURGE flag to be added, but it wasn't:

```
root@linus-work:/# batctl tl
[B.A.T.M.A.N. adv 2024.1-10-g2ee1b45a-dirty, MainIF/MAC: ens3/02:04:64:a4:39:c1 (bat0/02:11:00:00:00:01 BATMAN_V), TTVN: 12]
Client             VID Flags    Last seen (CRC       )
02:11:00:00:00:01   -1 [.P....]   0.000   (0x1350f3f4)
02:11:00:00:00:02   -1 [......]   3.788   (0x1350f3f4)
root@linus-work:/# ip link set dev bat0 addr 02:11:00:00:00:02
root@linus-work:/# batctl tl
[B.A.T.M.A.N. adv 2024.1-10-g2ee1b45a-dirty, MainIF/MAC: ens3/02:04:64:a4:39:c1 (bat0/02:11:00:00:00:02 BATMAN_V), TTVN: 13]
Client             VID Flags    Last seen (CRC       )
02:11:00:00:00:02   -1 [......]   1.872   (0x8d84de4b)
root@linus-work:/#
```

Don't see a functional issue right now though. If it were timing
out and deleted and then a frame is sent from bat0 then it would
be readded with the P/NOPURGE flag.


Secondly, discovered this yesterday when trying to add multiple
VIDs quickly like this:

```
for i in `seq 3 8`; do
	mz bat0 \
		-a 02:33:02:34:00:01 \
		-b bcast "81:00 00:0$i 08:00 ca:fe:ca:fe"
	sleep 1
done
```

Then this won't work. Whenever adding a new VID broadcast
traffic seems to stale for 30 seconds from this node
due to the "num requests in flight" check in batadv_bla_tx():
https://git.open-mesh.org/batman-adv.git/blob/36cfdc4401412d5a00231b1fd65a95ac71111035:/net/batman-adv/bridge_loop_avoidance.c#l2052

So repeating that command every 30 seconds will add one more VID
every time. Then after 6x 30 seconds you could use all VIDs as
expected, as long as they don't time out.
With "batctl bl 0" no such delay + broadcast filtering happens and VIDs would be usable
immediately with that loop for the mausezahn command.
-> Might make sense to make bat_priv->bla.num_requests per
   VLAN in the future instead? (would that make sense?
   or am I missing something else or an easier solution?)

Regards, Linus
