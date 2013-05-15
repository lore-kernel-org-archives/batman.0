Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 15 May 2013 15:46:29 +0800
References: <1368603288-1931-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1368603288-1931-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305151546.29426.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add declaration in compat
	code
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

On Wednesday, May 15, 2013 15:34:48 Antonio Quartulli wrote:
> Add missing declaration in compat.h.
> 
> Introduced by 1bd816198771e2cbd44948a12aaca3ac33993d9d
> "batman-adv: don't use call_rcu if not needed"
> 
> Reported-by: Daily build check <postmaster@open-mesh.org>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  compat.h | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision e142720.

Thanks,
Marek
