Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36222CAC5BB
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 07:50:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AB77183FFB
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 09:50:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759045852;
 b=qFs2He3CYgjHMWZHFRpMt/C2USj2Rgt7f9hpsLfbyaeZWOwpgW0f325/KV5b0NbDRCGxm
 0npZiY5oa+fubr6UMRBAMYNkGRWYpvsnLWtXHRgn5eacY8yVbiYl1i3LZt3Igxk7Rb7pi3P
 pU1g5p6bUGGeFU5q/ewJPPSxXcAsFRQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759045852; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nB0ZMVuZr2JHPPFgW1Unq44brdPP7xx9CNItiimsCZU=;
 b=NexIeoov0U3YQ7oClSEgYMTEnxuv+WgVXD17sXsbewF0Bb5JaDyzBXrsIBXiKpKkSvwOh
 eLoOJAMfnUcQJ1sGZMeByenq3n1YujbzJtSKuatYP2/W3ahlbqN7kxt8RoeU76158LJ+NY0
 rMyEBb9SOoG6g78A0Ubo7J1E16kBFhI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CC87C83B47
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Sep 2025 09:50:14 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1759045824; a=rsa-sha256;
	cv=none;
	b=Kgcqy8TfbBbDd2UNpGfYabmyLK34/Vo7c/ygpp9c4bL9nYZvb13xOM+FtcmD0kCy3xLD+d
	Xn0jexgRoYOEdvm3Y5vH9LJYw4Oy88Hist3RG52lVm6SBb3Jd6admb+uNlf5glpq7ukPBW
	jVAZ+Z+24bNlHQAiSeDRNPPjcqr+ygE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ekcqcMPH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1759045824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nB0ZMVuZr2JHPPFgW1Unq44brdPP7xx9CNItiimsCZU=;
	b=rBK/PnLxW3CGqKv9WdgPd67C0R+fZwER7NDbE6eJJqi+9jf53goyX4ktWdyZqXeYQIrppm
	gAp3IcRP+NLFG5iwnA1OBKZca0KGLa3fQs9N5Wb7FBbPFR+sWtYpOucuQzLqNEa8UQRk/3
	TxYcCHURGyYo/LayIHj1iDdQ77ATNr0=
Received: by dvalin.narfation.org (Postfix) id 3FB6020EC2;
	Sun, 28 Sep 2025 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1759045813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB0ZMVuZr2JHPPFgW1Unq44brdPP7xx9CNItiimsCZU=;
	b=ekcqcMPHOzkYt3yXGhY+atCZe4Fxp+CdJHlsxTeIy0aQUXuBVXcXwOxD2zOurkhatIz2s4
	1z+QLSbxDdzMQryNlk266z/etCO2Y0aGwOHeAivfGPybBmD22gn/a5gCZ/1ZOrme6Mypwa
	rhDc2qexHPAzdbHRo7lpml6ibf6EtXU=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 Network Development <netdev@vger.kernel.org>,
 Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage
 count = 2
Date: Sun, 28 Sep 2025 09:50:02 +0200
Message-ID: <2450943.NG923GbCHz@sven-desktop>
In-Reply-To: <9f999251-8132-414e-9ea1-f83ecc41dfdd@I-love.SAKURA.ne.jp>
References: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
 <2754825.KlZ2vcFHjT@sven-desktop>
 <9f999251-8132-414e-9ea1-f83ecc41dfdd@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart879527330.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 4NLK2VPRSCH4TB264PFF6M7VULEC536M
X-Message-ID-Hash: 4NLK2VPRSCH4TB264PFF6M7VULEC536M
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4NLK2VPRSCH4TB264PFF6M7VULEC536M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart879527330.0ifERbkFSE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Sep 2025 09:50:02 +0200
Message-ID: <2450943.NG923GbCHz@sven-desktop>
MIME-Version: 1.0

On Sunday, 28 September 2025 03:06:05 CEST Tetsuo Handa wrote:
> Thank you for responding quickly.
> 
> On 2025/09/28 2:21, Sven Eckelmann wrote:
> > The question would now be: what is the actual problem? 
> 
> Sorry, my explanation was not clear enough.

It was long and contained a lot of things - but not what the actual problem is. 
It is necessary to read a lot of inline calltraces with subclauses - and then 
by reading between the lines, we must figure out what you actually wanted to 
say.

It is no problem to not know the underlying problem. But all these absolute 
statements, accusations and overly detailed statement made me think that I am 
just too stupid to get it and you must be right.

> What I thought as a problem is the difference between
> 
> 	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, "batadv0", 0, 0);
> 	//netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);
> 
> and
> 
> 	netlink_device_change(&nlmsg, sock, "batadv_slave_0", false, "batadv0", 0, 0);
> 	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);
> 
> . The former makes hard_iface->if_status == BATADV_IF_ACTIVE while the latter makes
> hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED (because batadv_iv_ogm_schedule_buff()
> is not called).
> 
> This difference makes operations that depend on hard_iface->if_status == BATADV_IF_ACTIVE
> impossible to work properly. You can confirm this difference using diff show below.

This is again (in my opinion) this kind of (odd) absolute statement again. 
"impossible to work properly" - this sounds like BATADV_IF_TO_BE_ACTIVATED is 
an state which you cannot escape. And that functions/operations depend on 
BATADV_IF_ACTIVE. Both statements are not really true. 

BATADV_IF_TO_BE_ACTIVATED is a transient state and some algorithm depending 
code is responsible to automatically get it in the BATADV_IF_ACTIVE state. 
This is somewhat important here because the first time I read your second 
mail, I was under the impression that something in the reproducer showed that 
the state would be stuck. I searched rather hard in the code but couldn't find 
the reason for this. Only much later, I decided to ignore all this and look 
what the reproducer is actually doing. And also ignore commit 9e6b5648bbc4 
("batman-adv: Fix duplicated OGMs on NETDEV_UP") - because it was impossible 
for me to reproduce it on this commit.

And regarding the functions/operations which "impossible to work properly": 
called functions must "work properly" independent of the state. Just what 
they are doing as work can be different depending on the state. But maybe this 
is a case of "glass is half full" vs "glass is half empty".

The problem is therefore that some function broke this "promise". Your second 
mail (and the patch) was then basically saying "BATADV_IF_TO_BE_ACTIVATED" must 
not exist and we must directly go to BATADV_IF_ACTIVE. (Even if this is in my 
opinion not the right statement) it never said why it must not exist and what 
broke because of "BATADV_IF_TO_BE_ACTIVATED".

The inline calltraces with detailed statements in subclauses make it 
harder to digest. Some small high level statements like 

"I don't know exactly what the underlying problem is but skipping 
BATADV_IF_TO_BE_ACTIVATED in batadv_hardif_activate_interface() seems to work 
around the problem. I suspect that some function is not handling 
BATADV_IF_TO_BE_ACTIVATED correctly. Maybe some kind of race condition between 
switching to BATADV_IF_ACTIVE and executing some specific code. Here are my 
detailed notes:"

would have helped me not to get stuck too long in the interpretation of 
paragraphs. But at the same time, would have given a lot of pointers in the 
right direction. But maybe I would have been stuck anyway - no idea.

Anyway, I hope we found the problem now and thanks for the help.

Regards,
	Sven
--nextPart879527330.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaNjoqgAKCRBND3cr0xT1
y9m2AP9zRfPoLfv/wRBSat2mfNow7negQymlLIHciFrlhp2rtwEAnyVyDoxTT9i5
5s8TyBYZJG6NFxFWKvIkbuasC+XR5Q4=
=t2sP
-----END PGP SIGNATURE-----

--nextPart879527330.0ifERbkFSE--



