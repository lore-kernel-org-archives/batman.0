Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAF0yFe4xwGomt=gud+7YZ4jfd_qSX9U=B7QYUhaBUjeJjh_D5Q@mail.gmail.com>
References: <CAL4ejvQpfAQUUupvDpAx3xek3QggQc_Gi81ucm=EERo+aBwFdQ@mail.gmail.com>
 <CAF0yFe4xwGomt=gud+7YZ4jfd_qSX9U=B7QYUhaBUjeJjh_D5Q@mail.gmail.com>
Date: Sat, 8 Aug 2015 23:51:42 +0200
Message-ID: <CAKLmikN+_G6R13LiZDXexnPoim7_w+XdnPUq0S3AxcW14saYow@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Fwd: [Babel-users] Fwd: Why we switched to Babel
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jernej Kos <jernej@kos.mx>, Jenny Ryan <tunabananas@gmail.com>, Marc Juul <juul@labitat.dk>

Hi!

Comments?


Mitar

---------- Forwarded message ----------
From: Jenny Ryan <tunabananas@gmail.com>
Date: Fri, Aug 7, 2015 at 11:41 PM
Subject: [Babel-users] Fwd: Why we switched to Babel
To: babel-users@lists.alioth.debian.org


---------- Forwarded message ----------
From: "Marc Juul" <juul@labitat.dk>
Date: Aug 6, 2015 9:58 AM
Subject: Why we switched to Babel
To: "Jenny Ryan" <tunabananas@gmail.com>
Cc:

When people share their internet we use a tunnel to hide their IP (and
to connect them to the mesh through the Internet). This tunnel takes a
few bytes of overhead. All physical connections, whether they're
ethernet, wifi or even an abstraction like a tunnel, have an MTU
(Maximum Transfer Unit) which is the size of the largest packet that
can be sent over the connection. Normally the MTU is 1500 but since
the tunnel needs a few bytes for overhead the MTU of the tunnel will
be less than 1500.

When people connect to the wifi network called peoplesopen.net they
will connect with an MTU of 1500 since this is the default for wifi.
We need a way to tell them that the MTU is actually less than 1500. In
an IP network (which is at layer 3) there is a built-in system for
dealing with this. If any router receives a packet larger than what it
can pass on through the next connection (in this case through the
tunnel) it can report back to the client using the ICMP protocol (a
companion protocol to IP, and the protocol used for ping) that the
packet was too big and the client can then adjust its MTU accordingly.

For batman-adv, because it is a layer 2 protocol, we don't have this
system available. We tried different tactics such as using DHCP to
tell the clients the MTU they should use, but it turns out that many
operating systems completely ignore this. We tried something called
TCP MSS clamping, which is a bit of a dirty hack, but that only works
for TCP, which is a problem since UDP is widely used for e.g. VOIP,
video streaming, gaming, torrenting, etc.

Even combining the different tricks we still had a problem where some
operating systems would get in trouble if they tried to send large UDP
packets. We had a moment where we realized that the only types of
common communication that wouldn't work on this mesh would be
torrenting and video streaming from windows computers, and joked about
that being a feature instead of a bug :) but in the end we switched to
Babel.

There was another reason: In batman-adv the MAC address is the
identifier used for each device. It is possible to configure many
devices to randomize their MAC address but it needs the user to do
something, so most people will never know to do it. Having the MAC
address as the identifier makes it pretty easy for anyone to track
anyone else as they move about the city, as long as they know the MAC
address of e.g. their phone, which it is easy to discover if you are
ever in the same room with them, just by listening to network traffic.
We had some ideas for how this could be fixed, but the potential
solutions we came up with were never satisfactory.

For mesh, each time a user connects to a new node they get a new IP
address. In the future we may implement roaming support which will let
people keep their IP as they move around the city, but it will still
switch after e.g. 10 minutes, so tracking people becomes much harder.

That's a lot of text, but eh it's a complicated issue. It sounds like
you're having many late night conversations. Hope it is enjoyable!

--
marc/juul




_______________________________________________
Babel-users mailing list
Babel-users@lists.alioth.debian.org
http://lists.alioth.debian.org/cgi-bin/mailman/listinfo/babel-users


-- 
http://mitar.tnode.com/
https://twitter.com/mitar_m
