Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 14 Nov 2012 21:13:36 +0800
References: <1352886828-24651-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20121114115907.GA29879@ritirata.org>
In-Reply-To: <20121114115907.GA29879@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211142113.37050.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: pass value in batadv_hash_bytes
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Wednesday, November 14, 2012 19:59:07 Antonio Quartulli wrote:
>   On Wed, Nov 14, 2012 at 10:53:48 +0100, Simon Wunderlich wrote:
> > Passing the hash value by reference creates unneeded overhead. Pass by
> > value instead.
> >
> > 
> >
> > Reported-by: David Miller <davem@davemloft.net>
> > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> 
> I think this was not meant to be an RFC :-)
> And I suppose this patch should be applied to next and no to master,
> because it should be merged with the next pull request.

Aren't we supposed to remove the inline tag as well ?

Cheers,
Marek
