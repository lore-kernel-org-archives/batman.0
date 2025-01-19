Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E02BC02187
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 23:04:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A7D5084213
	for <batman-adv@archiver.kernel.org>; Mon, 20 Jan 2025 00:04:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737327851;
 b=YWQA0PKEp9fr7xvDimRLViO3jlVr04H+PFur6eQNdB6yQvmjT11//1j1ksOgQIHjlGypS
 6fhB0nOI/6zvsqcdHcC/ozHgQYVG3ZvuW4fQ5/7g1IJCg3w4hxcpiTZJYHxJfT5APZd6uFT
 +JW7fhcDgvmmRHpKJRGxqhs+xe/vwxE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737327851; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aJnU6Gy1t33dX8pg3wXjgIYXA9UvwDilPdyoyry70L0=;
 b=SFVb3FypqcFmGL1L6gXqsTUjPWLRUzpBAk5alXM7DHf5MsoV+qcmaKfBln2nZnrJJGGNR
 eOaloAQIL4VWZiS8sapomU2W+8v+yq3epJ9Z5qWu+lZgZ06itL/b6lxY3HoERy23DnKGB9G
 u13rohC3PeVI84hqsRWxmC7j8+nxJe0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com; arc=pass;
 dmarc=none
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 66602826CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 19 Jan 2025 23:28:28 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737325708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aJnU6Gy1t33dX8pg3wXjgIYXA9UvwDilPdyoyry70L0=;
	b=cYT6rwIjv25KtMBomCca8ixogeT6ak3C+O+0YkUtyq/RrxZlfT3EXSJX0eicU14Hti6zui
	ptPwCPZL+3C+eH62iHuSIhfzWMMeqdfIi6zonxefgb5MxRmE2nvkraUZiLC0xiH6ypQO1e
	4kOJTiwc8bRwY6g/aPTKP6pVLhGnmFk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=andrewstrohman-com.20230601.gappssmtp.com
 header.s=20230601 header.b=NHvuZ0ly;
	spf=none (diktynna.open-mesh.org: domain of andrew@andrewstrohman.com has no
 SPF policy when checking 2607:f8b0:4864:20::b2a)
 smtp.mailfrom=andrew@andrewstrohman.com;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737325708; a=rsa-sha256;
	cv=none;
	b=3t4ia+MgG/pwifZS42j2JksCG5rGTzGK+JJ0xrLUfkHJDkFrah7pjBFdvn9dom2NOZ82tT
	A4QoD5Ufttd6PTAvEnb5k4qNZaFPcBpwW/chYMmPqpaLjnX0RVXJADk2gu7q6tcbgpM9Jj
	S28K0GzFqfhCPgZFV4Ne6ZmkMXNzy78=
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so5803104276.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 19 Jan 2025 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrewstrohman-com.20230601.gappssmtp.com; s=20230601; t=1737325707;
 x=1737930507; darn=lists.open-mesh.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJnU6Gy1t33dX8pg3wXjgIYXA9UvwDilPdyoyry70L0=;
        b=NHvuZ0lyiv/G7emNJOdmZk4vdILEXp6rXqxC8gojQVyYqUj8x9nHEFOp7IWDAlGF7b
         KuBWYh5dXWxF4iswYq3+Un6hCSCXUDxVM8btIFIQ+gBXyNyR0xrcfaAqQp0OTpaNJoqC
         57Dfqu0f2gH+sOzi2xaAgSqv4hrsxbU85YHb5qCqLF77uFysyGcIFK/YN7j/PEl+TzOP
         jyf475vM9XflWbZK2VKgEzoRqz5VT9cBonynCUIU7BQvA0I9ffmidcm7mpZ/OzJKDNnd
         SEbP2mBpnqh/1XJgUNLJnT7gSiQ3IN+66qEN/AqUBsR2AIiudBSIWhfRswgAMuSAn0M4
         47QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737325707; x=1737930507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJnU6Gy1t33dX8pg3wXjgIYXA9UvwDilPdyoyry70L0=;
        b=Ipp/7SN2iOg9hRH+Pupuca0WBsWqV0HJwnb/fEG2rcDcKNbmGunSLNw3x3w8GankyM
         KSQdSyw1hTOLjVyaxT6NB6PlgFNXcXzv4AHtktsSGAxHhBo+nvmQa+wD4OQbeEA/lSy+
         YbIjQP1YqbjaESDGPI4erjJaWur3baoqoAciUWZ3OEQRWGzFBsq3A9ywCyUrOtVwnybc
         685SqDOPVMkfpZBkcCGPApnnp3xt9ITnR7TQ5Ajrfr8NeQHMskItYodI2GKJc+B9coBA
         +syHhXXxb8ljoDRZob7J2WqBbX44aKusfDedECzaeHPh7k8OS4RGhbG7rVZfZ/RuEICE
         cnaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfDFIToBLavvnF3i6KN4uToTOaTRohbuX5gG4f2EaMqQgxTUpUvgb24FBliInnEu+11tD/+Dhcm751Q==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxmcsRhhlM5xQn/LNhM10Tde+7YKg6SQLfv0ELdKjw9kx2xVOTC
	xNx26mylk7PQ8cvm0YDIfrJ+41sb1XxB3zq1dZehk9gq1/nhuZpyr5tAUJ7BGVK65c9Wq9dOVAj
	UH4tSELTsDl0QL1tkTESMRYy0BVqWdEQpWdWvjSpfbNMZB03C
X-Gm-Gg: ASbGncvkIalo6P8yIBlT7W6CaxJKlDHSorLZxi9VIdXgNnv/mW6S7lp4aSQuA9TiOj7
	W6xSkASzgi6lCG8tMafqjR8+k0zQyGCYCfLNw/+9Z5muzeftPRmQ=
X-Google-Smtp-Source: 
 AGHT+IEneeNL9rM5vBxqbMuYYJTbm5F9rU00IHtpKQuEEBqgklrtTmUJiqD0j5/OZA8q5Y9opbSBmloQCtHgrXd2Aoo=
X-Received: by 2002:a05:690c:6c83:b0:6ef:4696:f1d0 with SMTP id
 00721157ae682-6f6eb67bcadmr84273257b3.12.1737325707264; Sun, 19 Jan 2025
 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20250109022756.1138030-1-andrew@andrewstrohman.com>
 <1882889.atdPhlSkOF@ripper>
 <CAA8ajJkhd=CaNoqZ+juKHh8PV975s_vEfLU4xLfwn-Yj+caEPg@mail.gmail.com>
 <5533653.Sb9uPGUboI@ripper>
 <CAA8ajJnVQWO3fhLAjQtEfjEVReY7x-==TEkhrKQKZMrVJms44w@mail.gmail.com>
 <Z4EcPQOMU1BUtO07@pilgrim>
 <CAA8ajJ=etpv--YNTww2uuYvNnoe2tCSNqas2cVLdZodHnqZb_g@mail.gmail.com>
In-Reply-To: 
 <CAA8ajJ=etpv--YNTww2uuYvNnoe2tCSNqas2cVLdZodHnqZb_g@mail.gmail.com>
From: Andrew Strohman <andrew@andrewstrohman.com>
Date: Sun, 19 Jan 2025 14:28:16 -0800
X-Gm-Features: AbW1kvZnDIF_x96s1T5e0gPfjH5fgHNq1Z8SzL2o7Xc9kQs92WAvyX8U6wJ6L1o
Message-ID: 
 <CAA8ajJkYga+UaUWiunwuzaVTmtz8ix_gYnq7Y4KUcNLn==WLTA@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
To: Remi Pommarel <repk@triplefau.lt>
Cc: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: andrew@andrewstrohman.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: ZO7MDEQ4LFCBLXK433GDRDFZOUWHPCM6
X-Message-ID-Hash: ZO7MDEQ4LFCBLXK433GDRDFZOUWHPCM6
X-Mailman-Approved-At: Mon, 20 Jan 2025 00:03:32 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZO7MDEQ4LFCBLXK433GDRDFZOUWHPCM6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I just received a notification from patchwork that
this patch was accepted.

This version of the patch does not address
Sven's comments.

This first version also does not address the concern
that I found after submitting the patch, which is
that the soft interface netdev can be destroyed
before this work finishes. This
less likely race can lead to a similar problem,
so I don't feel like this is the right solution.

Please withdraw this patch.

I've decided to move on to other things,
so if someone else wants to pick
this up, please feel free.

Thanks,

Andy
