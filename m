Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B0DE69173
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 15:54:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7883283FF2
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 16:54:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732290859;
 b=kXEguYLM4YnCwLpJkdHgvtAbOqix/7049RWFe8u48ZjfbQlS4/g0boupCvgtGhUPFQHX7
 +XundwTRNMe1tGjDsRpcw07ENgHQWS31VC6mgt59kUc2ejA2nQCnMRUhkzzynDEXqiT6Jb9
 4kN/KqleOVJVrz2q71TzkT63XQKUsUk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732290859; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Gwlue0h/9fglDY+X8dpw4o3UjiPfUDsibARkJKq/74Y=;
 b=Fk7pjhaTEwVDz8X7Smcav1253GtGpcEVqrNHGZGL6xT4qR3/TsnEMOzuW4k2otbqbwrFd
 vnE0z/sdXA0CUvrOyNwhwg04xnC9aFgDVuej1qIgH0wx/Y+1E9XvpG16moVXcpu+6Rp4Oiw
 YMyb8Q5x/3jSlBvGoIlCC0knnNqY6qM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CFEDA80B7C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 16:54:06 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732290847; a=rsa-sha256;
	cv=none;
	b=a9zCA0OWx9Qays+sd8cMjz3QuNrtWG1wsD+I20/UnYtLd7ADhAVhuV9Vs/lP5wrMA/4/R8
	gZk52+bx+4CUjhjwnaLBBwQ6mg8vynZsr06TfqA9HXUdpCOrNsPrWb8MH9PzJ+s02SsTs2
	NdI+lZ4cUIO91jUgN1lBQu7hkWuekfU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=oZp72yvk;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=WWBh44Ea;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.nzjovorkdpy6aj6=io1yfjoseteb=h3uh2vbyrzunmo@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.nzjovorkdpy6aj6=io1yfjoseteb=h3uh2vbyrzunmo@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732290847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Gwlue0h/9fglDY+X8dpw4o3UjiPfUDsibARkJKq/74Y=;
	b=15hNgeZuu8taxKLKVSz/n8MbTlfi75gzDQQRhOhMwWctBBiXDWTWlKuNHkFadyaO93Zsfy
	7VY7NUIStuOis12H1iAujd6FLkyJBU5Mb2b0JEyjg8siC9Q99yFuBJmhe6ilmOsNadIcZJ
	krfGQeOgjB2b9RmRxBKeBtM2wxtN8ic=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732291746; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=Gwlue0h/9fglDY+X8dpw4o3UjiPfUDsibARkJKq/74Y=; b=oZp72yvk9fxL/SDLV9+UcBv8Tt
	1HzZiqskBsbAmIhFmtpsBhe98VcWAZOu8qB6TgkthKSJiuu3XzwhnUOUjchsSsWTzJ6K04Cs8WlsD
	+bEc+m3ZOgVakCZ5SO9DO733t//8aYUR6MvUmpbDwW6mfzPfkCMPmc/QXXlxZqh4tkA3IHRRXjkTO
	80Ws24kxHUKrGyh4QMMl/c3lwj44TGX8DAx9gStDs2awFN1NJn0qoIJF/Rr3D+ufhvrzs3LgHVtMI
	UJH2ajDESxUtVZ1x21pNcy6ysIjA5+iuUVi669pIJlFDO0gzg5kqXEAjhvRznZF17GiGnezoH3S7E
	VXbfF/qg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732290846; h=from : subject
 : to : message-id : date;
 bh=Gwlue0h/9fglDY+X8dpw4o3UjiPfUDsibARkJKq/74Y=;
 b=WWBh44EaLLiECieu2FlX56RYWGSAMSZ8u3r0OqUSbAWDHpAajqvJAuk06vwR9B5pOA5jd
 4WdQN80w/te0j9dXJoCs+ZhqvRf46UfA8u1ylM0czNLZc44znHa8HiE2i/oZe8Qm2oh17HF
 TgPJzMwRItcx2nsUBxTYWyW6OugJzGaj+s9WYjTpH09sW4zlJsa2b4Fonox7rJI1+qSxrQ0
 N23+TrkrCnmHOjPST/3PJ2w+Cj8xgsaApofhAQeBEaXGbaHdDKEKD7Q61bYEaJVZ9qExP7P
 tq09ejfq443HhQaunNe2uz7817MkIXJbnNrY0jnA9jZkKlhGt6hG2vvd9rLg==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVyu-TRjyhr-TG; Fri, 22 Nov 2024 15:54:04 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVyu-4o5NDgrfRk9-mfEW; Fri, 22 Nov 2024 15:54:04 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 0/5] batman-adv: TT change events fixes and improvements
Date: Fri, 22 Nov 2024 16:52:47 +0100
Message-Id: <cover.1732290614.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: jR1olIWH7Phw.9VZENVQUWyu6.jAA8jQpV3xq
Feedback-ID: 510616m:510616apGKSTK:510616s19sbn7nzs
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: BQK5EBGIE6GJMJVS4WDNTYT4SPX4FZXA
X-Message-ID-Hash: BQK5EBGIE6GJMJVS4WDNTYT4SPX4FZXA
X-MailFrom: 
 bT.nzjovorkdpy6aj6=io1yfjoseteb=h3uh2vbyrzunmo@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BQK5EBGIE6GJMJVS4WDNTYT4SPX4FZXA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The first three patches are actual fixes.

The first two try to avoid sending uninitialized data that could be
interpreted as invalid TT change events in both TT change response and
OGM.  Following invalid entries could be seen when that happen with
batctl o:

 * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
 * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)

The third one fixes an issue that happened when a TT change event list
is too big for the MTU, the list was never actually sent nor free and
continued to grow indefinitely from this point. That also caused the
OGM TTVN to increase at each OGM interval without any changes being ever
visible to other nodes. This ever growing TT change event list could be
observed by looking at /sys/kernel/slab/batadv_tt_change_cache/objects
that sometimes showed unusal high value even after issuing a memcache
shrink.

The next two patches are more cleanup / potential slight improvements.
While patch 4 is mainly cosmetic (having negative tt.local_changes
values is not exactly an issue), patch 5 is here to keep the TT changes
list as short as possible (reducing network overhead).

V4:
  - Reword comment on patch 4
  - Fix flag assignment position is patch 4
  - Fix store stearing with WRITE_ONCE
  - Change tt.local_change < 1 to tt.local_change == 0 in patch 4
  - Rework/simplify TT event deduplication logic

V3:
  - Fix commit message wording
  - Update outdated comments

V2:
  - This has been tested enough to not be in RFC state anymore
  - Add one more uninitialize TT change fix for full table TT responses

Remi Pommarel (5):
  batman-adv: Do not send uninitialized TT changes
  batman-adv: Remove uninitialized data in full table TT response
  batman-adv: Do not let TT changes list grows indefinitely
  batman-adv: Remove atomic usage for tt.local_changes
  batman-adv: Don't keep redundant TT change events

 net/batman-adv/soft-interface.c    |   2 +-
 net/batman-adv/translation-table.c | 123 ++++++++++++++++-------------
 net/batman-adv/types.h             |   4 +-
 3 files changed, 72 insertions(+), 57 deletions(-)

-- 
2.40.0

