Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Oct 2010 11:56:21 +0200
References: <1286717891-17091-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286717891-17091-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010121156.21447.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix wrongly formatted %pM in
	bat_dbg()
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

On Sunday 10 October 2010 15:38:11 Linus L=C3=BCssing wrote:
> bat_dbg() invokes debug_log() which invokes the kernel's vscnprintf(),
> which invokes the kernel's vsnprintf(), and not the customized
> bat_vsnprintf(), which backports the %pM to older kernel versions!
>=20
> Therefore this commit ports a customized vscnprintf() to bat_printk.c,
> too, making mac addresses being displayed correctly with bat_dbg()
> again.

Applied in revision 1825.

Thanks,
Marek
