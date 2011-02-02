Return-Path: <jay.busch@gmail.com>
Message-ID: <4d49eebc.a735ec0a.47e4.06c7@mx.google.com>
MIME-Version: 1.0
content-class: 
From: jay.busch <jay.busch@gmail.com>
Date: Wed, 2 Feb 2011 18:54:27 -0500
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting
 for gw_node
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



Sent from my HTC PURE=E2=84=A2, a Windows=C2=AE phone from AT&T

-----Original Message-----
From: Marek Lindner <lindner_marek@yahoo.de>
Sent: Wednesday, February 02, 2011 2:49 PM
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n=
@lists.open-mesh.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Re: batman-adv: Correct rcu refcounting=
 for gw_node

On Wednesday 02 February 2011 18:37:18 Linus L=C3=BCssing wrote:
> So after some more discussions with Marek and Sven, it looks like we
> have to use the rcu protected macros rcu_dereference() and
> rcu_assign_pointer() for the bat_priv->curr_gw and curr_gw->orig_node.
>=20
> Changes here also include moving the kref_get() from unicast_send_skb()
> into gw_get_selected(). The orig_node could have been freed already at
> the time the kref_get() was called in unicast_send_skb().

I'd suggest you make a standalone patch because the patches address differe=
nt=20
problems.

Thanks,
Marek

