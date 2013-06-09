Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 9 Jun 2013 12:02:58 +0800
References: <1370616725-1598-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20130607164648.GN1789@ritirata.org>
In-Reply-To: <20130607164648.GN1789@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201306091202.59085.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Don't handle address updates
	when bla is disabled
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
Cc: Simon Wunderlich <simon@open-mesh.com>, Antonio Quartulli <ordex@autistici.org>

On Saturday, June 08, 2013 00:46:49 Antonio Quartulli wrote:
> On Fri, Jun 07, 2013 at 04:52:05PM +0200, Simon Wunderlich wrote:
> > From: Simon Wunderlich <simon@open-mesh.com>
> > 
> > The bridge loop avoidance has a hook to handle address updates of the
> > originator. These should not be handled when bridge loop avoidance is
> > disabled - it might send some bridge loop avoidance packets which should
> > not appear if bla is disabled.
> > 
> > Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> 
> Since this is a fix and not a new feature, it should target maint.

Applied in revision 518fba1.

Thanks,
Marek
