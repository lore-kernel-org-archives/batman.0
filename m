Return-Path: <bethencourt@gmail.com>
MIME-Version: 1.0
Sender: bethencourt@gmail.com
In-Reply-To: <20100404135621.GA16351@lunn.ch>
References: <1270341625-28764-1-git-send-email-luisbg@ubuntu.com>
	<201004040312.28481.sven.eckelmann@gmx.de>
	<p2x506b70dc1004031845p81705070o325d93f839c80e9a@mail.gmail.com>
	<20100404135621.GA16351@lunn.ch>
Date: Sun, 4 Apr 2010 15:56:37 +0100
Message-ID: <k2t506b70dc1004040756rea2635f9g358ddbb953ae2bf9@mail.gmail.com>
From: Luis de Bethencourt <luisbg@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] Staging: batman-adv: fix whitespace
	style issues
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: devel@driverdev.osuosl.org, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, gregkh@suse.de, linux-kernel@vger.kernel.org

On Sun, Apr 4, 2010 at 2:56 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Sorry about the conflict, thanks for redoing the changes. Where can I
>> find the current and development branches? I want to avoid doing this
>> mistake again in the future. Specially since I'm planning on doing
>> some janitorial work on Staging for a while if it's OK with you guys.
>> I see it as nice experience and practice while learning and getting
>> ready for more valuable contributions :)
>
> Sven has told you about how batman uses different repositories. You
> can find some more information at:
>
> http://www.open-mesh.org/wiki/UsingBatmanGit
>
> When working on other staging drivers i suggest you work on either the
> linux-next tree, or contact the driver maintainers and ask if they
> have there own development tree. Staging drivers tend to be fast
> moving. They change a lot. What is in the current release kernel,
> which is effectively 3 months old, can be very different to the latest
> development version. I've received many patches to things we have
> fixed months ago and are either waiting in linux-next for the next
> kernel release, or our in or development tree. I'm sure the same
> applies to other drivers in staging.

Andrew,

Oh thanks! After learning about this about the batman development tree
I wondered how to find out where the equivalent branches for other
projects are. Checking the linux-next branch sounds great. I'm still
learning the details of the kernel development process, I knew about
this branch but now I understand it's function and purpose.

I will also contact driver maintainers before sending a patch even if
it is small. I appreciate hugely that Sven redid my changes with the
new branch, but I don't want to create more work for a maintainer in
the future. On the contrary, I want to help :)

>
> Another option for interesting work to get involved in the kernel is
> to ask GregKH if there is a staging driver which is not being actively
> worked on. Some drivers just get dumped there and nobody spends the
> time and effort needed to get them merged. After a while they get
> thrown out of the staging. You could adopt such a driver, get hold of
> the hardware and do the work needed to get it out of staging and into
> the main tree.
>
> =A0 =A0Andrew

That sounds awesome. I will contact him and see if there is any orphan
driver that is of my interest and that I can get my hands on the
hardware. I presume it is a good starting point since it involves
doing the last steps of the process and not starting something from
scratch. A good angle to understand the 'big picture' of driver
development better.

Thanks a million for the suggestions and help. :)

Luis


PD: By the way, I know top posting is a big no-no. is inline posting
ok? in cases like your email where the two paragraphs address diferent
topics I find it more logical to down-post after each one. just
checking before I continue doing so.
