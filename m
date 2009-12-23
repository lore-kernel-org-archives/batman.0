Return-Path: <Eric.Conner@QinetiQ-NA.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Dec 2009 09:56:11 -0500
Message-ID: <94CAE17FD1DB4640BF8FF28D61FDFA8A27303A@RESQNAOEX01.qnao.net>
In-Reply-To: <200912231436.36971.sven.eckelmann@gmx.de>
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A27301B@RESQNAOEX01.qnao.net>
	<200912231436.36971.sven.eckelmann@gmx.de>
From: "Conner, Eric" <Eric.Conner@QinetiQ-NA.com>
Subject: Re: [B.A.T.M.A.N.] [BULK]  Re:  can't start batmand
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>, b.a.t.m.a.n@lists.open-mesh.net

thanks for the info...I got passed that by installing iptables. =20

Now I get a second error=20

Error can't flush routing rules: operation not supported

Any ideas on this one?

Thanks
Eric=20
=20

-----Original Message-----
From: Sven Eckelmann [mailto:sven.eckelmann@gmx.de]=20
Sent: Wednesday, December 23, 2009 8:37 AM
To: b.a.t.m.a.n@lists.open-mesh.net
Cc: Conner, Eric
Subject: [BULK] Re: [B.A.T.M.A.N.] can't start batmand
Importance: Low

Conner, Eric wrote:
> Does anyone know what is the cause and/or solution to this problem?
Either iptables is not installed, iptables not installed in a path which
is is=20
part of $PATH, batmand is not started as root or which is not
installed/not a=20
builtin function of the shell.

Best regards,
	Sven
