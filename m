Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Feb 2011 14:57:56 +0100
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-3-git-send-email-linus.luessing@ascom.ch>
	<20110210124544.GC13038@Sellars>
In-Reply-To: <20110210124544.GC13038@Sellars>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201102101457.57316.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/7] batman-adv: Correct rcu refcounting
	for softif_neigh
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

On Thursday 10 February 2011 13:45:44 Linus L=C3=BCssing wrote:
> > -		goto found;
> > +		goto out;
> >=20
> >  	}
>=20
> Hmm, we could do a rcu_read_unlock() here, already, I think. Would
> it be better to do so, keeping the rcu grace period as small as
> possible?

Can you be more specific where "here" is ? Instead of the "goto out" ?


> The rest of the new atomic handling seems fine. Just two more
> things I noticed while reading the softif_neigh specific code:
> bat_priv->softif_neigh needs to be changed to a rcu-protected
> pointer.

Agreed.


> There's a race condition in softif_neigh_seq_print_text(), between
> the rcu_read_unlock() and rcu_read_lock() the number of
> softif_neigh's can have increased and there's no check for
> accidentally writing outside of the allocated buffer.

Also correct - are you going to send a patch ?

Regards,
Marek
