Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C86CAC592
	for <batman-adv@archiver.kernel.org>; Mon, 15 Sep 2025 11:54:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5E7C7845C1
	for <batman-adv@archiver.kernel.org>; Mon, 15 Sep 2025 13:54:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1757937246;
 b=pbvwdJeGxGGnmaNDMKBMazqhlQkvHH32hQqxlG4xqKzSVjYXtvdLl8pw6zuE+ufO5wtAa
 avjmeXL18CZM1+56UlVNOxyvB0c73l5v6gqQwbmk26FpYHoLk8aBhTnpQVZwC5VOAL6M9Wy
 uS08tlm0OuaZUTW6f+eWHQw5q4d7M7E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1757937246; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Vtbx2Al14ceFH0Ey01dfrwqp9AilOF0h6qg8oobk3/g=;
 b=NiX68MI8eAbqm/gEYQrf20Sw+Vf9T2D5ahBSb4FA+maMY5CX5S9twfOGSwdM/ZH6kvRr0
 dmRc/A5vguIgfhLDhw1n6CxY8STASdOpHpwAhb6BuHY1CcAg2DX62LhA0eo7RySRJzDNWJ9
 fprOmqN7vDShFF/wrsxlmYy5qClnjpo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc;
 arc=pass;
 dmarc=pass header.from=unstable.cc policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=unstable.cc;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=unstable.cc policy.dmarc=none
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6029F819ED
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 15 Sep 2025 13:53:34 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1757937214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Vtbx2Al14ceFH0Ey01dfrwqp9AilOF0h6qg8oobk3/g=;
	b=Y7RyaPH794XomgkvodbxP73ekXyCFw3z6OPaPvezB1jcqH/rRM6fLtJHYiTMRfFnvuW+j+
	dzXNRFKRJs9MEdnmvKubDDVcIW4umvw9niU35+Z2orMgF+t9kUx5y8igBjQQHHRdpwz/Uc
	3YpjJdyE6kDZQSmpVKpBuf3GzdNYAbY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=MBO0001 header.b=b4O+1Nuc;
	dmarc=pass (policy=none) header.from=unstable.cc;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 80.241.56.152 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1757937214; a=rsa-sha256;
	cv=none;
	b=Lkd9Ei18NZgZzSVksjg4FWJjwECNvi7+jIPVUNxnM0EQ7TxRPrEAepHF8h8NNyHvIqH9tO
	vszPvTbu0Lhb/3Fu6x4BX7H+fZQkNbDOKsUx0Jk0ssD8fvsioBPwh5euI/N6xJtq4EL+Mn
	YLeBLMlF/U2r9tBiYrKyEbnhlkmANUU=
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cQNhq2YCVz9v5k;
	Mon, 15 Sep 2025 13:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc;
 s=MBO0001;
	t=1757937211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vtbx2Al14ceFH0Ey01dfrwqp9AilOF0h6qg8oobk3/g=;
	b=b4O+1NucPAB6Fe9TA6ZTfmvMfLpMn0PR5mdHYPJHQSvx4vg7qEAXNuSATZ8yYsZaNp97lR
	HedKT3tQcRRLaBGlV/p7LRS/Gd8Gr4bD2IA0eRmp6HWW6t+oEzIKGcE6gr2Us4lAOMwJGF
	8Kwjsc0wf+tm4Y+EptSbs7N60JV4TUUH+frzLKabOkEF+uwVTDwaHm6ZxmQ6x5B1PjlKXM
	YWQ64MVzCbaMSxpP9dJxQQXYm0oZtTWjazKA9QTdZ/zmG91MirwML+52XDG0Tz0aY4Zwwu
	FjIaT4i/BHQvEsP3D2xGPzpaB62ib4p6O2u2a/ZJ2KoSdm4SkOSOHuhfQA3m+A==
Message-ID: <2da5b8ef-1628-4296-b85a-9dcf8ae1a184@unstable.cc>
Date: Mon, 15 Sep 2025 13:53:30 +0200
MIME-Version: 1.0
Subject: Re: Mobile Ad-Hoc use-case where each node may be Client and Gateway
To: martinvdberg@gmail.com, b.a.t.m.a.n@lists.open-mesh.org
References: <175776078622.1495.8426151955000236578@diktynna.open-mesh.org>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <175776078622.1495.8426151955000236578@diktynna.open-mesh.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KLGKQO22SHKJST5OOKOUXABA7EIG3FIX
X-Message-ID-Hash: KLGKQO22SHKJST5OOKOUXABA7EIG3FIX
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KLGKQO22SHKJST5OOKOUXABA7EIG3FIX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On 13/09/2025 12:53, martinvdberg@gmail.com wrote:
> Hi,
> 
> I’m researching whether the following use case can be implemented with B.A.T.M.A.N., and I’d appreciate any guidance on how to achieve it.
> 
> Use case:
> 
> - A Wi-Fi mesh network consisting of multiple OpenWRT devices.
> - Each device is mobile, meaning nodes can join or leave the mesh at any time.

"mobile" normally implies that a node does not have a fixed position, 
but it would rather move (i.e. getting closer/farther to/from other 
nodes). Is that also the case?

However, both scenarios (what you described and what I described) are 
supported: batman-adv is built to deal with dynamic networks of any 
sort. (Just keep in mind some scenarios may be slower to converge)

> - Any node may have its own internet connection and if so, share it with the mesh by acting as a gateway (gw_mode=Gateway).
> - Each node should automatically choose the best available internet route—either through the mesh (as a gw_mode=Client) or via its own internet access.

When a node is configured as gateway (gw-mode=server) the assumption is 
that it is also the best GW for itself, hence DHCP requests reaching 
this node (i.e. from stations) will stay local and won't go out in the mesh.

If you decide that it is not a good GW anymore, some external logic must 
kick in and switch gw_mode from server to client.
At this point DHCP requests will be sent to the "best" GW in the mesh.

> 
> My main concern is whether a node can simultaneously act as both a gateway and a client. Is this possible, and if so, how can it be configured?


Given what I said above, I hope you understand that batman-adv expects 
each node to be either gateway or client at any given time.

If you want to dynamically switch between gateway and client, then you 
must have some extra logic (external to batman-adv) that takes care of 
the switch.

> 
> Thanks in advance!


Cheers,


-- 
Antonio Quartulli

