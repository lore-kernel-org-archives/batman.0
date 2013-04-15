Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Apr 2013 21:48:09 +0800
References: <20130330131029.GB4024@ritirata.org>
 <1364952313-3163-1-git-send-email-linus.luessing@web.de>
 <20130403081145.GC14372@ritirata.org>
In-Reply-To: <20130403081145.GC14372@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201304152148.09403.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix rcu_barrier() miss
	due to double call_rcu() in TT code
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

On Wednesday, April 03, 2013 16:11:45 Antonio Quartulli wrote:
> > This patch fixes this issue by calling the batadv_orig_node_free_rcu()
> > directly from the rcu callback, removing the unnecessary, additional
> > call_rcu() layer here.
> >
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision c8bda21.

Cheers,
Marek


PS: I did some style adjustments to the patch for the sake of clarity.
