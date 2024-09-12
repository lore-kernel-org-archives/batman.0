Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C515EEB591
	for <batman@archiver.kernel.org>; Thu, 12 Sep 2024 11:08:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 65D1583E97
	for <batman@archiver.kernel.org>; Thu, 12 Sep 2024 13:08:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726139321;
 b=heW7CDzedeq6CSOkarR4Dva0CvuzIAF62C4IfzusRpxT45Fdh4th7UEpMau541UxZ0oNp
 c7Apw3hfwLum5W6bw75kAgIlNmVWRExbF6X8KmmQpqd1nSe75zRQkXhPgjYu/2lxEhOx8CC
 08cyTs3q5wC1bpYM5e+1MeTmYZOl0Sw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726139321; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=a2HUajqlOKVTY70qu1GuBGj1QouM8q4psI/BrM2TPYc=;
 b=ig5bHq7z0mV4ZwQmAnLb4ya+Z+odDHa7iKQRw8HEG2pB70CG+U6z4AijoRy5Qs8bYSWq1
 yZOak4GPUpyl0C4/As+QWxZQQw7nkvrGjw2JcXsxUYD7Gz+By5t3IgazRV3Gk/ax//GPWjW
 PLhCbFLUnnqyfK4xGqh4UqupGa3wHcU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CB100817E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Sep 2024 13:08:02 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726139282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a2HUajqlOKVTY70qu1GuBGj1QouM8q4psI/BrM2TPYc=;
	b=rrgQUG7xYDj9DQQ6S8q85B4cFseW+0J+hn+C8/yMwgL5LfMg6CylK1CxaDmzoSvdmLL+es
	+52RKNideQlZPmH9+WHduPknJwXpAA2NJJ0FL3N9QwPO6tlgy52qngVHH8Qpx+GcFD/OYa
	9IqALc+xx6xq6PSq1EPJ5jobFsSSFvU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726139282; a=rsa-sha256;
	cv=none;
	b=C7qsJVNtMcIhnYn4nwqdv90Tcb4ISvqNO+y5GJAzcHwlL+mf7oWzTEZDyLmSAN1IcdT+W1
	4E7l7pYACvHkX/YYiJyimBqOQTQux6vElN3+HDr1t27ReWhZBOGdOUw1jHx+VoNvwCpAEz
	tJ3J+DS3slCwqXYrAXjNshSEHCiAXQc=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 147383EEF2;
	Thu, 12 Sep 2024 13:08:01 +0200 (CEST)
Date: Thu, 12 Sep 2024 13:08:00 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v5 1/2] batman-adv: split DAT cache into DAT cache and
 DAT DHT
Message-ID: <ZuLLkEf15zZTN5xj@sellars>
References: <20240911051259.23384-1-linus.luessing@c0d3.blue>
 <20240911051259.23384-2-linus.luessing@c0d3.blue>
 <0f7c0a9f-6577-4d37-8ad3-2a6b1369b539@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f7c0a9f-6577-4d37-8ad3-2a6b1369b539@unstable.cc>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: LQ3CNYL6DMPMGIAT2D43O44PD3WGT73I
X-Message-ID-Hash: LQ3CNYL6DMPMGIAT2D43O44PD3WGT73I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LQ3CNYL6DMPMGIAT2D43O44PD3WGT73I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Antonio,

Thanks for the feedback!

> I haven't followed previous discussions, therefore my question may just
> sound redundant, but if "cache_hash" is for ARP what is the "DAT DHT"? (the
> A in DAT stands for ARP).

The dht_hash would just store what was pushed to it from remote nodes
through the DAT DHT feature. So through a BATADV_P_DAT_DHT_PUT in
a batman-adv unicast4addr packet.

And would only be used for responses to a BATADV_P_DAT_DHT_GET.

The cache_hash would store all the other cases. That is local
additions learned through bat0. Or the responses this node got to
a BATADV_P_DAT_DHT_GET.

> Moreover, it seems with this approach you are converting the DAT concept
> into something "type specific" - am I wrong?

You mean to be able to use it for other types than ARP? Like the
patchset we had for IPv6 a while ago? Hm, no, that at least wasn't
the intention.

> 
> Is it truly required just to have a different timeout?
> Wouldn't a mark on entries be enough to instruct the subsystem about what
> timeout value to use?

That would work, too, right. I just found a split simpler and less
error-prone. With flags I'm always worried about missing potential
race conditions when flipping it back and forth. Especially with
the two different timeouts involved here.

For instance if I had an entry through a remote node
(BATADV_P_DAT_DHT_PUT) and therefore with a flag set. But now got an update for the same
address/entry through bat0 (maybe the client device roamed to us?
Or some collision / duplicate address usage?).
Should I now always unset the flag? Or should I check if its remaining
timeout is less than 5min and only if it is then unset the
flag?

Should a response to a BATADV_P_DAT_DHT_GET only be to an entry
with the flag set? Or independent to what the flag is set to?

.oO(Maybe a split could also be useful if one wanted to introduce
individual limits for additions? Against remote attackers trying to
DoS a node?)

Let me know if you'd still prefer a flag instead of a separate
hash table and I could change that.

Regards, Linus
