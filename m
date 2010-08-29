Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 Aug 2010 02:02:42 +0200
References: <1282510400-10341-1-git-send-email-linus.luessing@web.de>
	<1282510400-10341-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1282510400-10341-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201008290202.42698.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't rely on NF_HOOKs
	return value
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Vasiliy Kulikov <segooon@gmail.com>

On Sunday 22 August 2010 22:53:20 Linus L=C3=BCssing wrote:
> If a hook returns NF_STOLEN, neither batman_skb_recv nor
> batman_skb_recv_finish free the skb due to the asynchronous netfilter
> handling in the kernel. Therefore not batman_skb_recv but the ok
> function batman_skb_recv_finish should do the freeing when a recv
> subfunction returns NET_RX_DROP instead.
>=20
> Reported-by: Vasiliy Kulikov <segooon@gmail.com>
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Patch has been applied (rev. 1780).

Thanks,
Marek
