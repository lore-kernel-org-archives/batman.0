Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 Aug 2012 23:42:46 +0200
References: <1345418559-27150-1-git-send-email-sven@narfation.org>
 <1345446239-5115-1-git-send-email-sven@narfation.org>
In-Reply-To: <1345446239-5115-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201208242342.46630.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Set special lockdep
	classes to avoid lockdep warning
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

On Monday, August 20, 2012 09:03:59 Sven Eckelmann wrote:
> Transmissions over batman-adv devices always start another nested
> transmission over devices attached to the batman-adv interface. These
> devices usually use the ethernet lockdep class for the tx_queue lock which
> is also set by default for all batman-adv devices. Lockdep will detect a
> nested locking attempt of two locks with the same class and warn about a
> possible deadlock.
>=20
> This is the default and expected behavior and should not alarm the locking
> correctness prove mechanism. Therefore, the locks for all netdevice
> specific tx queues get a special batman-adv lock class to avoid a false
> positive for each transmission.
>=20
> Reported-by: Linus L=C3=BCssing <linus.luessing@web.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> * fixed comment style
> * fixed commit message
>=20
>  soft-interface.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied in revision e27bb6f.

Thanks,
Marek
