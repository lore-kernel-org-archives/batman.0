Return-Path: <rrbothra@gmail.com>
MIME-Version: 1.0
References: <CADhofF8ExwW+kYPDTX1W4ZZz_6gs3zEvzu_7oe1WrkP3-+fpiQ@mail.gmail.com>
 <1752987.3nn1Mqi339@bentobox>
In-Reply-To: <1752987.3nn1Mqi339@bentobox>
From: Rahul Bothra <rrbothra@gmail.com>
Date: Thu, 25 Jun 2020 20:46:16 +0530
Message-ID: <CADhofF-z2bM0GxO=CeSuj3hBcBB6q8-jTwN7BFuh4SQ8EY17Sw@mail.gmail.com>
Subject: Re: bits 10 to 15 in OGM packets
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Tom Henderson <tomh@tomh.org>, tahiliani.nitk@gmail.com

Thanks, is there a published documentation / memo for B.A.T.M.A.N. V
currently present in the kernel tree?
If not, I'd be happy to join in writing one as I work on the NS-3 model.

Thanks
Rahul Bothra

On Thu, Jun 25, 2020 at 7:36 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Thursday, 25 June 2020 15:22:46 CEST Rahul Bothra wrote:
> > I was going through the Internet Draft for B.A.T.M.A.N, and wanted to
> > confirm if the bits 10 to 15 in the OGM packet are supposed to be all
> > zeroes always?
>
> Please don't implement the legacy draft which was never finished. This is
> really, really, really, really, really, really, really, really, really,
> really, really, really, really, really, really, really, really, really,
> really, really, really, really, really, really, really, really, really,
> really, really, really, really, really, really, really, really, really,
> really, really, really, really, really, really, really, really, really,
> really, really, really, really outdated.
>
> But the batmand layer 3 compat version 5 handled these as reserved flags. So
> it would have been a good idea at that time not to leave them in a random
> state and just set them to 0. This would have allowed announcements of
> additional features in the future.
>
>
> See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
> include/uapi/linux/batadv_packet.h for the B.A.T.M.A.N. IV and B.A.T.M.A.N. V
> layer 2 packet definitions.
>
> Kind regards,
>         Sven
