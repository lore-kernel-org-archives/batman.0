From: Axel Neumann <axel@open-mesh.net>
Subject: Re: AW: [B.A.T.M.A.N.] 0.3-beta-rv779 and rv780
Date: Tue, 6 Nov 2007 10:57:26 +0100
References: <709285.93018.qm@web26901.mail.ukl.yahoo.com>
In-Reply-To: <709285.93018.qm@web26901.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200711061057.26215.axel@open-mesh.net>
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

On Dienstag 06 November 2007, Marek Lindner wrote:
> > The non-usual setup: you have different parts of your mesh operating in
> >
> > different subnets you need an additional ip rule to make the nodes in
>
>  the
>
> > non-homed subnet reachable from a node which has no interface in that
>
>  subnet.
>
> > So for example, if your setup looks like:
> >      A---------------------B1_B2---------------C
> > 10.0.0.1/24       10.0.0.2/24 10.0.1.2/24  10.0.1.3/24
> >
> > the easiest way to do achieve that at A and C is:
> > $ ip rule add from all pref 6500 t 66
>
> Wouldn't be HNA the much better solution ? Node B should announce one of
> the networks. To not rebroadcast OGMs from the wrong network batman
> should check if the received originator IP is within the own network.

I am not sure if I understand you correct. Do you mean that (instead of=20
re-broadcasting As OGMs on interface B2) node B should announce 10.0.0.0/24=
=20
as HNA on B2 ?

ciao,
axel

>
>
>
> Regards,
> Marek
>
>
>
>
>       Jetzt Mails schnell in einem Vorschaufenster =FCberfliegen. Dies und
> viel mehr bietet das neue Yahoo! Mail - www.yahoo.de/mail
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n



