Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Sep 2012 16:44:28 +0800
References: <1346703631-17948-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1346703631-17948-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201209091644.28521.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: make batadv_test_bit()
	return 0 or 1 only
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Tuesday, September 04, 2012 04:20:31 Linus L=C3=BCssing wrote:
> On some architectures test_bit() can return other values than 0 or 1:
>=20
> With a generic x86 OpenWrt image in a kvm setup (batadv_)test_bit()
> frequently returns -1 for me, leading to batadv_iv_ogm_update_seqnos()
> wrongly signaling a protected seqno window.
>=20
> This patch tries to fix this issue by making batadv_test_bit() return 0
> or 1 only.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  bitarray.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied in revision bf73b14.

Thanks,
Marek
