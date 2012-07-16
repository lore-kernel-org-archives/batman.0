Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 16 Jul 2012 11:58:36 +0200
References: <1341480868-25908-1-git-send-email-martin@hundeboll.net>
 <1341480868-25908-2-git-send-email-martin@hundeboll.net>
In-Reply-To: <1341480868-25908-2-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201207161158.37207.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Drop tt queries with
	foreign dest
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

On Thursday, July 05, 2012 11:34:28 Martin Hundeb=C3=B8ll wrote:
> When enabling promiscuous mode, tt queries for other hosts might be
> received. Before this patch, "foreign" tt queries were processed like
> any other query and thus forwarded to its destination again and thereby
> causing a loop.
>=20
> This patch adds a check to drop foreign tt queries.
>=20
> Signed-off-by: Martin Hundeb=C3=B8ll <martin@hundeboll.net>
> ---
>  routing.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)

Applied in revision 2b7b639.

Thanks,
Marek
