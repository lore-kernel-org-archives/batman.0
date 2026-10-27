Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE786606A31A
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNGRAl9G
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 89429858EE
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 10:02:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793091766;
 b=qZx8SBUi4voO2b4m3Pi66pqGP0n50Pjr0iCERS7wNWq+glRgsYzewUQucE/1XmMWLZwVb
 aAheSyb6Bn4c8QkU5uFUrrFwpK0RLazjp+r47KNX/0ompBcXXjQNfjFF3XLPLfcSrdgsz7R
 oh5mU/Oeo56RVJ8zifcI6/3HCbfkq0w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793091766; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vFE78Mt/RT5W0a8LHAY83nSeo9T+I0JI1DQ+N1in6PI=;
 b=TbkLniUyyu+69PiWigyofwSzWzyCCJ33khqMFTlxAfL/kmou/X9p7j4vAS5NzvACtdJob
 raMU1caO3F5nWFtteQCM240UZ46yYki83ihItWWnV1afnGxW1c6BEImIG7PBhI4IuhFMP1h
 8K7qCThfIQ3x4EBA+6Q3uJ4OgHAmUYA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E6B0E8195D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 09:55:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793091336;
	b=jWlQWXH9kJ4uGVq6tjTx4Im2EkwpQixEe42ILQJqKJKy+hbyRsMvx5YLUeqCwvJP8y8Keh
	h+RxUV0570JE/kyierNORSUBbsxkr+L92h73RwWeI2ivCMtduBVb6GZsh2+cUUtF9PNuuA
	VNhDGOThRRlGqtQ6izE0fkbMfICwr5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793091336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vFE78Mt/RT5W0a8LHAY83nSeo9T+I0JI1DQ+N1in6PI=;
	b=zpSlw+oM9kDxlLg896VUXtETRn6UBwROeo4jUEFIaOzGYL4vtuwpb9K4WzyXfJe8TieEXd
	jVC2Jqs66BwBOzpmg0aUjqqMp09cOaCuWuGgdKbFscp6qOECex3k46j+2FdkGz1CaFE6GE
	wBaUzWIQgpo4BBVRz0fYcObMmee02VM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WNGRAl9G;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.234.252.31 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9137143848;
	Tue, 27 Oct 2026 08:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60F91F01828;
	Tue, 27 Oct 2026 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091323;
	bh=vFE78Mt/RT5W0a8LHAY83nSeo9T+I0JI1DQ+N1in6PI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WNGRAl9Gd0g1s15kSqpVJRpYgTPn7+MFJUq1xqRJScXXnTquyRYh+JmMb/4aRn/KO
	 En85SvqTAJwXjGswzKlezVeHAY15G4RdXgSRPU3urQacquTurGoLI/MKdgnFqOcYJF
	 b2MWyeU4V43Vrz4FbFcpjI1LNJzF2Zu76RXqiv0dL4Hggi/g75JfGl9GIVYURUGU9l
	 YmC/V49GQPx5BigOyvER+WZ7qwJSIrjh4/6Nhbymq/PICAsC5OEiheBuoq122hyUiG
	 +cLOdNQSYf2XCoCe2CYeQOSw6AcW07ia0eWaOO3kpjsTQybtO8pdgxJL5oJuHJ4ASD
	 VLdrHtT4+esag==
Subject: Re: [PATCH net 07/10] batman-adv: tt: only transmit local ROAM flag
 together with DEL
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Tue, 27 Oct 2026 08:55:22 +0000
Message-ID: <179309132249.3134.16887364336514212941@kernel.org>
In-Reply-To: <20261026085309.1074911-8-sw@simonwunderlich.de>
References: <20261026085309.1074911-8-sw@simonwunderlich.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: I6ZT4YE3A2U44ODAEXIID742CXQ5SYMO
X-Message-ID-Hash: I6ZT4YE3A2U44ODAEXIID742CXQ5SYMO
X-Mailman-Approved-At: Tue, 27 Oct 2026 10:02:02 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I6ZT4YE3A2U44ODAEXIID742CXQ5SYMO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix leaves the requester-side client drop in place even
  though the commit message lists it as a symptom, and the message…

--

batman-adv: tt: only transmit local ROAM flag together with DEL

This patch stops local TT entries from sending BATADV_TT_CLIENT_ROAM
unless it comes with BATADV_TT_CLIENT_DEL. The ROAM bit is now cleared
for non-DEL events in __batadv_tt_local_event() and for full table
responses in batadv_tt_local_valid(). The goal is to stop receivers from
treating a plain ADD as a roaming advertisement.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 3349376a9087d..39b61426f1680 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

[ ... ]

> @@ -3342,8 +3350,12 @@ static bool batadv_tt_local_valid(void *entry_ptr,
>  	if (tt_flags & BATADV_TT_CLIENT_NEW)
>  		return false;
>  
> +	/* the entry is (still) announced. A ROAM flag of an entry which is
> +	 * pending to be removed must not be transmitted. Otherwise, the
> +	 * receiver would handle it like a roaming advertisement
> +	 */
>  	if (flags)
> -		*flags = tt_flags;
> +		*flags = tt_flags & ~BATADV_TT_CLIENT_ROAM;
>  
>  	return true;
>  }

[Severity: Medium]

Does this fix the requester-side symptom described in the commit
message? The commit message says:

  When the requester is the node which sent the ROAMING_ADV, it then
  marks its own (new) local client as roamed back to the old originator
  and drops it when it is still NEW.

After this change, batadv_tt_local_valid() still reports an entry that
batadv_tt_local_mark_removed() marked ROAM|PENDING as valid. It only
clears the ROAM bit. So the entry still goes out as a plain ADD in the
full table response built by batadv_send_my_tt_response().

Take node B, which sent the ROAMING_ADV for client C to the old
originator A. B gets A's full table response before A's next TT commit:

batadv_tt_fill_gtable()
  batadv_tt_global_del_orig(bat_priv, orig_node, -1, "Received full table")
    /* removes B's ROAM-marked global entry for C if A was the only orig */
  _batadv_tt_update_changes()
    batadv_tt_global_add(..., flags without ROAM, ...)
      out_remove:
      batadv_tt_global_purge_local(bat_priv, tt_global_entry, flags)
        batadv_tt_local_remove(..., flags & BATADV_TT_CLIENT_ROAM) /* false */
          batadv_tt_local_mark_removed()
              if (common->flags & BATADV_TT_CLIENT_NEW)
                  break;
          batadv_tt_local_remove_now()

The NEW check in batadv_tt_local_mark_removed() does not depend on
roaming. B's newly roamed-in local entry for C is therefore still
removed right away by batadv_tt_local_remove_now(). If the entry was
already committed, a DEL is queued instead. B's global table then
points C at A.

On A, the local entry for C is ROAM|PENDING, so batadv_is_my_client()
returns false there as well. Would traffic for C then be disrupted
until C sends another frame through B and batadv_tt_local_add()
recreates the entry?

The first bullet list in the commit message also has a related
statement:

  * batadv_tt_global_purge_local() removes a local entry of the receiver

It is listed there as an effect of an ADD carrying ROAM. However,
batadv_tt_global_add() reaches out_remove and calls
batadv_tt_global_purge_local() on every successful non-multicast global
add, whether or not ROAM is set. ROAM only selects the roaming argument
passed to batadv_tt_local_remove().

Is more needed to keep B from dropping its local client in this case?
If not, should the commit message say that this patch only fixes the
ROAM marking of the global entry and the resulting CRC mismatch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026085309.1074911-2-sw%40simonwunderlich.de
