Return-Path: <ff@stephan.homeunix.net>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@stephan.homeunix.net>
In-Reply-To: <trinity-bad41429-4528-47e4-81dc-ed7ec370f6d5-1357277691439@3capp-webde-bs44>
Date: Fri, 4 Jan 2013 11:18:52 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8C0848F-2A71-4F5E-A3FA-561C0580F9B6@stephan.homeunix.net>
References: <201301032300.04942.lindner_marek@yahoo.de>
 <6D44E9FE-9AC6-4747-8BF6-52E6647C0625@stephan.homeunix.net>
 <201301040005.05457.lindner_marek@yahoo.de>,
 <11DE1CAB-ADE0-429F-97F1-ED38894E1CE1@stephan.homeunix.net>
 <trinity-bad41429-4528-47e4-81dc-ed7ec370f6d5-1357277691439@3capp-webde-bs44>
Subject: Re: [B.A.T.M.A.N.] Packet-Loss-Peaks in a Freifunk-Network
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Linus,

nice to hear from you again.

Am 04.01.2013 um 06:34 schrieb Linus L=FCssing:

> What were the exact batman-adv versions at the time you made those =
graphs for the shown nodes as well as any intermediate nodes (although =
if I got your setup right then the nodes in those graphs do not have any =
intermediate batman-adv hops involved, do they?)?
>=20
> Does it make a difference if you make the entries in the neighbor =
solicitation table permanent (e.g. with 'ip -6 neigh')?
>=20
> Do the same spikes appear with a 'batctl ping' (or if adding such =
graphs is quite a hassle then at least, is the overall 'batctl ping' =
packet loss similar to the one from the ip ping)?
>=20
> Do you see any "Changing route towards" events in the batman-adv logs =
between these supposedly always direct neighbors - if yes, maybe with a =
similar frequency? Or even better, check whether the same packet loss =
appears when isolating any of such pairs of nodes so that no batman-adv =
route changes could happen at all.
>=20

For some reason, the spikes disappeared around midnight - and I don't =
know why.
Maybe batman-adv converged to a different plan (or converged at all) or =
the Flying Spaghetti Monster our network to work nowadays.

I'll go one inspecting this issue, but I cannot answer any of your =
questions. :-(

Keep smiling
yanosz=
