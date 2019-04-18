Return-Path: <lucaspickstone@gmail.com>
MIME-Version: 1.0
References: <CANDy-jbnAvmYFaPjK2tfTRANFeijK-b7nTKrbMcSUHgkAPH34g@mail.gmail.com>
 <5848806.7i0FG0An4q@bentobox>
 <CANDy-jZ8Ca7mRfWRBJ=xLZL8O0rw1up8emH==B80bodomXUdrA@mail.gmail.com>
In-Reply-To: <CANDy-jZ8Ca7mRfWRBJ=xLZL8O0rw1up8emH==B80bodomXUdrA@mail.gmail.com>
From: Lucas Pickstone <lucaspickstone@gmail.com>
Date: Thu, 18 Apr 2019 18:13:07 +1000
Message-ID: <CAEBXL6VTZjqsNrL6L_DXNt5o3EddQ0hWDiXJ2PZ352ZOLng0Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] Removing a node causing mesh to stop
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, James Matheson <james.matheson@minlog.com.au>, Andrew Corke <andrew.corke@minlog.com.au>

Hi Sven,

Thanks for your super fast reply, and helpful direction and insights.

On Fri, 12 Apr 2019 at 17:12, Sven Eckelmann <sven@narfation.org> wrote:
>
> On Friday, 12 April 2019 08:00:11 CEST Lucas Pickstone wrote:
> > We have problem where our mesh is failing after a node is removed from
> > it. We have a test set up of 3 computers (A, B and C) that can all
> > directly see each other in an ad hoc wireless network.
> >
> > When we remove a node, the mesh between the remaining two nodes
> > continues to work for a time (batman pings get through), but "batctl
> > o" shows nothing recently last-seen. Once it times out after 200
> > seconds, the mesh dies (no further pings via batman get through).
>
> It is normal that the mesh closes down when there are no remaining paths to
> the originators (your originators table was completely empty when the mesh
> broke down). Since it looks like it is working in unicast while the last-seen
> goes up, I would guess that broadcast packets on the underlying layer are
> either not correctly send or not correctly received by the wifi driver/
> firmware on the remaining nodes.
>
> Unsure how this is triggered by removing a single node. But in case you are
> using meshpoint interfaces with mesh_fwding=1 (which is wrong) and a higher
> multicast rate, it could have been that the removed nodes was actually
> relaying the bcast/mcast packets (which might be send with a higher rate as
> suggested on open-mesh.org - or which maybe was automatically selected by the
> ath10k firmware) and the remaining nodes B+C cannot really communicate on the
> selected mcast/bcast rate directly with each other.
>
> > If we bring the disconnected node back up, everything goes back to normal.
>
> What interface mode are you using? meshpoint without mesh_fwding (yes, make
> sure that the mesh parameter mesh_fwding is really set to 0 [1] during your
> tests)? Or IBSS (which would usually mean an ancient firmware or Ben Greear's
> firmware)?
>
> > We're a little bit stuck on how to diagnose/debug what is happening.
> > We thought that maybe the underlying ad hoc network was causing
> > issues, but it seems okay - we can assign IP addresses on the wlan
> > interfaces and ping without interruption through the entire test.
>
> Please check whether it can receive/send broadcast packets in both directions
> during the test (according to your TQ with at least 2/3 of success with a
> bcast ping-pong). This is how OGMs (to generate the content of the originators
> table) are sent. Also make sure that your receive+send the stuff as actual
> broadcast packets. There are ways to let the wifi layer convert these
> broadcast/mcast frames to unicast frames - and this is not allowed for batman-
> adv because B.A.T.M.A.N. IV needs to measure the loss for broadcast packets -
> unicast packets are retransmitted automatically by the wifi components (which
> we don't want).

We did some more testing yesterday and concluded the issue was with
the SparkLAN driver. The driver was provided directly by SparkLAN
(proprietary, I assume), but we did have a few other issues with it in
the past requiring them to give us patches - our confidence in it
isn't too high. It seemed to be running in IBSS mode.

We've had good success so far using an RTL8188RU based device, as well
as a Ralink device. These worked out of the box with the built in
Linux drivers, which increases our confidence level in the
devices/drivers.

> [...]
> > Environment (identical on all computers):
> > - WiFi Card : SparkLAN WPEQ-160ACN(BT)
>
> It is a QCA9377-7 miniPCIe, right? Is it using the PCI pins or the USB
> pins [2]?

Yes, it is a QCA9377-7 and uses PCI pins.

> > - WiFi driver: nl80211
>
> This cannot be the driver - this is the module which allows userspace to
> communicate with cfg80211 (and vice versa). Maybe it is ath10k, ath10k-ct or
> the proprietary QCA monster (which recently received semi working cfg80211
> support).
>
> Kind regards,
>         Sven
>
> [1] iw dev wlan0 get mesh_param mesh_fwding
>     iw dev wlan0 set mesh_param mesh_fwding 0
> [2] https://www.qualcomm.com/media/documents/files/qca9377-product-brief.pdf
>
> PS: Not the best idea to send from a DMARC (quarantine policy) domain to a
> mailing list.

Oops, sorry about that.

Thanks again for all your help.

Lucas Pickstone
