Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 12 Feb 2013 13:17:16 +0800
References: <201302111710.04911.lindner_marek@yahoo.de>
 <20130211201428.GB16760@ritirata.org>
In-Reply-To: <20130211201428.GB16760@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302121317.16254.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] create batman-adv interfaces with netlink v3
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
Cc: Sven Eckelmann <sven@narfation.org>

On Tuesday, February 12, 2013 04:14:28 Antonio Quartulli wrote:
> > Changes since v2:
> >  * Reference counting bugfix in batadv_add_slave() & batadv_del_slave()
> >  * Master settings & compat support
> > 
> > Kudos to Antonio for providing the compat support and debugging the
> > interface to the bitter end!
> 
> But..has the patchset been rebased on top of the latest master? Git am is
> complaining and cannot apply the patches.

Yes, it is based on master. You can check here:
http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/marek/netlink_if

Cheers,
Marek
