Return-Path: <rsc@pengutronix.de>
Date: Mon, 10 Mar 2014 22:25:25 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
Message-ID: <20140310212525.GU24339@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Line of Nodes
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

Hi,

I have a little bit strange usecase for a wireless mesh network, and I'm
wondering if B.A.T.M.A.N could be a good choice: my network stations,
which are part of an industrial application, are located in a line:

  Gateway - A1 - A2 - A3 - A4 - A5 - ... - A120

Any station generates data and wants to transmit it to the gateway, with
the smallest possible latency. The distance of the stations is pretty
small: about 3...4 m.

It might happen that someone re-arranges the stations:

  Gateway - A9 - A17 - A1 - A47 - A9 - ... - A6

but the topology stays the same (a line).

It is allowed that one station sends its data to the farest reachable
hop, so i.e. for my first example, if A5 wants to send data and is able
to reach A2, it could directly do so.

- What do you think, could B.A.T.M.A.N be a solution?
- Could the short distance be a problem?
- Is it possible to regulate the transmission power in order to avoid
  disturbance?

Any hint, literature or link is appreciated.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
