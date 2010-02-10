Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 10 Feb 2010 18:47:49 +0800
References: <20100208205602.GA9369@Sellars> <20100208213212.GA9389@Sellars>
	<20100210023641.GA2112@Linus-Debian>
In-Reply-To: <20100210023641.GA2112@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201002101847.49306.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use original printk in
	bat_printk
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

On Wednesday 10 February 2010 10:36:41 Linus L=C3=BCssing wrote:
> bat_printk is calling a printk which got previously
> substituted because of the define in compat.h.
> This patch removes the define for the scope of
> bat_printk.c.

After seeing your patch I understand the issue. We redefine printk() to=20
bat_printk() which works fine for all functions except for bat_printk() its=
elf.
I think your approach seems to be a solution although we don't need to defi=
ne=20
printk at the end again, do we ?

Regards,
Marek
