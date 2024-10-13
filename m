Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72372CF259D
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 06:57:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DB06F82F32
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 08:57:41 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728889061;
 b=fXeP4k3QXr41UQBe2TZx5tQ2+r3RB3pXsUY2WG4HgCDOn6bq6BRFa20qP7u/4CXEBLyKM
 2venyIe2V3kzPqvK+823kqNKsyWEjhBVSkiKS6gSS1VnRwoYg1QEN9ndiudi43Yt29ghzSz
 Zkid6U7eCVudtESd9FjTW6wxnHPgFV8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728889061; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tW/oVLxMGVp293pF30Jw4BkfUNSmxaGcYjy7Hqe9zSo=;
 b=IfJwttj87+psBVeoelkoI+3k0jfuZufvPTtme/oajUk+kg3hi0ODtEoSreiiIPLel6M+R
 dCdIZNHdYdn9jPtSjNUiXPFQP+8DGPYbY9iWwI2kMkv4622TFOOTAFKf/sMlHWdgbzGAF7L
 dGuTdz6oOQyMQiXFu9ZDINAMVJMzLqU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel-dk.20230601.gappssmtp.com;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=kernel-dk.20230601.gappssmtp.com;
 arc=fail (ARC-Seal[1] did not validate); dmarc=none
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 74F278160F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 13 Oct 2024 22:53:34 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728852814; a=rsa-sha256;
	cv=none;
	b=JSiuB3xXaY8Hl9RIvTJuXd5jep0rFqSVx+fUwcRxy7iCHRVT9MAvmyxbhWL05VogndttGI
	HsNxq4Jr81korVEQ1r9erAtBUDgf240eR9xz86okKblNE0aFWhp92+3zVqTQ1zlNpZl5xZ
	egFRLDGhSeXPwUGkZG6eOhrlVobiD8A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel-dk.20230601.gappssmtp.com header.s=20230601
 header.b=Fxt+7qtY;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of axboe@kernel.dk designates
 2607:f8b0:4864:20::42e as permitted sender) smtp.mailfrom=axboe@kernel.dk
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728852814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tW/oVLxMGVp293pF30Jw4BkfUNSmxaGcYjy7Hqe9zSo=;
	b=cEEKFyF2xMB9B8S5wb5d1u32TpyS3iC4VlqN3g6aavJF5K49fRFvpSnChvQ1lJKhRZ4yJR
	oO4q9d3XMWytHl2lturNyQsECCU69pMYuLNNyFjU8S9TIZ+9YX4I+GSuupaMzg6dB9rYh+
	m/jgMvyNqFHfrxX6Bk64xx4pHkENPaw=
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e67d505ceso123864b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 13 Oct 2024 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728852813;
 x=1729457613; darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW/oVLxMGVp293pF30Jw4BkfUNSmxaGcYjy7Hqe9zSo=;
        b=Fxt+7qtYz7rMAXM1qJ7whlJJ8EEAtTS/iabQ4Hr0w87YWvid2vvx4MAvcwWxewYzHn
         /EMwxsu+Eo8sqnG5Pn1r9L5nn6E+UWJYtJ5IvRx8FKwHGkIjtFDm8fllkL22igZW6Nb9
         04vWTWdinFFj1ENj/2n1ms32zJXGMzEGnigEOGgGxT7Dqe1fkfNNEFCqPuvALxuQEM+h
         Rbo1Gn958KURVjoTz6dpfHmXfzDh5Mps5yZ+1qEH7gkqzkbIwrq3gIJp1KSgmISgCRHQ
         /cGVIHH5pD1hmJVqrE8pAFslCTUDW+G8yhps+2TEiLPks5Fh5N3VlnFLIfBxygTJWeTO
         5sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728852813; x=1729457613;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW/oVLxMGVp293pF30Jw4BkfUNSmxaGcYjy7Hqe9zSo=;
        b=cnT/hsSpVh+cUYsN4MASLVvrY3mw5+pfK6OPDTFrMv2glcPr86mmSjN52PfG96rLCG
         Uz9lCSDc2lvabdU49QJ6235GNwwK8KwNi2H2POgyxEbiWw+RcvgoNfCANm4zDkX7S3qx
         BA85qYxO4K3nabKuW3H3D4b7FKRLZOKmuWus0cs56l2Zx8HvwhIdAkdahBfMG0xSIGuD
         lA/VlPJTSZDAEngMOF92M1hU9GBj9X8RA+kLLjQOHqZ1PEr9LyQEHdmYbemWhykUEOpr
         /dpq9Hv/T5q6xb9i0W1nNDylBO9YqgH3Sq4CNq7gmT5trm5/L2JhFdHGEqrIJ9mKq7Zl
         4Cvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAepUVkuevfvPDA2jiSr9gGSJ8kgyMpWg6QW0xY/bGz4IPJTbYk8s01Br5e9ukc/L8QntQG0jVMguoBw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyemOIcwS5IBvjWWvjJLGBjd8s6jrVZqqsGY3jtzuw5vSyejI4H
	3axqCMHbp384N17sZRHDkFOpFk55PeSavUowrVMDsQO1iUFvr6sgcJKeTIZFQsE=
X-Google-Smtp-Source: 
 AGHT+IGeHW/T1utnJaL2THMthWNT/SlEE9KTreIWsQr33pvF5db22afBNXHDL1azWfd6tDGW/vbLCA==
X-Received: by 2002:a05:6a00:1391:b0:71e:ba5:820e with SMTP id
 d2e1a72fcca58-71e4c1dcd95mr9404250b3a.27.1728852812746;
        Sun, 13 Oct 2024 13:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e48bcfe81sm3815287b3a.66.2024.10.13.13.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 13:53:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-nfs@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, vbabka@suse.cz, paulmck@kernel.org,
 Tom Talpey <tom@talpey.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Olga Kornievskaia <okorniev@redhat.com>, Neil Brown <neilb@suse.de>,
 linux-can@vger.kernel.org, bridge@lists.linux.dev,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-block@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/17] replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Message-Id: <172885281086.338120.2063739137198887833.b4-ty@kernel.dk>
Date: Sun, 13 Oct 2024 14:53:30 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-MailFrom: axboe@kernel.dk
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: X2X5GN37MRRZYBIRU26WLHHKX6III4O4
X-Message-ID-Hash: X2X5GN37MRRZYBIRU26WLHHKX6III4O4
X-Mailman-Approved-At: Mon, 14 Oct 2024 08:56:06 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/X2X5GN37MRRZYBIRU26WLHHKX6III4O4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>


On Sun, 13 Oct 2024 22:16:47 +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.
> 
> [...]

Applied, thanks!

[09/17] block: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
        commit: 7a9b197adbafa9d6d1a79a0633607b78b1adef82

Best regards,
-- 
Jens Axboe



