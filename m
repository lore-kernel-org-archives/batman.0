From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] vis and batman-exp (rv780-792)
Date: Mon, 12 Nov 2007 14:53:44 +0100
References: <200711111816.18242.axel@open-mesh.net>
	<000401c824b2$ff271870$fd754950$@com>
	<2bda28cd0711112357m4864bfb1wbeec080916bd95c1@mail.gmail.com>
In-Reply-To: <2bda28cd0711112357m4864bfb1wbeec080916bd95c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200711121453.44496.axel@open-mesh.net>
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

thanks for the tip. Now changed this in rv 794

Modified:
=A0 =A0trunk/batman-experimental/batman.h
Log:
change VIS_COMPAT_VERSION to 21

/axel

On Montag 12 November 2007, Stefano Scipioni wrote:
> 2007/11/11, Predrag Balorda <predrag.balorda@gmail.com>:
> > Does batman-exp work with vis (B.A.T.M.A.N. visualisation server
> > 0.3-beta)? I don't seem to be getting any topology info but batman beta
> > 0.3 was working with the same setup.
> >
> > Pele
>
> I changed in vis.h:
> #define VIS_COMPAT_VERSION 21
>
> Stefano
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n



