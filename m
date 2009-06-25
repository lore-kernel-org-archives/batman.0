Return-Path: <andrew.lunn@ascom.ch>
Date: Thu, 25 Jun 2009 21:47:07 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090625194707.GD3457@ma.tech.ascom.ch>
References: <20090624082845.GS19149@ma.tech.ascom.ch>
	<20090624210631.GA4522@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20090624210631.GA4522@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] originator tq_avg oscilations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Wed, Jun 24, 2009 at 11:06:31PM +0200, Linus L=FCssing wrote:
> > What ideas do you have for improving the algorithms. Depending on the
> > scale of work needed i might have some time to do some coding.

> I've been sending Simon and Marek some emails lately about some
> ideas for dynamic originator intervals. Basically the idea was,
> to not use any external devices like GPS (weather station, news
> paper articles, fortune tellers, ...) for detecting the
> dynamicness of the environment and changing the OGM-interval on
> those pieces of information, but that the information about the
> changes of the TQ-values over time should be sufficient to detect
> changing conditions.

That probably does not help my situation when a node goes away. I'm
guessing a node in a vehicle will vanish from the mesh very quickly.
I don't currently know in our situation if it is normal to perform a
shutdown, or if it just drives off.

It is not a general solution, but i did wonder about adding support
for signalling a node is shutting down. It could say broadcast a
BAT_BYE message, 5 times at 20ms intervals. Neighbors who receive such
a message would then take the originator straight out of their tables,
picking another neighbor for the next hop if possible.

Getting the ordering right during shutdown could be interesting. We
need the bat0 interface to be put down before other interfaces it
depends on. So long as the init.d files have the correct priority this
should be possible.=20

> If you (or others) might be interested, I could translate those
> ideas to English and post them on our wiki-page. I would love to
> get some more feedback and enhancements to them.

I would be interested. By the way, what language are they currently
in? I read German if that is any help.

    Andrew
