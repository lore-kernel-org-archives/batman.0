Message-ID: <560c7c9a0806050617o215bc764w9beb5796b9bb5539@mail.gmail.com>
Date: Thu, 5 Jun 2008 15:17:57 +0200
From: "Benjamin Henrion" <bh@udev.org>
Sender: zoobab@gmail.com
Subject: Re: [B.A.T.M.A.N.] Multiple radios to improve throughput
In-Reply-To: <1212669547.6960.7.camel@mkellyDell>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48448358.4070505@changind.com>
	<000601c8c553$3630bba0$a29232e0$@com>
	<1212669547.6960.7.camel@mkellyDell>
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

On Thu, Jun 5, 2008 at 2:39 PM, Mark Kelly <mark.kelly@cadre5.com> wrote:
> I too would like to see this benchmark setup.  I have a private mesh that
> I've been using batman and olsr on that consists of about 8 nodes that end
> up spread out of about a 2000m x 2000m area and right now I'm only using one
> radio for the mesh.  I'm pushing video from about 4 of these nodes and if I
> try to do more than 2 hops with the video I see drastic drops in the video
> performance.
>
> I use Avila Gateworks boards that have 533 MHz Intel Xscale processors and
> I've never seen the cpu even close to taxed by batman, olsr, or the radios,
> as a point of reference for the original poster.  They also have a newer
> board with a 633 Mhz cpu.

I would like to see some test of performance with mesh with 2 radios.

Hopping on the same radio as most freifunk network does is a disaster
in terms of performance, because the radio is not full-duplex.

I have bought 12 foneras to make a test with 6 nodes (2 foneras per
node), to see if OLSR chooses the fastest route in terms of
throughput, and it does not. I have to try to play with
LinkQualityMult on the ethernet link.

Does someone has an firmware image with batman for lafonera I can use with ap51?

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
