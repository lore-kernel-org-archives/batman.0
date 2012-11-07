Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 7 Nov 2012 23:12:10 +0800
References: <1352129674-11080-1-git-send-email-ordex@autistici.org>
 <20121105160542.GA3534@ritirata.org>
In-Reply-To: <20121105160542.GA3534@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211072312.10727.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix ROAM flag de-selection
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

On Tuesday, November 06, 2012 00:05:42 Antonio Quartulli wrote:
> On Mon, Nov 05, 2012 at 04:34:34PM +0100, Antonio Quartulli wrote:
> > In tt_global_add() the ROAM flag is improperly unset. This makes the
> > next check fail and so preventing emptying the old originator_list for
> > the involved tt_global_entry
> >
> > This was introduced by ("batman-adv: roaming handling mechanism
> > redesign")
> >
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> 
> Ops, I just forgot:
> 
> Reported-by: Mike Burmeister-Brown <mike@open-mesh.com>

Applied in revision 846815f.

Thanks,
Marek
