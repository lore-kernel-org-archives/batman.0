References: <200711111816.18242.axel@open-mesh.net>	<000401c824b2$ff271870$fd754950$@com>	<2bda28cd0711112357m4864bfb1wbeec080916bd95c1@mail.gmail.com>
	<200711121453.44496.axel@open-mesh.net>
In-Reply-To: <200711121453.44496.axel@open-mesh.net>
Subject: RE: [B.A.T.M.A.N.] vis and batman-exp (rv780-792)
Date: Mon, 12 Nov 2007 15:00:49 +0100
Message-ID: <000001c82534$706df2c0$5149d840$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Content-Transfer-Encoding: quoted-printable
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Thanks, works now!

Pele

-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] On Behalf Of Axel Neumann
Sent: Monday, November 12, 2007 2:54 PM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: Re: [B.A.T.M.A.N.] vis and batman-exp (rv780-792)

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



_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@open-mesh.net
https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


