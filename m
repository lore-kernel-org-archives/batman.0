From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] proposal for batman-status release
Date: Fri, 29 Jun 2007 19:57:08 +0200
References: <200706281838.38789.axel@open-mesh.net>
	<560c7c9a0706281021h2be71470i9fb76e24ac8e5724@mail.gmail.com>
In-Reply-To: <560c7c9a0706281021h2be71470i9fb76e24ac8e5724@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200706291957.08319.axel@open-mesh.net>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello

On Thursday 28 June 2007 19:21, Benjamin Henrion wrote:
> "=B7 The setup for the following emulation consisted of an "Intel(R)
> Core(TM)2 CPU T7200 @
>   2.00GHz" with a 32-bit gentoo Linux OS and using openVZ for
> virtualization of individual
>   nodes."
>
> Is it possible to have a copy of the 32-bits binary to reproduce your
> tests?

generally we used a current batman from the stable 0.2.x branch, compiled=20
(gcc-4.1 with the following flags), and finally stripped it.

The exact binary is batmand-02-dynamic-stripped downloadable from
http://open-mesh.net/batman/documentation/evaluation/setup-details/batman-0=
.2.x-modified.tgz

Further details are about the setup are given here:
http://open-mesh.net/batman/documentation/evaluation/setup-details/

However, this doc is not yet complete. I`ll continue the description soon...


ciao,
axel

>
> Otherwise, results looks great. I will try batman soon on an old
> usr2450, with 33Mhz cpu, and I would be interested to connect it to
> the "simulator", in order to populate its routing table.
>
> On 6/28/07, Axel Neumann <axel@open-mesh.net> wrote:
> > Hello,
> >
> > we have summarized the current development status of B.A.T.M.A.N. in so=
me
> > kind of report available at
> > http://open-mesh.net/batman/documentation/batman-status.pdf
> >
> > Thanks to all the people who made this development possible and those w=
ho
> > motivated us to finally catch up on this documentation issue.
> >
> > Please tell us what you like, what you don't, and what you are missing.
> >
> > fondest regards,
> > marek, elektra, axel
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

