Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8903CF259D
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 06:56:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 04E8382509
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 08:56:11 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728888971;
 b=TYikZfTQCm4ddY+j0x1VRIwhyCtQV+PFXTONI76384etHu+HSBMT8atMchrsZrctgD18N
 +KHi6ABuyE8xkQkD9e1fIweoS676nPTEPeVhhorZcpbxQ8BevPWXXeMG09EzSjLowYh3/CK
 4FSWTfeIggnXhSpWYETFwoH9KcFIock=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728888971; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Sja7FWx2J2pFF7H03F4ldwixL8Qb/r4LwdjP0v1pkNc=;
 b=WZULjyzdI021Bw6ecAi9PKgBoNZveLVVQpmZzM5sff0lBxjheTMUsdDHdJ0pElTO7X9G6
 XA/7jlj+00+zscdPz/KG+IVGqiwqmAOQkvDagGT77sFrtG81AGNgpZZGfPgJDKa/iWVj/T1
 QxhcHstYu1uzmxZ38fS25YyBRYvL82w=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=inria.fr;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=inria.fr policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=inria.fr;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=inria.fr policy.dmarc=none
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 628A780EAD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 13 Oct 2024 22:17:59 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728850679; a=rsa-sha256;
	cv=none;
	b=jR5iXu13mk1i+2JgGsn7muh4BQ6eNT7acLOUq40VwNzaEOh5+d14WmKdpABjjac2+y+oxr
	2wsCaN4eGLEct+9j4IotKSRgZE1PlZoLCmaop9HduGVGY6MbMYvHNl+0lkmaFRFcVLuXzm
	LbjRRHPCggElt7nLlSOUrPBb7IEOJsY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=inria.fr header.s=dc header.b="exIvs+i/";
	dmarc=pass (policy=none) header.from=inria.fr;
	spf=pass (diktynna.open-mesh.org: domain of Julia.Lawall@inria.fr designates
 192.134.164.104 as permitted sender) smtp.mailfrom=Julia.Lawall@inria.fr
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728850679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Sja7FWx2J2pFF7H03F4ldwixL8Qb/r4LwdjP0v1pkNc=;
	b=gB9jlGGT111ZeXu+jsS/jZFQrRHBrvY5du04bkA9SbtJf1wT2nSOK2MYfd7X/WqlHw0L4e
	FbD3gbcZ8mrNRItAHovCZoXY7R3uPeZ9TIHOINV49Z1e8UIPluSS+UAt+GpyA17GFitS0g
	fhRkCalxVDtnY8e3jv5sUrjlIvwJ3lY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sja7FWx2J2pFF7H03F4ldwixL8Qb/r4LwdjP0v1pkNc=;
  b=exIvs+i/vmrrOC1BhG1dWTdYhowcV77JbThYwDdjK0/Wqiaqq9Fr0cce
   rNzCFJlH0Zl3Gc94qiLI1s9PCSVuCYpsLvZjcvp+ULtzzTXbcfRvMqOYM
   ncj7g6L1s1poZOa9BL666TBGtZjDcSWk9IcDnPVvWZAmigUTgCebAcAqC
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,201,1725314400";
   d="scan'208";a="98968275"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 22:17:57 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: linux-nfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	vbabka@suse.cz,
	paulmck@kernel.org,
	Tom Talpey <tom@talpey.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Neil Brown <neilb@suse.de>,
	linux-can@vger.kernel.org,
	bridge@lists.linux.dev,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-block@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH 00/17] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Date: Sun, 13 Oct 2024 22:16:47 +0200
Message-Id: <20241013201704.49576-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: Julia.Lawall@inria.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: DAFV65GIDSCBREDC2UATJOGVAIJFGSVH
X-Message-ID-Hash: DAFV65GIDSCBREDC2UATJOGVAIJFGSVH
X-Mailman-Approved-At: Mon, 14 Oct 2024 08:56:06 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DAFV65GIDSCBREDC2UATJOGVAIJFGSVH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

The changes were done using the following Coccinelle semantic patch.
This semantic patch is designed to ignore cases where the callback
function is used in another way.

// <smpl>
#spatch --all-includes --include-headers

@r@
expression e;
local idexpression e2;
identifier cb,f,g;
position p;
@@

(
call_rcu(...,e2)
|
call_rcu(&e->f,cb@p)
|
call_rcu(&e->f.g,cb@p)
)

@r1@
type T,T1;
identifier x,r.cb;
@@

 cb(...) {
(
   kmem_cache_free(...);
|
   T x = ...;
   kmem_cache_free(...,(T1)x);
|
   T x;
   x = ...;
   kmem_cache_free(...,(T1)x);
)
 }

@s depends on r1@
position p != r.p;
identifier r.cb;
@@

 cb@p

@script:ocaml@
cb << r.cb;
p << s.p;
@@

Printf.eprintf "Other use of %s at %s:%d\n" cb (List.hd p).file (List.hd p).line

@depends on r1 && !s@
expression e;
identifier r.cb,f,g;
position r.p;
@@

(
- call_rcu(&e->f,cb@p)
+ kfree_rcu(e,f)
|
- call_rcu(&e->f.g,cb@p)
+ kfree_rcu(e,f.g)
)

@r1a depends on !s@
type T,T1;
identifier x,r.cb;
@@

- cb(...) {
(
-  kmem_cache_free(...);
|
-  T x = ...;
-  kmem_cache_free(...,(T1)x);
|
-  T x;
-  x = ...;
-  kmem_cache_free(...,(T1)x);
)
- }

@r2 depends on !r1@
identifier r.cb;
@@

cb(...) {
 ...
}

@script:ocaml depends on !r1 && !r2@
cb << r.cb;
@@

Printf.eprintf "need definition for %s\n" cb
// </smpl>

---

 arch/powerpc/kvm/book3s_mmu_hpte.c  |    8 ------
 block/blk-ioc.c                     |    9 ------
 drivers/net/wireguard/allowedips.c  |    9 +-----
 fs/ecryptfs/dentry.c                |    8 ------
 fs/nfsd/nfs4state.c                 |    9 ------
 kernel/time/posix-timers.c          |    9 ------
 net/batman-adv/translation-table.c  |   47 ++----------------------------------
 net/bridge/br_fdb.c                 |    9 ------
 net/can/gw.c                        |   13 ++-------
 net/ipv4/fib_trie.c                 |    8 ------
 net/ipv4/inetpeer.c                 |    9 +-----
 net/ipv6/ip6_fib.c                  |    9 ------
 net/ipv6/xfrm6_tunnel.c             |    8 ------
 net/kcm/kcmsock.c                   |   10 -------
 net/netfilter/nf_conncount.c        |   10 -------
 net/netfilter/nf_conntrack_expect.c |   10 -------
 net/netfilter/xt_hashlimit.c        |    9 ------
 17 files changed, 23 insertions(+), 171 deletions(-)
