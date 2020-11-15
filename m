Return-Path: <ap420073@gmail.com>
MIME-Version: 1.0
References: <20201115103004.30618-1-ap420073@gmail.com> <4602363.31r3eYUQgx@sven-edge>
In-Reply-To: <4602363.31r3eYUQgx@sven-edge>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 15 Nov 2020 20:48:19 +0900
Message-ID: <CAMArcTWH0Lk1nFOcva2+_Yhdgt9q8XA=QAVjShCFeGFoK04bdQ@mail.gmail.com>
Subject: Re: [PATCH v3 net] batman-adv: set .owner to THIS_MODULE
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org

On Sun, 15 Nov 2020 at 19:40, Sven Eckelmann <sven@narfation.org> wrote:
>

Hi Sven

> On Sunday, 15 November 2020 11:30:04 CET Taehee Yoo wrote:
> > If THIS_MODULE is not set, the module would be removed while debugfs is
> > being used.
> > It eventually makes kernel panic.
> >
> > Fixes: 9e466250ede3 ("batman-adv: Prefix bat_debugfs local static functions with batadv_")
>
> This Fixes: is bogus. The code was already present with the first commit
> c6c8fea29769 ("net: Add batman-adv meshing protocol"). I have now changed it
> before it was applied to the net branch.
>
> >  net/batman-adv/log.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
> > index a67b2b091447..c0ca5fbe5b08 100644
> > --- a/net/batman-adv/log.c
> > +++ b/net/batman-adv/log.c
> > @@ -180,6 +180,7 @@ static const struct file_operations batadv_log_fops = {
> >       .read           = batadv_log_read,
> >       .poll           = batadv_log_poll,
> >       .llseek         = no_llseek,
> > +     .owner          = THIS_MODULE,
> >  };
> >
> >  /**
> >
>
> General info: This causes a merge problem with the net-next branch [1] because
> the debugfs files were dropped in preparation of the Linux 5.11 release in
> 2021. I might rebase the currently pending patches for net-next to avoid this
> weird merge conflict.
>
> Kind regards,
>         Sven
>
> [1] https://git.open-mesh.org/linux-merge.git/shortlog/refs/heads/batadv/net-next

Thank you so much for fixing the Fixes tag and providing information.
Thanks again,
Taehee Yoo
