Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 3 Feb 2011 01:19:58 +0100
References: <1296352379-1546-2-git-send-email-sven@narfation.org>
	<1296668238-19323-1-git-send-email-linus.luessing@ascom.ch>
	<201102022242.52008.sven@narfation.org>
In-Reply-To: <201102022242.52008.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201102030119.58808.lindner_marek@yahoo.de>
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

On Wednesday 02 February 2011 22:42:46 Sven Eckelmann wrote:
> > gw_election():
> > * can the if-block before gw_deselect() be ommited, we had a nullpointer
> > 
> >   check for curr_gw just a couple of lines before during the rcu-lock.
> 
> I thought that this if block should be moved to gw_select. And your
> gw_select still has the bug that the bat_priv->curr_gw isn't set to NULL
> when new_gw_node is NULL.

Yes, but we discussed this without Linus.

@Linus: This section will be changed - I'm working on this.

Regards,
Marek
