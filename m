Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 2 Aug 2013 12:02:52 +0800
References: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
 <6b7819a6334d21a1a7bd0657ac78bd97@autistici.org>
In-Reply-To: <6b7819a6334d21a1a7bd0657ac78bd97@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201308021202.52272.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 1/2] batman-adv: check return type
	of unicast packet preparations
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <ordex@autistici.org>

On Monday, July 29, 2013 04:14:23 Antonio Quartulli wrote:
> Il 27.07.2013 03:24 Linus L=C3=BCssing ha scritto:
> > batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's
> > data.
>=20
> In next these functions are named a bit differently. I think this can be
> fixed while merging the patch.
>=20
> > And if it tries to do so then this can potentially fail.
> >=20
> > We shouldn't continue working on this skb in such a case.
> >=20
> > Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision d781a70.

Thanks,
Marek
