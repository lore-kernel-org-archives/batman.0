Return-Path: <gwirth79@gmail.com>
Message-ID: <4B8AAC3F.3020509@gmail.com>
Date: Sun, 28 Feb 2010 09:47:43 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert multiple /proc
 files	to use sysfs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 02/27/2010 12:30 PM, Marek Lindner wrote:
> This is the first patch in a series of patches which aim to convert
> all batman-adv /proc files to sysfs. To keep the changes in a
> digestable size it has been split up into smaller chunks. During
> the transition period batman-adv will use /proc as well as sysfs.

[snip]


> index 0000000..9502cf6
> --- /dev/null
> +++ b/batman-adv-kernelland/bat_sysfs.c
> @@ -0,0 +1,318 @@
> +/*
> + * Copyright (C) 20010 B.A.T.M.A.N. contributors:
                      ^

I know you're looking toward the future but isn't 20000 years a bit much?

Gus
