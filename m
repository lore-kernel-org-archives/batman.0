Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Apr 2013 15:06:57 +0800
References: <1367050948-7626-1-git-send-email-lindner_marek@yahoo.de>
 <20130427160132.GA3179@ritirata.org>
In-Reply-To: <20130427160132.GA3179@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304291506.57622.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: check proto length before
	accessing proto string buffer
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Sunday, April 28, 2013 00:01:32 Antonio Quartulli wrote:
>   On Sat, Apr 27, 2013 at 04:22:28 +0800, Marek Lindner wrote:
> > batadv_param_set_ra() strips the trailing '\n' from the supplied
> > string buffer without checking the length of the buffer first. This
> > patches avoids random memory access and associated potential
> > crashes.
> >
> > 
> >
> > Reported-by: Sasha Levin <sasha.levin@oracle.com>
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> Thank you for fixing this!
> 
> Please, merge this patch in maint.

Applied in revision aa7d19a.

Regards,
Marek
