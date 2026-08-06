Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5AEC55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:45:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4324884255
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:45:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009503;
 b=bjGIqEQc2HVlLwFNjRss5N8QZwCoU+UmpfCSF6b5Ry9efPNeW8N5kEMT6efTo1/RHmQWu
 kWfbdpi1hF/j9lEaAci/Iudv7ob0oHclKkurgY3yWWrtBiGFuYZGewIhJmucwnBwBFM+sdM
 Rxh41uJGsQrTVjJMSCe5cAkUaFP6tNk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009503; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=SkrfB3vAV6HD5leXjKA8ehH9MZtbiJefiz6c/RAu2H4=;
 b=QjxMjzhcV/3d4xbfHE2QlReeel0mf2mrvdwfxxMaF1iAm2tMlmAJK1uhTqK+ifCLOZ0AY
 V2P7PWGIXPyfrx7QTtrHnkSFb/GSfFAyC7odKWudY9KzrhFhsiIL7znSZ3ska0t82mbM9S+
 qxYKeWv78dw36AZ3Jj/KgbxsmtKbUxI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F078F8065C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:44:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009488;
	b=a4yb8aa7Z68FlJLI86O9vbNZ66fVMTgcA30EO8gTw20bCjVBGAiUQwxmrZq7+YSrKBKT6x
	deURKVNmJPCfSDrblhHajv27lDJaspqeM68Kns+9/MXi1RNDhs7zZA5qTmVyNVsfQf7Izr
	Coig9h8vsSNj6niPmSRBxO4KzS9budE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=SkrfB3vAV6HD5leXjKA8ehH9MZtbiJefiz6c/RAu2H4=;
	b=s2ryBnCTzfGz/CmattRAwlDOXkvjiJi5kHXJeVLhWegpyCcUKvabxOQ5lor7022ERbUX/n
	qKmcOwJeFkVj09siwdw9p9gMiKcJRdFsi71SAApJH+etxFjKQezwsbdNY9fjtwYKwdzgJW
	slf/HIeXh7c3bBFocNFJ1tbu7Mujx6g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=r7cwmxP3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C46DD20590;
	Thu, 06 Aug 2026 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SkrfB3vAV6HD5leXjKA8ehH9MZtbiJefiz6c/RAu2H4=;
	b=r7cwmxP3OLDvxRNlkJCd2Aed5SxmnIUQjfCXfch+jRaSyQZPywKz9F0CWG9gy8J2QUnXf/
	Ovx0jcjoqzPt63vXYJPNIZTR7omrdmaeoeSlpV3X8/b/1AbT0+qarAKDrAdBY3RMkH/kuv
	tCAQJbqFEjqEz99ilj3UPOBLxdh+w4M=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC batadv 00/12] batman-adv: tt: refactor
 *_add/batadv_tt_local_remove functions
Date: Thu, 06 Aug 2026 11:44:13 +0200
Message-Id: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1XdGoC/z2PQQ7CIBBFr9LMWhIKFGi3Jh7ArXExwKgYrVpoY
 2K8u7Qal/9P/nuZFyQaIiXoqhcMNMUUb30J9aoCf8L+SCyGkkFwobnlmuXMMATmL4T9eGc1d42
 klnRjHJTRfaBDfC7AHWw367lzmDFMsP+e0+jO5PMM/Q0GeoxFnH+rv7erFquRfLYuWHbwKJwRg
 pwL3aS++ETM367XmLtKaWqtVEZIroK1plFSo5Deu7bVhLW1TfmjRti/3x8lRY7R/QAAAA==
X-Change-ID: 20260806-tt-add-cleanup-10b53e9e657b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2397; i=sven@narfation.org;
 h=from:subject:message-id; bh=kKD8Hof4CHRBufzygwQG2eyIGvxWrhn4i39nCqMbQwk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4U2OheKGErF/5LbEuws7Kpgt43gmzmp8bG6TNc85U
 b66uXs7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABNx42X4Z3NzZ/y7Svm5K8qV
 n81JFp3UNs+1K8BgekVqwJGaD44q+xgZbl8LuDPtSVvjRnn9wDnf7iiu/NGadkBjReX1u2r7E6W
 fcQEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TJDUIPY7LAFVBKKEHQMVMFDLRDL2KYU7
X-Message-ID-Hash: TJDUIPY7LAFVBKKEHQMVMFDLRDL2KYU7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TJDUIPY7LAFVBKKEHQMVMFDLRDL2KYU7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

While workig on the flag protection changes, it became apparent that the
current code is hard to maintain. Too many gotos with large sections which
are hard to cras; because it is unclear how these sections are interact. To
simplify everything, sections which are handling a single task are
extracted in separate functions. This makes it cleared what the input and
output of each "section" are.

I tought about moving this in front of the flag protection changes but I
might end up in an endless "first clean up this other thing over
there"-loop before actually integrating the relevant changes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (12):
      batman-adv: tt: look up wifi state of incoming interface in helper
      batman-adv: tt: extract allocation of new local entries
      batman-adv: tt: replace forward gotos in batadv_tt_local_add()
      batman-adv: tt: extract refresh of existing local entries
      batman-adv: tt: extract update of dynamic client flags
      batman-adv: tt: extract allocation of new global entries
      batman-adv: tt: extract merging of flags into existing global entries
      batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
      batman-adv: tt: extract removal of the superseded local entry
      batman-adv: tt: extract marking of a removed local entry
      batman-adv: tt: extract immediate purge of a local entry
      batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()

 net/batman-adv/translation-table.c | 720 +++++++++++++++++++++++--------------
 1 file changed, 450 insertions(+), 270 deletions(-)
---
base-commit: 46e983472304d8875436a23ccb996ea18856081a
change-id: 20260806-tt-add-cleanup-10b53e9e657b
prerequisite-change-id: 20260730-tt-fixes-fca2b722ebbd:v4
prerequisite-patch-id: 8c512768c6b45c3df367b37240f13c82b9c0b073
prerequisite-patch-id: d6522440ee88ce12d7109c9afe31eae8f0ec7358
prerequisite-patch-id: 659ae36c803f6348748ae4bc34d5b59c54bca267
prerequisite-patch-id: 023ee98093cfa05e842261bf895e5f3b4e38e49a
prerequisite-patch-id: 58431a16185a5819aa0d6e3b57f2d77e83bca755
prerequisite-patch-id: 14b8822e6f82a825b4d5b26d61003c9c4923cd7e
prerequisite-patch-id: 1b1fcf21a580983f652735dfe4bc99ed67ca69dc
prerequisite-patch-id: 7fbb101bc6b6924d631888aae052501ce724ce9f

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

