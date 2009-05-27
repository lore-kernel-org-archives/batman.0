MIME-Version: 1.0
In-Reply-To: <200905271913.09013.sven.eckelmann@gmx.de>
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<4313f3060905270921p31ea2a10m21d1b9bf61170132@mail.gmail.com>
	<4313f3060905270935ub7f69fct239833a3bcaf742c@mail.gmail.com>
	<200905271913.09013.sven.eckelmann@gmx.de>
Date: Wed, 27 May 2009 12:21:37 -0500
Message-ID: <4313f3060905271021qfdaad6fl8b0b1bb48aaa3348@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@open-mesh.net

On Wed, May 27, 2009 at 12:13 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wr=
ote:
> Ok, so 100% sure that it is a alignment problem. The kernel fixup is alwa=
ys
> activated and shouldn't create such problems as the page faults you menti=
oned
> in your first post. Maybe some communication between kernelland and userl=
and
> has gone wrong. Can you test batmand with batgat and activated alignment
> fixup?
>
> Best regards,
> =A0 =A0 =A0 =A0Sven
>
> (Thanks for the link - it is a real nice overview).
>

Changing the mode from -r 2 to -g 12000 still causes the kernel to
crash with alignment fixup.

On the console I am doing a logread when it happens.  The last thing
printed out before the crash is:
May 27 17:12:23 OpenWrt user.debug kernel: batgat: [batgat_ioctl:238]
disconnect daemon
