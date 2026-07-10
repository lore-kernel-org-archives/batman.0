Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F2AC44501
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 17:57:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 98CDB83EC5
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 19:57:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783706242;
 b=Dha0YolrlPOgU2xAGfh+ndmXIbx68i6LULZ2JON7o79p6KFrcKGmzfHBEVvfNkfFMnpb4
 4Dq5fmnSOy+UqeOpSItyoyRO3DJj7xiNG6tKnh6RBZ/tqnhLOT6jN6Cu4S2ACOlAAWq3fFh
 6jwdu22SMXYiwCvIqMmim0/a76lRyiM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783706242; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ritIdVLzbj6jGCexJmHL4fv3M9Of1DhbmY1pu2yQQGU=;
 b=sHeR04ju+NPednJqjI6KGk9zt8Hqzk61G/frw8vC/0fBuloSTV1rtIE8CY9LwhalojOM0
 9x52Nb+la5n3EMLXceDl/aT+8Z6WqX2gJ8xSa9lgoLJtkjg4hS7Jl4N0GK5ImJ1RclEH+jk
 nrisUDHAOYUVakNMOJA6mkNwSDL8nRw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F304C80A43
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jul 2026 19:56:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783706214;
	b=KVPpDn6nowB/c/frTDVSTitfIxJxTEk6p+i34JPtEVgGmJywiX5PULmU01BG22+/PAJ+Ko
	GFvDetngqvYdOxB5uIUsgQug8+PTGJzql/cU8FBKDvL6HNkjfEOkbswrjPEUVnnYQyU8HA
	gP4LMOhf8dSsbYkdc1a8zQA9khH3BXY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783706214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ritIdVLzbj6jGCexJmHL4fv3M9Of1DhbmY1pu2yQQGU=;
	b=UZWpRfseqhApjF/HzN6uZzOAr6DUVI+vmvHncITPOsqxdPC1ALIgZA9zQ7l3xmnbIKxjmM
	zZsUZgwKW3xVW3wkI7rvYHhqsfxF+RA/nJn6EZUQD3xOCJyh5leY+Mx1BHmOsCFtbniVNx
	El0M7woZYN1TKIt1YSERcL07NsTfJeA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xgLp0G6K;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E8B941FEF7;
	Fri, 10 Jul 2026 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783706212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ritIdVLzbj6jGCexJmHL4fv3M9Of1DhbmY1pu2yQQGU=;
	b=xgLp0G6KISG8/9EskNJLZ6u7J+8YiO7e0cS7QaHyewhvJ5GQT0BVQhdS0+NVqkQ6/OqDlt
	cUR2MAcCgtsoNx12pHk23L3op/TycLPuS3kIhl5F8iTYx8/o91mhROYZqFZPRJKdfXuglv
	W4sklEtt6OWJyHfS1/Vd5FxhBPJ7N04=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Ibrahim Hashimov <security@auditcode.ai>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] batman-adv: bound BLA claim and backbone gateway
 table growth
Date: Fri, 10 Jul 2026 19:56:41 +0200
Message-ID: <9098133.T7Z3S40VBb@sven-desktop>
In-Reply-To: <20260710165224.39411-1-security@auditcode.ai>
References: <20260710165224.39411-1-security@auditcode.ai>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11273385.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: GOWHCYIRDMPZA3JPGCCW2TU35L2BXP35
X-Message-ID-Hash: GOWHCYIRDMPZA3JPGCCW2TU35L2BXP35
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GOWHCYIRDMPZA3JPGCCW2TU35L2BXP35/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart11273385.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 19:56:41 +0200
Message-ID: <9098133.T7Z3S40VBb@sven-desktop>
In-Reply-To: <20260710165224.39411-1-security@auditcode.ai>
References: <20260710165224.39411-1-security@auditcode.ai>
MIME-Version: 1.0

On Friday, 10 July 2026 18:52:24 CEST Ibrahim Hashimov wrote:
> batadv_bla_add_claim() and batadv_bla_get_backbone_gw() each kzalloc a
> new hash entry (struct batadv_bla_claim / struct batadv_bla_backbone_gw)
> for every distinct (mac, vid) / (orig, vid) pair carried in a
> BLA-group-conforming CLAIM frame, and insert it into
> bat_priv->bla.claim_hash / backbone_hash. There is no maximum-entry
> cap on either table -- entries are only ever removed by the
> timeout-driven periodic purge (batadv_bla_purge_claims() /
> batadv_bla_purge_backbone_gw(), BATADV_BLA_CLAIM_TIMEOUT /
> BATADV_BLA_BACKBONE_TIMEOUT, on the order of 100 s).
> 
> The BLA group a frame must carry is htons(crc16(primary_hardif_mac)),
> which is trivially observable/derivable by any node already on the
> mesh soft-interface (batadv_check_claim_group()). A single on-mesh
> sender can therefore emit CLAIM frames with an incrementing source MAC
> and force one kzalloc(GFP_ATOMIC) per frame on both hot paths, growing
> kernel memory without bound for as long as the attacker keeps sending
> -- uncontrolled resource allocation. Both allocations are
> GFP_ATOMIC with a NULL check, so this is a graceful memory-pressure
> DoS, not a crash: there is no OOB access.
> 
> batman-adv already has an established pattern for capping an
> attacker-/peer-influenced, unbounded-growth per-mesh-interface
> resource: the TP-meter session list bounds concurrent sessions with a
> fixed ceiling and an atomic_add_unless() admission check that rejects
> new allocations once the cap is hit, logging and freeing/decrementing
> on the abort path (net/batman-adv/tp_meter.c, BATADV_TP_MAX_NUM,
> bat_priv->tp_num, "Meter: too many ongoing sessions, aborting").
> 
> Apply the same pattern to BLA: add two atomic_t counters,
> bat_priv->bla.num_claims and bat_priv->bla.num_backbone_gws, each
> capped at a new BATADV_BLA_MAX_CLAIMS / BATADV_BLA_MAX_BACKBONE_GW
> limit (4096 / 256 -- generous for any real bridged LAN/VLAN
> population, several orders of magnitude below what would need to be
> sprayed to threaten memory availability). batadv_bla_add_claim() and
> batadv_bla_get_backbone_gw() reserve a slot with atomic_add_unless()
> before allocating; on cap-hit the frame is dropped (matching existing
> "drop silently, let the sender resync/backoff" BLA behaviour) instead
> of allocating. The reservation is released on every existing early-out
> (kzalloc failure, hash_add failure) and in the kref release paths
> (batadv_claim_release(), batadv_backbone_gw_release()), where the
> counters are decremented right before the objects are freed. No
> locking changes are needed: the counters are only ever touched via
> atomic ops, mirroring tp_num.
> 
> This does not change on-the-wire behaviour, hash table sizing, or
> timeout-based purging; it only stops a single on-mesh peer from
> growing the tables past a bounded ceiling.
> 
> Verified by code review rather than by driving either counter to its
> cap at runtime: the atomic_add_unless()/atomic_dec() pairing was
> checked against every existing early-out (kzalloc failure, hash_add
> failure) and against both kref release callbacks, confirming exactly
> one reservation and one release per entry, mirroring the same
> tp_num accounting in tp_meter.c. A loopback CLAIM-frame reproducer
> was used earlier to confirm the pre-fix unbounded growth itself
> (distinct claim_hash/backbone_hash entries scale linearly with the
> number of distinct (mac, vid) pairs sent), but reaching the new
> 4096 / 256 caps with that same reproducer is impractical: entries
> age out via the existing timeout-driven purge faster than a
> single-host reproducer can accumulate enough distinct pairs to hit
> the ceiling, so the cap-hit and slot-release paths were exercised
> by inspection, not by a live saturation run.
> 
> Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 38 ++++++++++++++++++++++++--
>  net/batman-adv/main.h                  |  3 ++
>  net/batman-adv/types.h                 |  6 ++++
>  3 files changed, 45 insertions(+), 2 deletions(-)


Consider this rejected:

* the target tree should be batadv and not "net"
* patch doesn't even apply to batadv.git

  $ git am 20260710165224.39411-1-security@auditcode.ai.mbx
  Applying: batman-adv: bound BLA claim and backbone gateway table growth
  error: patch failed: net/batman-adv/bridge_loop_avoidance.c:179
  error: net/batman-adv/bridge_loop_avoidance.c: patch does not apply
  Patch failed at 0001 batman-adv: bound BLA claim and backbone gateway table growth
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  hint: When you have resolved this problem, run "git am --continue".
  hint: If you prefer to skip this patch, run "git am --skip" instead.
  hint: To restore the original branch and stop patching, run "git am --abort".
  hint: Disable this message with "git config advice.mergeConflict false"

* there are already patches for these for review [1]
* breaks existing setups and doesn't allow users to adjust limits according to 
  their requirements
* own backbones must never be prevented
* I start to get tired by all these overlong AI generated patch summaries 
  which meander around completely irrelevant detail information - or 
  information which are not even relevant here

Regards,
	Sven

[1] https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?series=726
    https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=b4/resource-limit
--nextPart11273385.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCalEyWQAKCRBND3cr0xT1
yzCaAP9HyxUvpnN5Dwp5ZjnKHA/sfcJNIx4NLUj6XfqoSrg8QwD+J/iCM0F11StK
uhvihT1OUCtBXnK6/uWK8K+TVALj1w0=
=MqzO
-----END PGP SIGNATURE-----

--nextPart11273385.nUPlyArG6x--



