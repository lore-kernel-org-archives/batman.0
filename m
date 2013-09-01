Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 Sep 2013 00:49:03 +0800
References: <1377790385-24720-1-git-send-email-lindner_marek@yahoo.de>
 <201309011248.44874.lindner_marek@yahoo.de>
 <20130901080543.GA1871@ritirata.org>
In-Reply-To: <20130901080543.GA1871@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309020049.03364.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: limit local translation
	table max size
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

On Sunday, September 01, 2013 16:05:43 Antonio Quartulli wrote:
> > Upon reading this function a realized this "tt_diff_len = 0" mechanism is
> > buggy. For instance, the changes_list list is not purged but keeps
> > growing until it magically fits the ogm diff again. Or checking
> > bat_priv->soft_iface-
> > 
> > >mtu isn't terribly accurate either. The more I looked the more my head
> > 
> > started to spin. Suddenly, I was convinced we don't need the check
> > anymore because we have the fragmentation but you are right - it won't
> > help here. I'll add the check again but be aware that it is broken.
> 
> Right, there is a bug. We should purge the list in any case, even if
> tt_diff_len is 0.
> 
> Yes, checking tt_diff_len against bat_priv->soft_iface->mtu is probably not
> correct..shall we check it against the mtu of the primary interface?
> Anyway, this is outside the scope of this patch.

Checking the primary interface is not enough either. You would need to know 
how much space is left in the OGM itself (assuming nobody else is going to 
occupy it before you do). All registered tvlvs and their content have to be 
taken into account. As well as headers and other stuff ...

Cheers,
Marek
