Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2009 13:10:31 +0800
Message-ID: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D250@MBX21.stu.nus.edu.sg>
In-Reply-To: <mailman.3218.1243445413.960.b.a.t.m.a.n@open-mesh.net>
From: "Kartik Muralidharan" <kartik_m@nus.edu.sg>
Subject: Re: [B.A.T.M.A.N.] MultiRadio Batman
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
To: b.a.t.m.a.n@open-mesh.net




>Right, that is still on open point on my ToDo. I'd like to automate
that if=20
>possible but did not have a good idea how to do that.=20

>Kartik: Any idea how roofnet is doing it ? Config ?


@Marek

Roofnet does not consider multiple interfaces. It was meant to work over
only a single radio. The work around is to consider WCETT metric rather
than ETT that is currently used in roofnet.


