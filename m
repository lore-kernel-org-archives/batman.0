Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC256C25B75
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 12:16:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 478BD82577
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 14:16:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716293777;
 b=QvrujCgJTjqqON5lAk/ugBlmW2/NxFI0ody43tfENXZYf5WeqObAmJkQCRHq3GCrDTiWQ
 O5DU1B1gi1pspOmICCbWQ7tHRPRzQXIEd3dKRFlmosngyUctYqYFKp9btyovdwStqgnPkrc
 9D8gzwxIQnHTQWaE+VtIlqCN3NGfu5g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716293777; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j4i6dG9Qtp856a6DBxMycGONdsCsYcmNlK5ls1ssS0E=;
 b=zITnxFTH+ONiVE1ZpTeQGL5Ngai1JGLuTSYDU48RmBsEcj9mG2tnxvLc04OMpEb3PoEO5
 5azyYyu9nqnkETs/ZR2VZxXong4JWIZRPEi7hV8eyvFKNNyP+ovfzuTMzASdAGfZWBQCMiq
 ydgL02FrOMN1WyR47ZrrFbkFBVOkSt8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BE7F281202
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 21 May 2024 14:16:05 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716293765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=j4i6dG9Qtp856a6DBxMycGONdsCsYcmNlK5ls1ssS0E=;
	b=AYnO0qd/CPipvOxMKTixwgD78/OAmp+5jeROcqjcWlBbFmtS9ZZqmhGng3pE++ZzWqtdSv
	eT8u4d7+fPJgG9atESMtq+L1Ox2gWcSpmJYuBpfbgap9xWBxf1IhbDM4xkAqCupqoJ3JkI
	eYNqA9kcxKecvgPLfPXdNkuzxyap8Zc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=30e1O0Pv;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.11 as permitted sender) smtp.mailfrom=repk@triplefau.lt;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716293765; a=rsa-sha256;
	cv=none;
	b=Ji7USz5qX559kpiKBvyNrar6cqcUXJy7/HUweEl/Eq5hEKUDrjUKRbVF5dny5X3lFaFAai
	6NzT03wxQg05j67mKIC6Rj8+MOrvOlBElRqd7/57eaEvYwWVjI1j4SDSWQnO7dE0rUhCWQ
	7PsR+kMwVebzlY1/kzkxxG7pyGuQVNY=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1716293653; bh=VCD2CTNZ7z4oRRxnBehQ2Y2IiufaDLnRdQsfaU87Bj8=;
	h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To;
	b=30e1O0PvMUPHFU2OFCQWAcTvEOewIuJMOG7A0/XxE5PFqKPDNZXeK40AN2Fcy9xfb
	 VEw7FGtJkVoKa/sXq48ZUUQ8ZlMEhTtkJzAhnYF9uBCC8rMb5fm5VPY6agDImOUitS
	 fRzNm8sFTDUZJLgpNUsXU3Z/pzpTwggv2QHZ8QXo=
Received: by b221-2.in.mailobj.net [192.168.90.22] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Tue, 21 May 2024 14:14:13 +0200 (CEST)
X-EA-Auth: 
 axDdkqWQjGw/hiuVCmDOemwUrnPCHkPqq3OyHVUbWoHQMa0Pxkjj8YlEF4rFXaWXvtX71X2DY2m9XVboEecbFwUC3SVftrtW
Date: Tue, 21 May 2024 14:15:56 +0200
From: Remi Pommarel <repk@triplefau.lt>
To: Antonio Quartulli <a@unstable.cc>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
Message-ID: <ZkyQfL6JjJBTHtwN@pilgrim>
References: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
 <cef03d6c-7be8-4527-b38b-eadca2789f9b@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef03d6c-7be8-4527-b38b-eadca2789f9b@unstable.cc>
Message-ID-Hash: 2DNMCNBPI53D3MMBMBABDAXW4CJBW6A3
X-Message-ID-Hash: 2DNMCNBPI53D3MMBMBABDAXW4CJBW6A3
X-MailFrom: repk@triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2DNMCNBPI53D3MMBMBABDAXW4CJBW6A3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, May 21, 2024 at 09:43:56AM +0200, Antonio Quartulli wrote:
> Hi,
> 
> On 18/05/2024 17:50, Remi Pommarel wrote:
> > Wiphy should be locked before calling rdev_get_station() (see lockdep
> > assert in ieee80211_get_station()).
> 
> Adding the lock is fine as nowadays it is taken in pre_doit and released in
> post_doit (with some exceptions). Therefore when invoking .get_station from
> a side path the lock should be taken too.
> 
> It was actually a05829a7222e9d10c416dd2dbbf3929fe6646b89 that introduced
> this requirement AFAICS.

IIUC lock requirement was already there before this commit, only it was on
rtnl lock to be taken instead of wiphy one.

> 
> > 
> > This fixes the following kernel NULL dereference:
> 
> As already said by Johannes, I am not sure it truly fixes this NULL
> dereference though.
> 
> Have you checked where in ath10k_sta_statistics this is exactly happening?
> Do you think some sta was partly released and thus fields were NULLified?

ath10k_sta_statistics+0x10 is associated with the arsta->arvif->ar
statement. It crashes because arsta->arvif is NULL.

Here is a scenario that explains the crash where the same sta
disconnects then reconnects quickly (e.g. OPEN network):


CPU0:                                       CPU1:

batadv_v_elp_periodic_work()
 queue_work(batadv_v_elp_get_throughput)

                                            ieee80211_del_station()
                                            ieee80211_add_station()
                                             sta_info_insert()
                                              list_add_tail_rcu()
                                              ath10k_sta_state()
                                               memset(arsta, 0, sizeof(arsta))
batadv_v_elp_get_throughput()
 cfg80211_get_station()
  ieee80211_get_station() <-- Find sta with its MAC in list
   ath10k_sta_statistics()
    arsta->arvif->ar <-- arsta is still zeroed


In other words if the same sta has enough time to disconnect then
reconnect before batadv_v_elp_get_throughput get scheduled, sta could be
partially initialized when ath10k_sta_statistics() is called. Locking
the wiphy ensure sta is fully initialized if found.

Thanks,

-- 
Remi


