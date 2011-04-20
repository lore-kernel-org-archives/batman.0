Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201104191345.36184.lindner_marek@yahoo.de>
References: <201104191345.36184.lindner_marek@yahoo.de>
Date: Thu, 21 Apr 2011 00:07:05 +0200
Message-ID: <BANLkTi=HLWOfegFotgAFZnt3h2pgDhFHDA@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.1.0 released
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Update some nodes to this version will cause compatibility problem
with previous version ?

2011/4/19 Marek Lindner <lindner_marek@yahoo.de>:
>
> The B.A.T.M.A.N. team is publishing its second 2011 release - 2011.1.0,
> containing major code changes under the hood to improve performance and
> scalability plus the usual set of bug fixes. As the kernel module always
> depends on the Linux kernel it was compiled against, it does not make sen=
se to
> provide binaries on our website. As usual, you will find the signed tarba=
lls
> in our download section:
>
> http://downloads.open-mesh.org/batman/releases/batman-adv-2011.1.0/
>
> as well as prepackaged binaries in your distribution.
>
>
> Thanks
> ------
>
> Thanks to all people sending in patches:
>
> =A0* Jesper Juhl <jj@chaosbits.net>
> =A0* Linus L=FCssing <linus.luessing@web.de>
> =A0* Lucas De Marchi <lucas.demarchi@profusion.mobi>
> =A0* Marek Lindner <lindner_marek@yahoo.de>
> =A0* Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> =A0* Sven Eckelmann <sven@narfation.org>
> =A0* Sylvestre Ledru <sylvestre.ledru@scilab.org>
>
>
> batman-adv
> ----------
>
> The principal objective while working towards this release was to remove =
the
> originator hash lock (also known as the batman-adv private "big kernel lo=
ck").
> It was introduced in the very early stages of the batman-adv development =
which
> proved to be a simple and effective way to protect all originator node
> information from parallel access. As time went on, the module grew and ga=
ined
> more features - most of them making heavy use of the aforementioned origi=
nator
> hash lock as it safeguarded the module's central pool of data. It thereby
> became a major bottleneck because almost every piece of code had to acqui=
re
> this very same lock. An extensive effort was necessary to replace the
> originator hash lock by fine grained locking which only locks the bare mi=
nimum
> of data to improve the module's performance and scalability.
> Other parts of the code received attention too: After learning about
> bufferbloat in one of Jim Getty's talks we revisited our own buffering
> settings and decided to set the txqueuelen to zero. Fragmented packets ar=
e now
> properly linearized upon receipt to avoid a crash if the network card spl=
its
> the packet into smaller chunks. The fragment numbering became more robust=
 and
> several spelling mistakes have been corrected.
>
>
> batctl
> ------
>
> To render batctl more versatile packet dump functionality support for raw=
 WiFi
> packet decapsulation was added. This allows to keep an eye on your networ=
k
> using interfaces in monitor mode which output packets including all WiFi
> headers. The bug causing to display an erroneously warning message when
> changing gateway settings has been squashed. Unused code and the last tra=
ce of
> our subversion integration in the Makefile have been removed.
>
>
> Happy routing,
> The B.A.T.M.A.N. team
>
