Return-Path: <renne.bartsch@gmail.com>
MIME-Version: 1.0
In-Reply-To: <50969D65.5010909@futurec.net>
References: <CAJZtC_=Hjdiu=ZR3EiFuUaPCFu_BoDv9X=frQLqGg9hrSx7kQw@mail.gmail.com>
 <50969D65.5010909@futurec.net>
Date: Sun, 4 Nov 2012 20:49:18 +0100
Message-ID: <CAJZtC_n_EeOYCXK3fpCzA5_K=e=Nbahr9O-d_7bjm5HW9Ld5WQ@mail.gmail.com>
From: Rene Bartsch <renne.bartsch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Broadcasting of GPS-coordinates?
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
To: b.a.t.m.a.n@lists.open-mesh.org

That's an option, of course.

But centralized servers are a single point of failure. So my idea is
any node broadcasts his GPS position with TX- and RX-Gain. Any node
can e.g. use a transparent HTTP-proxy to provide a map to the LAN
attached. In case of a Google Maps overlay, each node can be displayed
on the map with a coverage radius calculated by TX-/RX-gain. By using
the "navigator.geolocation.getCurrentPosition".tag the map can be
centered to the current position of the HTTP-client. Info-boxes on the
nodes can use the RX-/TX-gain of the mouse-over-node and the
HTTP-client to show the theoretically maximum link speed. That would
improve nomadic use und finding gaps in network coverage. The
geographic positions can also be use to optimize routing and
beam-forming, e.g. calculating vector and distance of the first
fresnel zone of the next node.

Regards,

Renne


Am 04.11.2012 18:53:11, schrieb Ray Gibson:

I'm doing this with my nodes but I have a garmin receiver hooked up to a
serial port on a routerstation pro, and using a combination of cat, sed,
awk, bc, and tail to get determine the coordinates and wget to post them
to another server that handles the mapping. Pretty simple actually.

Ray



On 11/4/2012 7:32 AM, Rene Bartsch wrote:
> Hi,
>
> I'm new to B.A.T.M.A.N, so a "Hello" to all! :)
>
> Does B.A.T.M.A.N support some kind of broadcasting node positions?
>
> The idea is to broadcast TX-Power/RX-Gain and the position of a node
> determined by a GPS-device to create maps with network coverage.
>
> Is that possible anyhow?
>
> Regards,
>
> Renne




This communication constitutes an electronic communication within the
meaning of the Electronic Communications Privacy Act, 18 USC 2510, and
its disclosure is strictly limited to the recipient intended by the
sender of this message. This e-mail and any files transmitted with it
are proprietary and intended for the sole use of the individual or
entity to whom they are addressed. They are not to be viewed, shared,
copied or forwarded, regardless to whom, without the expressed
permission of Future Concepts I.S., Inc. If you have received this
e-mail in error, please notify the sender and immediately delete it
from your system. Thank you.
