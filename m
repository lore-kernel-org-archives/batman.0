Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 10 Oct 2010 14:42:08 +0200
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286685001-15227-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010101442.08908.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Introduce generic
	BAT_ATTR_* macros
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

On Sunday 10 October 2010 06:29:58 Linus L=C3=BCssing wrote:
> Additionally, the sysfs entries "aggregate_ogms" and "fragmentation"
> get renamed to "aggregation" and "frag" for consistency reasons, they
> match the *_enabled parts in bat_priv now.

I don't quite understand why you want to rename these names. I like the=20
"aggregate_ogms" as it makes clear what is being aggregated.=20

Please keep in mind that the kernel people won't be happy if we modify the=
=20
user space API. Right now, it is less of an issue but once we leave the=20
staging tree it is mostly unchangeable.

Regards,
Marek
