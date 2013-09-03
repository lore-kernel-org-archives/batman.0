Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 3 Sep 2013 17:00:00 +0800
References: <1378116909-551-1-git-send-email-ordex@autistici.org>
 <1378116909-551-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1378116909-551-9-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201309031700.00566.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv7 8/9] batman-adv: provide orig_node
	routing API
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

On Monday, September 02, 2013 18:15:08 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Some operations executed on an orig_node depends on the
> current routing algorithm being used. To easily make this
> mechanism routing algorithm agnostic add a orig_node
> specific API that each algorithm can populate with its own
> routines.
>=20
> Such routines are then invoked by the code when needed,
> without knowing which routing algorithm is currently in use
>=20
> With this patch 3 API functions are added:
> - orig_free (to free routing depending internal structs)
> - orig_add_if (to change the inner state of an orig_node
>   when a new hard interface is added)
> - orig_del_if (to change the inner state of an orig_node
>   when an hard interface is removed)

Please look into this warning:
  CC [M]  /home/marek/batman-adv/originator.o
/home/marek/batman-adv/originator.c:578:12: warning: =E2=80=98batadv_orig_n=
ode_del_if=E2=80=99 defined but not used [-Wunused-function]

Cheers,
Marek
