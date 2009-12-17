Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 18 Dec 2009 06:24:05 +0800
References: <20091217190433.GA3960@Linus-Debian>
In-Reply-To: <20091217190433.GA3960@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200912180624.06029.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixes rounding issues in
	vis.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Friday 18 December 2009 03:04:33 Linus L=C3=BCssing wrote:
> This patches fixes two rounding issues in vis.c for sending and
> purging vis packets. Before, the timers and timeouts always got
> rounded down to seconds, though we want a precision in
> milliseconds.
> This also fixes a kernel panic that occures when lowering the
> timer for sending vis packets (vis_interval) to less than 1000ms
> in main.c manually.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Thanks - applied in revision 1506.

Regards,
Marek
