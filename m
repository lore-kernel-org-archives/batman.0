Return-Path: <gwirth79@gmail.com>
Message-ID: <4B47674B.6010508@gmail.com>
Date: Fri, 08 Jan 2010 09:11:39 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <200912181714.58212.lindner_marek@yahoo.de>	<DE721D43-8031-4174-8357-DE4A475A7898@dd19.de>	<201001072123.32104.lindner_marek@yahoo.de>	<914B198A-C2DA-4222-9306-B81CFFE88284@dd19.de>
	<20100107214343.GA2554@Linus-Debian>
In-Reply-To: <20100107214343.GA2554@Linus-Debian>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Maximum MTU (was Re:  B.A.T.M.A.N. V outlook)
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 01/07/2010 01:43 PM, Linus L=FCssing wrote:
[snip]
> In general, batman-adv adds a little header of 24 Bytes. But this
> kind of extra cost also applies to packets between batman nodes,
> not only when a packet comes from the connected network. So if you
> are bridging any other networks/hosts into the mesh network (i.e.
> bridging eth0 + bat0) does not matter, you should just a) increase
> the MTU of the mesh-interfaces to 1524 which is usually not a
> problem for wifi interfaces or b) decrease the MTU on all hosts to
> 1476 (usually not so do-able).

Would you happen to know what the maximum MTU you could use on the
wireless interface?

For example, if I have an ethernet network that can support jumbo frames
like on a gigabit interface, how large of an MTU could I use on the
wireless interface. In my case I'm using Atheros wireless devices, so I
don't know if that matters.

Gus
