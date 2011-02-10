Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Feb 2011 15:25:20 +0100
References: <201102031802.52134.lindner_marek@yahoo.de>
	<201102081418.38151.lindner_marek@yahoo.de>
	<20110210104250.GA13038@Sellars>
In-Reply-To: <20110210104250.GA13038@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201102101525.21265.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: Make bat_priv->curr_gw
	an rcu protected pointer
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

On Thursday 10 February 2011 11:42:50 Linus L=C3=BCssing wrote:
> > Would speak anything against re-using the gw_list_lock ?
>=20
> ... as we are usually changing the gw_list more often than the
> curr_gw, so it's not really necessary to let a gw_list change for
> another node wait for a curr_gw_node reassignment to finish.

Well, we only need the list lock when we are adding/deleting items from the=
=20
list which does not happen that often nor is it time critical.


> What is speaking for using the same lock for both, just having
> less spinlocks in total in the code?

Yes.

Regards,
Marek


